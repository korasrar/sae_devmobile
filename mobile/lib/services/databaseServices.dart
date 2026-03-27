import 'package:mobile/models/vol.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';


class databaseServices{
  final Database db;
  databaseServices({required this.db});

  Future<List<Vol>> getVolsPerso() async{
    final List<Map<String, Object?>> volsMap = await db.query('VOLPERSOS');
    return volsMap.map((map) => Vol.fromMap(map)).toList();
  }

  Future<List<Vol>> getVolsPro() async{
    final List<Map<String, Object?>> volsMap = await db.query('VOLPROFESSIONNELS');
    return volsMap.map((map) => Vol.fromMap(map)).toList();
  }

  Future<void> insertVolPerso(Vol vol) async{
    await db.insert(
      'VOLPERSOS',
      vol.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteVolPerso(int num_vol, int id_compagnie, String date_depart) async {
    await db.delete(
      'VOLPERSOS',
      where: 'num_vol = ? and id_compagnie = ? and date_depart = ?',
      whereArgs: [num_vol, id_compagnie, date_depart],
    );
  }

  Future<void> insertVolPro(Vol vol) async{
    await db.insert(
      'VOLPROFESSIONNELS',
      vol.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(await db.query('VOLPROFESSIONNELS'));

  }

  Future<void> deleteVolPro(int num_vol, int id_compagnie, String date_depart) async {
    await db.delete(
      'VOLPROFESSIONNELS',
      where: 'num_vol = ? and id_compagnie = ? and date_depart = ?',
      whereArgs: [num_vol, id_compagnie, date_depart],
    );
  }
}