import 'package:flutter/material.dart';
import 'package:mobile/fly_app.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }

  final database = await openDatabase(
    join(await getDatabasesPath(), 'my_vols.db'),

    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE VOLPERSOS(num_vol INTEGER, id_compagnie INTEGER, date_depart TEXT, date_arrive TEXT, id_aeroport_depart INTEGER, terminal_depart INTEGER, id_aeroport_arrive INTEGER, terminal_arrive INTEGER, PRIMARY KEY (num_vol, id_compagnie, date_depart))'
      );
      await db.execute(
          'CREATE TABLE VOLPROFESSIONNELS(num_vol INTEGER, id_compagnie INTEGER, date_depart TEXT, date_arrive TEXT, id_aeroport_depart INTEGER, terminal_depart INTEGER, id_aeroport_arrive INTEGER, terminal_arrive INTEGER, PRIMARY KEY (num_vol, id_compagnie, date_depart))'
      );
    },
    version: 1,
  );

  runApp(flyApp(db: database));
}