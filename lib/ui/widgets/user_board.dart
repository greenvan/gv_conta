import 'package:flutter/material.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/ui/widgets/user_card.dart';

import 'home_button.dart';

class UserBoard extends StatelessWidget {
  const UserBoard({@required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          UserCard(user),
          UserActions(user),
          Text('Bienvenido, ' +
              user.name +
              "\n Esta es tu dirección: " +
              user.email +
              ' y tu uid: ' +
              user.uid),
        ],
      ),
    );
  }
}

class UserActions extends StatelessWidget {
  final User user;

  final List<String> _userActionLabels = [
    'Mis cuentas',
    'Mis cuentas compartidas',
    'Mis categorías'
  ];

  final List<Icon> _userActionIcons = [
    Icon(Icons.account_balance),
    Icon(Icons.share),
    Icon(Icons.category)
  ];

  final List<String> _userActionRoutes = [
    '/account_list',
    '/shared_account_list',
    '/category_list'
  ];

  UserActions(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        HomeButton(
          icon: _userActionIcons[0],
          label: _userActionLabels[0],
          route: _userActionRoutes[0],
          arguments: this.user,
        ),
        HomeButton(
          icon: _userActionIcons[1],
          label: _userActionLabels[1],
          route: _userActionRoutes[1],
          arguments: this.user,
        ),
        HomeButton(
          icon: _userActionIcons[2],
          label: _userActionLabels[2],
          route: _userActionRoutes[2],
          arguments: this.user,
        ),
      ],
    );
  }
}
