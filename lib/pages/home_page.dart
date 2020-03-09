import 'package:flutter/material.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/system/auth_provider.dart';
import 'package:gvconta/system/db.dart' as db;
import 'package:gvconta/widgets/loading.dart';
import 'package:gvconta/widgets/red_error.dart';
import 'package:gvconta/widgets/user_board.dart';

class HomePage extends StatelessWidget {
  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.group_work),
        title: Text(
          'Tala cuentas',
        ), //TODO Text(labels.app.name),
        actions: <Widget>[
          //TODO: Añadir un about us.
          //TODO: Quizá sea demasiado accesible el icono de signOut, esconder detrás de un menú para más seguridad.
          IconButton(
            icon: Icon(Icons.exit_to_app),
            //TODO: Pedir confirmación antes de salir
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: db.getUser(context),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasError) {
            return RedError(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Loading();
          }

          return UserBoard(user: snapshot.data);
        },
      ),
    );
  }
}
