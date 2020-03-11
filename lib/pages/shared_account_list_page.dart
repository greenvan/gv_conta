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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                    'No existen cuentas de otros usuarios compartidas contigo: ' +
                        user.name),
              ),
              RaisedButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ));
  }
}
