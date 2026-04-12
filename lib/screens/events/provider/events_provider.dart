import 'package:evently_c18/models/category_model.dart';
import 'package:flutter/material.dart';

class EventsProvider extends ChangeNotifier {
  CategoryModel selectedCategory = CategoryModel.generateCategories().first;
  DateTime? selectedDate; //2026/4/5 9:52 pm
  TimeOfDay? selectedTime; //9:52 pm
  editSelectedCategory(CategoryModel newCat) {
    selectedCategory = newCat;
    notifyListeners();
  }

  editDate(DateTime newDate) {
    selectedDate = newDate;
    notifyListeners();
  }

  editTime(TimeOfDay newTime) {
    selectedTime = newTime;
    notifyListeners();
  }
}
