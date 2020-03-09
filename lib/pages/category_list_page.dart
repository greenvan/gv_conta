import 'package:flutter/material.dart';
import 'package:gvconta/model/user.dart';

class CategoryListPage extends StatelessWidget {
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
              'Esta es la página en la que se mostrarán las categorías de gastos e ingresos' +
                  '\nPara el usuario: ' +
                  user.name),
        ));
  }
}
