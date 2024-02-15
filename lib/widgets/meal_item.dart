import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/material_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});
  final Meal meal;
  final void Function(BuildContext context, Meal meal) onSelectMeal;

  String get ComplexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get AfforbilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(context, meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                    color: Colors.black54,
                    child: Column(
                      children: [
                        Text(
                          meal.title,
                          maxLines: 2,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MealItemTrait(
                                lable: '${meal.duration} min',
                                icon: Icons.schedule),
                            const SizedBox(
                              width: 12,
                            ),
                            MealItemTrait(
                                lable: ComplexityText, icon: Icons.work),
                            const SizedBox(
                              width: 12,
                            ),
                            MealItemTrait(
                                lable: AfforbilityText,
                                icon: Icons.attach_money),
                          ],
                        )
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
