import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Event {
  String id, name;
  String accountId, parentId;
  DateTime initDate, endDate;

  Event.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        name = doc.data['name'],
        initDate = (doc.data['initDate'] as Timestamp).toDate(),
        endDate = (doc.data['endDate'] as Timestamp)
            .toDate(); //Convertir al formato que necesitamos

//Para poder guardarlo directamente
  Map<String, dynamic> toFirestore() => {
        'name': this.name,
        'initDate': this.initDate,
        'endDate': this.endDate,
      };

  Event({
    @required this.accountId,
    @required this.name,
    @required this.initDate,
    @required this.endDate,
    this.parentId,
    this.id,
  });

  String get hhmmInit =>
      '${initDate.hour}:${initDate.minute.toString().padLeft(2, '0')}';
  String get hhmmEnd =>
      '${endDate.hour}:${endDate.minute.toString().padLeft(2, '0')}';
}

List<Event> toEventList(QuerySnapshot query) {
  //Paso la lista de QuerySnapshot a Account
  return query.documents.map((doc) => Event.fromFirestore(doc)).toList();
}
