import 'package:flutter/material.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/system/db.dart' as db;

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    TextEditingController _controller = TextEditingController(text: user.name);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Editar Perfil',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                  'Esta es la página en la que se podrá editar el perfil del usuario: ' +
                      user.name +
                      '\nEl email del usuario no se podrá cambiar: ' +
                      user.email +
                      '\nEn un futuro se cambiará también la foto.'),
              TextField(
                decoration: InputDecoration(labelText: 'Nombre:'),
                controller: _controller,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Guardar'),
                    onPressed: () {
                      //TODO: Pedir confirmación
                      print('Nombre puesto:' + _controller.text);
                      //TODO: Comprobar que el texto es correcto (no vacío)??
                      user.name = _controller.text;
                      //TODO: guardar en la base de datos

                      Navigator.of(context).pop();
                    },
                  ),
                  RaisedButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
