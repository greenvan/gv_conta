import 'package:flutter/material.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/system/auth_provider.dart';
import 'package:gvconta/system/db.dart' as db;
import 'package:gvconta/system/i18n.dart';
import 'package:gvconta/ui/widgets/loading.dart';
import 'package:gvconta/ui/widgets/red_error.dart';
import 'package:gvconta/ui/widgets/user_board.dart';

class HomePage extends StatelessWidget {
  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
    } catch (e) {
      print("Error: $e");
    }
  }

  void _askSignOut(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          var labels = I18n.of(context);
          return AlertDialog(
            title: Text(labels.closeSession),
            content: Text(labels.confirmCloseSession),
            actions: <Widget>[
              new FlatButton(
                child: new Text(labels.EXIT),
                onPressed: () {
                  _signOut(context);
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(labels.CANCEL),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.group_work),
        title: Text(I18n.of(context).appName),
        actions: <Widget>[
          //TODO: Añadir un about us.
          //TODO: Quizá sea demasiado accesible el icono de signOut, esconder detrás de un menú para más seguridad.
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _askSignOut(context),
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
