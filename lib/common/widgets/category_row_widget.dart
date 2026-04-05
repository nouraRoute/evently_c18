import 'package:evently_c18/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryRow extends StatefulWidget {
  const CategoryRow({super.key, this.showAll = false});
  final bool showAll;
  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  late int selectedCategory = widget.showAll ? 0 : 1;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,

        children: [
          if (widget.showAll)
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
                  setState(() {
                    selectedCategory = 0;
                  });
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
                  setState(() {
                    selectedCategory = e.id;
                  });
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
