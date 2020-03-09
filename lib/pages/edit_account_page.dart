import 'package:flutter/material.dart';
import 'package:gvconta/model/account.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/widgets/navigation_arguments.dart';

class EditAccountPage extends StatelessWidget {
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
            'Editar / Añadir nueva cuenta', //TODO: Cambiar en función de si hay cuenta o no
          ),
        ),
        body: Container(
          child: Text(
              'Esta es la página en la que se podrá editar o añadir una nueva cuenta para el usuario: ' +
                  user.name +
                  "\n en este caso se refiere a la cuenta: " +
                  account.toString()),
        ));
  }
}
