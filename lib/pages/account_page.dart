import 'package:flutter/material.dart';
import 'package:gvconta/model/account.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Account account = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            account.name,
          ),
        ),
        body: Container(
          child: Text('Esta es la página de la cuenta: ' + account.name),
        ));
  }
}
