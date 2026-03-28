import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/vol.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:mobile/services/databaseServices.dart';




class MyVolsViewModel extends ChangeNotifier {
  final databaseServices database;

  List<Vol> _allVols  = [];
  
  // Filtres : [Perso, Pro]
  List<bool> _selectedFilters = [true, true];
  List<bool> get selectedFilters => _selectedFilters;

  List<Vol> get filteredVols {
    return _allVols.where((vol) {
      if (vol.isPro) {
        return _selectedFilters[1]; // Filtre Pro
      } else {
        return _selectedFilters[0]; // Filtre Perso
      }
    }).toList();
  }

  MyVolsViewModel({required this.database}){
    loadAllVols();
  }

  Future<void> loadAllVols() async {
    final pros = await database.getVolsPro();
    final persos = await database.getVolsPerso();
    _allVols = [...pros, ...persos];
    notifyListeners();
  }

  void toggleFilter(int index) {
    _selectedFilters[index] = !_selectedFilters[index];
    notifyListeners();
  }

  void deleteVol(Vol vol) async {
    if (vol.isPro) {
      await database.deleteVolPro(vol.num_vol, vol.id_compagnie, vol.date_depart);
    } else {
      await database.deleteVolPerso(vol.num_vol, vol.id_compagnie, vol.date_depart);
    }
    await loadAllVols();
  }

  void addVol(Vol vol) async {
    if (vol.isPro) {
      await database.insertVolPro(vol);
    } else {
      await database.insertVolPerso(vol);
    }
    await loadAllVols();
  }

}
