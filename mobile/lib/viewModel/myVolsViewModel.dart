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

  List<Vol> _volsPros  = [];
  List<Vol> get volsPros => _volsPros;

  MyVolsViewModel({required this.database}){
    loadVolsPerso();
  }

  Future<void> loadVolsPerso() async {
    _volsPros = await database.getVolsPro();
    notifyListeners();
  }

  Future<List<Vol>> getVolsPro() async{
    final List<Vol> volPros = await this.database.getVolsPro();
    return volPros;
  }

  void addVolPerso(Vol vol) async{
    await this.database.insertVolPerso(vol);
    await loadVolsPerso();
  }

  void addVolPro(Vol vol) async{
    await this.database.insertVolPro(vol);
    await loadVolsPerso();

  }

  void removeVolPerso(Vol vol) async{
    await this.database.deleteVolPerso(vol.num_vol, vol.id_compagnie, vol.date_depart);
    await loadVolsPerso();
  }

  void removeVolPro(Vol vol) async{
    await this.database.deleteVolPro(vol.num_vol, vol.id_compagnie, vol.date_depart);
    await loadVolsPerso();
  }

}