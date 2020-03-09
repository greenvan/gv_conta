import 'package:flutter/material.dart';
import 'package:gvconta/model/account.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/widgets/navigation_arguments.dart';
import 'package:gvconta/system/db.dart' as db;

class EditAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationArguments args = ModalRoute.of(context).settings.arguments;
    final Account account = args.account;
    final User user = args.user;

    bool addNew = true;
    String initialText = '';
    String appBarText = 'Añadir nueva cuenta';

    if (account != null) {
      addNew = false;
      initialText = account.name;
      appBarText = 'Editar la cuenta';
    }

    TextEditingController _controller =
        TextEditingController(text: initialText);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(appBarText),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                  'Esta es la página en la que se podrá editar o añadir una nueva cuenta para el usuario: ' +
                      user.name +
                      "\n en este caso se refiere a la cuenta: " +
                      account.toString()),
              TextField(
                decoration: InputDecoration(labelText: 'Nombre:'),
                controller: _controller,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Guardar'),
                    onPressed: () {
                      //TODO: Pedir confirmación
                      print('Nombre puesto:' + _controller.text);
                      //TODO: Comprobar que el texto es correcto (no vacío)??

                      //Guardar en la base de datos
                      if (addNew)
                        db.addAccount(user, Account(_controller.text));
                      else {
                        account.name = _controller.text;
                        db.updateAccountName(user, account);
                      }

                      Navigator.of(context).pop();
                    },
                  ),
                  RaisedButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
