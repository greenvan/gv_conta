import 'package:flutter/material.dart';
import 'package:gvconta/model/user.dart';

class UserProvider extends InheritedWidget {
  final User user;
  UserProvider({Key key, Widget child, this.user})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //Use: UserProvider.of(context)
  static UserProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<UserProvider>()
        as UserProvider);
  }
}
