import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:table_calendar_example/creaTurno/turno.dart';
import 'package:sqflite/sqflite.dart';

Future<String> _initDb(String dbName) async {
  var databasePath = await getDatabasesPath();
  String path = join(databasePath, dbName);

  if (!await Directory(dirname(path)).exists()) {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (e) {
      print(e);
    }
  }
  return path;
}

Future<Database> openDb() async {
  String path = await _initDb('app.db');

  return await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute('''
create table $tableTurno ( 
  $columnTurnoId integer primary key autoincrement, 
  $columnName text not null,
  $columnColor integer not null)
''');
  });
}
