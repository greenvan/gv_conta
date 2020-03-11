import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String email;
  String image;

  User({this.uid, this.name, this.email});
  User.fromFirestore(DocumentSnapshot doc)
      : uid = doc.documentID,
        name = doc.data['name'],
        email = doc.data['email'],
        image = doc.data['image'];

  //Para poder guardarlo directamente
  Map<String, dynamic> toFirestore() => {
        'name': this.name,
        'email': this.email,
        'image': this.image,
      };

  @override
  String toString() {
    return this.name;
  }
}

User toUser(DocumentSnapshot doc) {
  return User.fromFirestore(doc);
}
