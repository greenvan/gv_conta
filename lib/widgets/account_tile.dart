import 'package:flutter/material.dart';
import 'package:gvconta/model/account.dart';

class AccountTile extends StatelessWidget {
  final Account account;
  const AccountTile(this.account);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/account', arguments: account);
        },
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: <Widget>[
              Image.asset('images/account.png'),
              Text(account.name),
            ],
          ),
        ));
  }
}
