import 'package:agri/features/farmdashboard/domain/repositories/hydroponics_repository.dart';
import 'package:flutter/material.dart';

class HistoryController extends ChangeNotifier {
  final FarmRepository repository;

  List<Map<String, dynamic>> historyLog = [];
  bool isLoading = false;
  String? error;

  HistoryController(this.repository) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      isLoading = true;
      notifyListeners();

      historyLog = await repository.getHistoryLog();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addHistoryLogEntry(Map<String, dynamic> entry) async {
    try {
      await repository.addHistoryLogEntry(entry);
      historyLog.add(entry);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }
}
