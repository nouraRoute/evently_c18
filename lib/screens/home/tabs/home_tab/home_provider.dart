import 'package:evently_c18/models/event_model.dart';
import 'package:evently_c18/network/event_service.dart';
import 'package:flutter/widgets.dart';

class HomeProvider extends ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> events = [];
  int selectedCategory = 0;
  updateSelectedCat(int id) {
    selectedCategory = id;
    notifyListeners();
    getEvents();
  }

  Future<String?> getEvents() async {
    try {
      // print('----getEvents---cat=${selectedCategory}');
      if (selectedCategory == 0) {
        events = await EventService.getAllEvents();
      } else {
        events = await EventService.getFilteredEvents(selectedCategory);
      }
      notifyListeners();
    } on Exception catch (e) {
      print(e);
      return e.toString();
    }
  }

  // filterEventsByCatId(int id) {
  //   if (id == 0) {
  //     events = [...allEvents];
  //     notifyListeners();
  //     return;
  //   }
  //   events = [...allEvents.where((element) => element.catId == id).toList()];
  //   notifyListeners();
  // }
}
