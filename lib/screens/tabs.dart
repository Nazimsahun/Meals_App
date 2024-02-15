import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/Provider/fevoraite_provider.dart';
import 'package:meals/Provider/filters_provides.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/mian_drawer.dart';

const KInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegatarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMessege(String message) {}

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterdMealsProvider);
    Widget ActivePage = CategoriesScreen(
      availbaleMeal: availableMeals,
    );
    var ActivePagetitle = 'categories';
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      ActivePage = MealsScreen(
        meals: favoriteMeals,
      );
      ActivePagetitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(ActivePagetitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: ActivePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.set_meal,
                ),
                label: 'Categorey'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.star,
                ),
                label: 'Favorites'),
          ]),
    );
  }
}
