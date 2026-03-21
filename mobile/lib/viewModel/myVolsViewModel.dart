import 'package:flutter/material.dart';

import 'package:mobile/models/vol.dart';

class MyVolsViewModel extends ChangeNotifier {
  late List<Vol> liste;
  MyVolsViewModel() {
    liste = [];
  }
  void addVol(Vol vol) {
    liste.add(vol);
    notifyListeners();
  }
}