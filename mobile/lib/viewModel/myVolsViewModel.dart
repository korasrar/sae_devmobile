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
  
  List<bool> _selectedFilters = [true, true];
  List<bool> get selectedFilters => _selectedFilters;

  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  List<Vol> get filteredVols {
    return _allVols.where((vol) {
      bool matchesType = vol.isPro ? _selectedFilters[1] : _selectedFilters[0];
      
      bool matchesSearch = true;
      if (_searchQuery.isNotEmpty) {
        matchesSearch = vol.num_vol.toString().contains(_searchQuery) ||
                        vol.date_depart.toLowerCase().contains(_searchQuery.toLowerCase());
      }
      
      return matchesType && matchesSearch;
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

  void setSearchQuery(String query) {
    _searchQuery = query;
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
