import 'package:flutter/material.dart';
import 'package:gvconta/model/user.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Card(
        semanticContainer: true,
        //color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),

        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListTile(
            //TODO: comprobar si el usuario tiene foto, en ese caso cargar la foto, si no el icono
            // La imagen estará redondeada (avatar)
            leading: Icon(
              Icons.account_circle,
              size: 100,
              color: Theme.of(context).primaryColorLight,
            ),
            title: Text(
              user.name,
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(color: Theme.of(context).primaryColorDark),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              user.email,
              style: TextStyle(color: Theme.of(context).primaryColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
                icon: Icon(Icons.edit,
                    color: Theme.of(context).primaryColorLight),
                onPressed: () {
                  print(
                      'button pressed'); //TODO : añadir la lógica para editar el perfil
                }),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}
