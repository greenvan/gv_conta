import 'package:flutter/material.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/system/auth_provider.dart';

class HomePage extends StatelessWidget {
  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<String> _getUid(BuildContext context) async {
    String uid = '';
    try {
      var auth = AuthProvider.of(context).auth;
      uid = await auth.currentUser();
    } catch (e) {
      print("Error: $e");
    }

    return uid;
  }

  @override
  Widget build(BuildContext context) {
    String userId = '';
    //final labels = AppLocalizations.of(context);

    _getUid(context).then((onValue) {
      userId = onValue;
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('GVConta'), //Text(labels.app.name),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => _signOut(context),
            )
          ],
        ),
        body: Center(child: Text('user id: $userId'))

        /*StreamBuilder(
        stream: db.getGroups(),
        builder: (context, AsyncSnapshot<List<Group>> snapshot) {
          if (snapshot.hasError) {
            return RedError(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Loading();
          }

          return GroupList(groups: snapshot.data);
        },
      ),*/
        );
  }
}
