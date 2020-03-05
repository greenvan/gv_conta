import 'package:flutter/cupertino.dart';
import 'auth.dart';

class AuthProvider extends InheritedWidget {
  final BaseAuth auth;
  AuthProvider({Key key, Widget child, this.auth})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //Use: AuthProvider.of(context)
  static AuthProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AuthProvider>()
        as AuthProvider);
  }
}
