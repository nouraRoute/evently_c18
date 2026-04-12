import 'package:evently_c18/common/theme/app_colors.dart';
import 'package:evently_c18/models/event_model.dart';
import 'package:evently_c18/network/event_service.dart';
import 'package:evently_c18/screens/home/widgets/event_card.dart';
import 'package:flutter/material.dart';

class FavTab extends StatelessWidget {
  const FavTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: EventService.getWishlistEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        List<EventModel> events = snapshot.data ?? [];
        return ListView.builder(
          itemBuilder: (context, index) => EventCard(eventModel: events[index]),
          itemCount: events.length,
        );
      },
    );
  }
}
