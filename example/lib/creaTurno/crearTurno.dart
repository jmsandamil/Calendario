import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:table_calendar_example/util/database.dart';
import 'package:table_calendar_example/creaTurno/turno.dart';
import 'package:sqflite/sqflite.dart';

class TurnoForm extends StatefulWidget {
  TurnoForm(this.turno);

  final Turno turno;

  @override
  TurnoFormState createState() => new TurnoFormState();
}

class TurnoFormState extends State<TurnoForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  Color color;

  @override
  void initState() {
    super.initState();
    if (widget.turno != null) {
      nameController.text = widget.turno.name;
      color = widget.turno.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
            widget.turno.id != null ? 'Editar turno' : 'Añadir Turno'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Form(
          key: formKey,
          child: new ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              new TextFormField(
                keyboardType: TextInputType.text,
                controller: nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Por favor, añade nombre al Turno';
                  }
                },
                decoration: new InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ColorPicker(
                  pickerColor: color,
                  enableLabel: true,
                  onColorChanged: (newColor) {
                    color = newColor;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (formKey.currentState.validate()) {
            Database db = await openDb();
            TurnoProvider provider = TurnoProvider(db);

            if (widget.turno.id != null) {
              Turno turno = widget.turno;
              turno.name = nameController.text;
              turno.color = color;
              await provider.update(turno);
            } else {
              Turno turno = Turno(nameController.text, color);
              await provider.insert(turno);
            }

            Navigator.pop(context);
          }
        },
        label: Text('Aceptar'),
        backgroundColor: Colors.red[400],
        icon: Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
