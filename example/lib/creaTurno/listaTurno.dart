import 'dart:math';

import 'package:flutter/material.dart';
import 'package:table_calendar_example/add_Turno/add_dialog.dart';
import 'package:table_calendar_example/add_Turno/dialogs.dart';
import 'package:table_calendar_example/home.dart';
import 'package:table_calendar_example/models/turno.dart';
import 'package:table_calendar_example/util/database.dart';
import 'package:table_calendar_example/creaTurno/crearTurno.dart';
import 'package:sqflite/sqflite.dart';

import '../home.dart';

Future<List<Turno>> fetchTurnosFromDatabase() async {
  Database db = await openDb();
  TurnoProvider provider = TurnoProvider(db);
  return provider.getAll();
}

class TurnosList extends StatefulWidget {
  @override
  TurnosListState createState() => new TurnosListState();
}

class TurnosListState extends State<TurnosList> {

   List<Turno> turno2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text("Lista de Turnos"),
      ),
      body: new Container(
        padding: new EdgeInsets.all(16.0),
        child: new FutureBuilder<List<Turno>>(
          future: fetchTurnosFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.album,
                            color: snapshot.data[index].color),
                        title: Text(
                          snapshot.data[index].name,
                          style: TextStyle(
                              fontSize: 22, color: snapshot.data[index].color),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TurnoForm(snapshot.data[index])),
                          );
                        },
                        trailing: Container(
                            child: new IconButton(
                          icon: new Icon(Icons.add),
                           onPressed: () async {

                                    

                                
                                        await Dialogs.showAddToCalendar(context);
                            setState(() {});
                                      
                           
                          
                          },
                        )),
                      );
                    });
              } else {
                return new Center(child: new Text("No se crearon Turnos"));
              }
            }
            return new Container(
              alignment: AlignmentDirectional.center,
              child: new CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TurnoForm(new Turno(
                    null,
                    Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                        .withOpacity(1.0)))),
          );
        },
        backgroundColor: Colors.red[400],
        tooltip: 'Agregar Turno',
        child: Icon(Icons.add),
      ),
    );
  }
}
