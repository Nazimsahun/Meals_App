import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/Provider/Provider_meals.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegatarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegatarian: false,
        });
  void setFilters(Map<Filter, bool> chosenfilters) {
    state = chosenfilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterprovied = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);

final filterdMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final ActiveFilters = ref.watch(filterprovied);
  return meals.where((meal) {
    if (ActiveFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (ActiveFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (ActiveFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (ActiveFilters[Filter.vegatarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
