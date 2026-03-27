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

  MyVolsViewModel({required this.database});

  Future<List<Vol>> getVolsPerso() async{
    final List<Vol> volPersos = await this.database.getVolsPerso();
    return volPersos;

  }

  Future<List<Vol>> getVolsPro() async{
    final List<Vol> volPros = await this.database.getVolsPro();
    return volPros;
  }

  void addVolPerso(Vol vol) async{
    await this.database.insertVolPerso(vol);
    notifyListeners();
  }

  void addVolPro(Vol vol) async{
    await this.database.insertVolPro(vol);
    notifyListeners();
  }

  void removeVolPerso(Vol vol) async{
    await this.database.deleteVolPerso(vol.num_vol, vol.id_compagnie, vol.date_depart);
    notifyListeners();
  }

  void removeVolPro(Vol vol) async{
    await this.database.deleteVolPro(vol.num_vol, vol.id_compagnie, vol.date_depart);
    notifyListeners();
  }

}