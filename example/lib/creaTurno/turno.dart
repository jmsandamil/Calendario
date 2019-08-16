import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

final String tableTurno = "turno";
final String columnTurnoId = "_id";
final String columnName = "name";
final String columnColor = "color";

class Turno {
   Turno(this.name, this.color);

   Turno.fromMap(Map map) {
      id = map[columnTurnoId] as int;
      name = map[columnName] as String;
      color = new Color(map[columnColor]);
   }

   int id;
   String name;
   Color color;

   Map<String, dynamic> toMap() {
      var map = <String, dynamic>{columnName: name, columnColor: color.value};
      if (id != null) {
         map[columnTurnoId] = id;
      }
      return map;
   }
}

class TurnoProvider {
   TurnoProvider(this.db);

   Database db;

   Future<Turno> insert(Turno todo) async {
      todo.id = await db.insert(tableTurno, todo.toMap());
      return todo;
   }

   Future<Turno> get(int id) async {
      List<Map> maps = await db.query(tableTurno,
          columns: [columnTurnoId, columnName, columnColor],
          where: "$columnTurnoId = ?",
          whereArgs: [id]);
      if (maps.length > 0) {
         return Turno.fromMap(maps.first);
      }
      return null;
   }

   Future<List<Turno>> getAll() async {
      List<Map> maps = await db
          .query(tableTurno, columns: [columnTurnoId, columnName, columnColor]);
      return maps.map((map) {
         return Turno.fromMap(map);
      }).toList();
   }

   Future<int> delete(int id) async {
      return await db
          .delete(tableTurno, where: "$columnTurnoId = ?", whereArgs: [id]);
   }

   Future<int> update(Turno todo) async {
      return await db.update(tableTurno, todo.toMap(),
          where: "$columnTurnoId = ?", whereArgs: [todo.id]);
   }

   Future close() async => db.close();
}