import 'package:cloud_firestore/cloud_firestore.dart';
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
