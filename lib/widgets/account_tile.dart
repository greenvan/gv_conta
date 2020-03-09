import 'package:flutter/material.dart';
import 'package:gvconta/model/account.dart';
import 'package:gvconta/widgets/navigation_arguments.dart';

class AccountTile extends StatelessWidget {
  final Account account;
  const AccountTile(this.account);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/account',
              arguments: NavigationArguments(account: account));
        },
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: <Widget>[
              Image.asset('images/account.png'),
              Container(
                alignment: Alignment(0.0, 1.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Container(
                    //height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Theme.of(context).primaryColor, //Colors.black87,
                        ],
                        stops: [0.25, 1.0],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        tileMode: TileMode.repeated,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment(0.0, 1.0),
                child: Text(
                  account.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
