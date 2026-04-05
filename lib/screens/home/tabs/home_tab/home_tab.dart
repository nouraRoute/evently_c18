import 'package:evently_c18/common/widgets/category_row_widget.dart';
import 'package:evently_c18/screens/home/widgets/event_card.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [CategoryRow(showAll: true), EventCard()]);
  }
}
