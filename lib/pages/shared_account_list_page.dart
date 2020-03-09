import 'package:flutter/material.dart';
import 'package:gvconta/model/user.dart';

class SharedAccountListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            user.name,
          ),
        ),
        body: Container(
          child: Text(
              'Esta es la página en la que se mostrarán las cuentas compartidas pertenecientes a otros usuarios' +
                  '\nPara el usuario: ' +
                  user.name),
        ));
  }
}
