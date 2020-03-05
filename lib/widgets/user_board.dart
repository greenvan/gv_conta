import 'package:flutter/material.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/widgets/user_card.dart';

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
    Icon(Icons.account_balance_wallet),
    Icon(Icons.category)
  ];

  final List<String> _userActionRoutes = [
    '/account_list',
    '/account_list_filtered',
    '/categories'
  ];

  UserActions(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        UserButton(
          icon: _userActionIcons[0],
          label: _userActionLabels[0],
          user: this.user,
          route: _userActionRoutes[0],
        ),
        UserButton(
          icon: _userActionIcons[1],
          label: _userActionLabels[1],
          user: this.user,
          route: _userActionRoutes[1],
        ),
        UserButton(
          icon: _userActionIcons[2],
          label: _userActionLabels[2],
          user: this.user,
          route: _userActionRoutes[2],
        ),
      ],
    );
  }
}

class UserButton extends StatelessWidget {
  final String label, route;
  final Icon icon;
  final User user;
  const UserButton(
      {@required this.label,
      @required this.icon,
      @required this.user,
      @required this.route});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SizedBox(
        height: 80,
        width: 220,
        child: RaisedButton.icon(
          icon: icon,
          label: Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          color: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          textColor: Colors.white70,
          elevation: 12,
          onPressed: () {
            print('Raised button pressed by uid');
            Navigator.of(context).pushNamed(route, arguments: user);
          },
        ),
      ),
    );
  }
}
