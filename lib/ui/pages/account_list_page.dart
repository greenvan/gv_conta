import 'package:flutter/material.dart';
import 'package:gvconta/model/account.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/system/db.dart' as db;
import 'package:gvconta/system/user_provider.dart';
import 'package:gvconta/ui/widgets/account_list.dart';
import 'package:gvconta/ui/widgets/loading.dart';
import 'package:gvconta/model/navigation_arguments.dart';
import 'package:gvconta/ui/widgets/red_error.dart';

class AccountListPage extends StatelessWidget {
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
      body: StreamBuilder(
        stream: db.getAccountList(user.uid),
        builder: (context, AsyncSnapshot<List<Account>> snapshot) {
          if (snapshot.hasError) {
            return RedError(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Loading();
          }

          return UserProvider(
            user: user,
            child: AccountList(accounts: snapshot.data),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pushNamed('/edit_account',
              arguments: NavigationArguments(user: user));
        },
      ),
    );
  }
}
