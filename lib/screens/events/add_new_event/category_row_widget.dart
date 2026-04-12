import 'package:evently_c18/models/category_model.dart';
import 'package:evently_c18/screens/events/provider/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CustomCategoryRow extends StatelessWidget {
  const CustomCategoryRow({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    CategoryModel selectedCategory = Provider.of<EventsProvider>(
      context,
    ).selectedCategory;
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,

        children: [
          ...CategoryModel.generateCategories().map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Row(
                  spacing: 4,
                  children: [
                    SvgPicture.asset(
                      e.iconPAth,
                      colorFilter: selectedCategory.id == e.id
                          ? ColorFilter.mode(Colors.white, BlendMode.srcIn)
                          : null,
                    ),
                    Text(e.title),
                  ],
                ),
                labelStyle: theme.textTheme.titleMedium!.copyWith(
                  color: selectedCategory.id == e.id ? Colors.white : null,
                ),

                selected: selectedCategory.id == e.id,
                onSelected: (value) {
                  Provider.of<EventsProvider>(
                    context,
                    listen: false,
                  ).editSelectedCategory(e);
                },
                showCheckmark: false,
                backgroundColor: theme.cardColor,
                selectedColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
