import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Record {
  String account,
      event,
      subevent; //It is not part of the model: To link with the account and event
  String id, description, category;
  DateTime date;
  String type;
  double value;
  String receipt;

  Record.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        account = doc.data['account'],
        event = doc.data['event'],
        subevent = doc.data['subevent'],
        category = doc.data['category'],
        description = doc.data['description'],
        type = doc.data['type'],
        value = (doc.data['value'] as double),
        receipt = doc.data['receipt'],
        date = (doc.data['datetime'] as Timestamp)
            .toDate(); //Convertir al formato que necesitamos

//Para poder guardarlo directamente
  Map<String, dynamic> toFirestore() => {
        'account': this.account,
        'event': this.event,
        'subevent': this.subevent,
        'type': this.type,
        'category': this.category,
        'description': this.description,
        'value': this.type,
        'receipt': this.receipt,
        'datetime': this.date,
      };
/*
  Record({
    @required this.account,
    @required this.description,
    @required this.type,
    @required this.category,
    @required this.value,
    this.receipt,
    this.event,
    this.subevent,
    //this.date
  }) : date = DateTime.now();*/

  Record({
    @required this.account,
    @required this.description,
    @required this.type,
    @required this.category,
    @required this.value,
    this.receipt,
    this.event,
    this.subevent,
    this.date,
  });

  String get hhmm => '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
}
