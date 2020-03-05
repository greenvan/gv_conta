import 'package:flutter/material.dart';
import 'package:gvconta/model/user.dart';

class AccountListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    return Container(
      color: Colors.red,
      child: Text('Bienvenido Tala' + user.name),
    );
  }
}
