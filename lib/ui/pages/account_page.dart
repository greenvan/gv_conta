import 'package:flutter/material.dart';
import 'package:gvconta/model/account.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/ui/widgets/account_card.dart';
import 'package:gvconta/ui/widgets/home_button.dart';
import 'package:gvconta/model/navigation_arguments.dart';
import 'package:gvconta/system/user_provider.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationArguments args = ModalRoute.of(context).settings.arguments;
    final Account account = args.account;
    final User user = args.user;

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
      body: Padding(
        padding: EdgeInsets.all(12),
        child: UserProvider(
          user: user,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AccountCard(account),
              AccountActions(account),
              Text('Esta es la página de la cuenta "' +
                  account.name +
                  '" del usuario: ' +
                  user.name),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountActions extends StatelessWidget {
  final Account account;

  final List<String> _accountActionLabels = [
    'Gastos e Ingresos',
    'Eventos',
  ];

  final List<Icon> _accountActionIcons = [
    Icon(Icons.account_balance),
    Icon(Icons.event_note),
  ];

  final List<String> _accountActionRoutes = [
    '/diary',
    '/event_list',
  ];

  AccountActions(this.account);

  @override
  Widget build(BuildContext context) {
    NavigationArguments arguments = NavigationArguments(
      user: UserProvider.of(context).user,
      account: this.account,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        HomeButton(
            icon: _accountActionIcons[0],
            label: _accountActionLabels[0],
            route: _accountActionRoutes[0],
            arguments: arguments),
        HomeButton(
            icon: _accountActionIcons[1],
            label: _accountActionLabels[1],
            route: _accountActionRoutes[1],
            arguments: arguments),
      ],
    );
  }
}
