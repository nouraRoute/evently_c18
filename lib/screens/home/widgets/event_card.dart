import 'package:evently_c18/common/gen/assets.gen.dart';
import 'package:evently_c18/common/theme/app_colors.dart';
import 'package:evently_c18/common/utils/shared_container_decoration.dart';
import 'package:evently_c18/models/category_model.dart';
import 'package:evently_c18/models/event_model.dart';
import 'package:evently_c18/network/event_service.dart';
import 'package:evently_c18/screens/home/tabs/home_tab/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EventCard extends StatefulWidget {
  const EventCard({super.key, required this.eventModel});
  final EventModel eventModel;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late bool isFav = widget.eventModel.isFav;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(CategoryModel.getCatImage(widget.eventModel.catId)),
          fit: BoxFit.fill,
        ),
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: SharedContainerDecoration.decorationWithBorder(
              theme,
            ).copyWith(color: theme.scaffoldBackgroundColor),
            child: Text(
              widget.eventModel.date.day.toString(),
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: SharedContainerDecoration.decorationWithBorder(
              theme,
            ).copyWith(color: theme.scaffoldBackgroundColor),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.eventModel.title,
                  style: theme.textTheme.labelMedium,
                ),
                InkWell(
                  onTap: () async {
                    if (isFav) {
                      setState(() {
                        isFav = !isFav;
                      });
                      await EventService.removeFromWishlist(widget.eventModel);
                    } else {
                      setState(() {
                        isFav = !isFav;
                      });
                      await EventService.addToWishlist(widget.eventModel);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: isFav
                        ? Icon(Icons.favorite, color: AppColors.darkBg)
                        : Icon(Icons.favorite_outline),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
