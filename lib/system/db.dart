import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gvconta/model/account.dart';
import 'package:gvconta/model/user.dart';

import 'auth_provider.dart';

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

Stream<User> getUser(BuildContext context) async* {
  String uid = await _getUid(context);

  Stream<DocumentSnapshot> userSnapshot =
      Firestore.instance.document('users/$uid').snapshots();

  yield* userSnapshot.map(toUser);
}
/*
Stream<User> getUser_uid(String uid) {
  Stream<DocumentSnapshot> userSnapshot =
      Firestore.instance.document('users/$uid').snapshots();

  return userSnapshot.map(toUser);
}*/

Stream<List<Account>> getAccounts(BuildContext context) async* {
  String uid = await _getUid(context);

  yield* Firestore.instance
      .collection('users/$uid/accounts')
      .snapshots()
      .map(toAccountList);
}

/*
import 'model/group.dart';
import 'model/message.dart';

Stream<List<Group>> getGroups() {
  //La función map convierte la
  return Firestore.instance.collection('groups').snapshots().map(toGroupList);
}

Stream<List<Message>> getGroupMessages(String groupId) {
  return Firestore.instance
      .collection('groups/$groupId/messages')
      .orderBy('datetime', descending: true)
      .snapshots()
      .map(toMessageList);
}

Future<void> sendMessage(String groupId, Message msg) async {
  await Firestore.instance
      .collection('groups/$groupId/messages')
      .add(msg.toFirestore());
}
*/
