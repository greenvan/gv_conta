import 'package:cloud_firestore/cloud_firestore.dart';

enum RolePlay {
  owner,
  editor, //can modify PGC + author
  author, //can add, modify and delete records
  colaborator, // can add records
  reader //Can only watch records
}

class Account {
  String id;
  String name;
  String image;
  String owner;
  RolePlay role;

  //List<String> read_permission, write_permission;

  Account.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        name = doc.data['name'];
}
