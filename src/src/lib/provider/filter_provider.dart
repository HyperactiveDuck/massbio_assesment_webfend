import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterProvider extends ChangeNotifier {
  int pageSize = 30;

  void updatePageSize(int newPageSize) {
    pageSize = newPageSize;
    notifyListeners();
  }
}
