import 'package:gvconta/model/account.dart';
import 'package:gvconta/model/user.dart';

class NavigationArguments {
  final User user;
  final Account account;

  NavigationArguments({this.user, this.account});
}
