import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String email;
  String image;

  User.fromFirestore(DocumentSnapshot doc)
      : uid = doc.documentID,
        name = doc.data['name'],
        email = doc.data['email'],
        image = doc.data['image'];

  @override
  String toString() {
    return this.name;
  }
}

User toUser(DocumentSnapshot doc) {
  return User.fromFirestore(doc);
}
