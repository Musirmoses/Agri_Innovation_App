import 'package:flutter/material.dart';

import '../models/training_course.dart';
import '../services/training_service.dart';

class TrainingProvider extends ChangeNotifier {
  final TrainingService _service = TrainingService();

  List<TrainingCourse> courses = [];
  bool isLoading = false;

  Future<void> loadCourses() async {
    isLoading = true;
    notifyListeners();

    courses = await _service.fetchCourses();

    isLoading = false;
    notifyListeners();
  }
}
