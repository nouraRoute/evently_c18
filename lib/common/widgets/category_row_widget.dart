import 'package:evently_c18/models/category_model.dart';
import 'package:evently_c18/screens/home/tabs/home_tab/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key, required this.onChange});
  final void Function(int) onChange;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    int selectedCategory = Provider.of<HomeProvider>(context).selectedCategory;

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,

        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Row(
                spacing: 4,
                children: [
                  Icon(
                    Icons.category,
                    color: selectedCategory == 0 ? Colors.white : null,
                  ),
                  Text('All'),
                ],
              ),
              labelStyle: theme.textTheme.titleMedium!.copyWith(
                color: selectedCategory == 0 ? Colors.white : null,
              ),

              selected: selectedCategory == 0,
              onSelected: (value) {
                onChange(0);
              },
              showCheckmark: false,
              backgroundColor: theme.cardColor,
              selectedColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(16),
              ),
            ),
          ),

          ...CategoryModel.generateCategories().map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Row(
                  spacing: 4,
                  children: [
                    SvgPicture.asset(
                      e.iconPAth,
                      colorFilter: selectedCategory == e.id
                          ? ColorFilter.mode(Colors.white, BlendMode.srcIn)
                          : null,
                    ),
                    Text(e.title),
                  ],
                ),
                labelStyle: theme.textTheme.titleMedium!.copyWith(
                  color: selectedCategory == e.id ? Colors.white : null,
                ),

                selected: selectedCategory == e.id,
                onSelected: (value) {
                  onChange(e.id);
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
