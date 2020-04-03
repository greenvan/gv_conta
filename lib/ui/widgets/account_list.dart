import 'package:flutter/material.dart';
import 'package:gvconta/model/account.dart';

import 'account_tile.dart';

class AccountList extends StatelessWidget {
  const AccountList({@required this.accounts});

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return AccountTile(accounts[index]);
              },
              childCount: accounts.length,
            ),
          )
        ],
      ),
    );
  }
}
