import 'package:flutter/material.dart';
import 'package:gvconta/model/category.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/system/db.dart' as db;
import 'package:gvconta/system/user_provider.dart';

class CategoryBanner extends StatelessWidget {
  final String title;
  final User user;
  bool isExpense = true;
  TextEditingController _textFieldController = TextEditingController();

  //Hay que añadir una función como método.

  CategoryBanner({Key key, this.title, this.isExpense, this.user})
      : super(key: key);

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Añadir elemento en: ' + this.title),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Introduzca el nombre: "),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('AÑADIR'),
                onPressed: () {
                  Category newCategory =
                      Category(name: _textFieldController.text, parentId: '1');
                  if (isExpense) {
                    db.addExpense(user, newCategory);
                  } else {
                    db.addIncome(user, newCategory);
                  }
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('CANCELAR'),
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
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                width: 2.0, color: Theme.of(context).primaryColorDark),
            bottom:
                BorderSide(width: 4.0, color: Theme.of(context).primaryColor),
          ),
          color: Theme.of(context).primaryColorLight,
        ),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Theme.of(context).primaryColorDark,
              onPressed: () => _displayDialog(context),
            ),
          ],
        ));
  }
}
