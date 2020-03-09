import 'package:flutter/material.dart';
import 'package:gvconta/model/account.dart';
import 'package:gvconta/system/user_provider.dart';
import 'package:gvconta/widgets/navigation_arguments.dart';

class AccountCard extends StatelessWidget {
  final Account account;
  const AccountCard(this.account);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        child: Card(
            semanticContainer: true,
            //color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //TODO: comprobar si  tiene foto, en ese caso cargar la foto, si no from assets
                  // La imagen estará redondeada (avatar)
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        'images/account.png',
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.edit,
                                  color: Theme.of(context).primaryColorLight),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  '/edit_account',
                                  arguments: NavigationArguments(
                                    account: account,
                                    user: UserProvider.of(context).user,
                                  ),
                                );
                              }),
                          Text(
                            account.name,
                            textAlign: TextAlign.right,
                            style:
                                Theme.of(context).textTheme.headline.copyWith(
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ]),
            )));
  }
}
