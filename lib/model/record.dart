import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  String id, comment, category;
  DateTime date;
  String type;
  double value;
  String receipt;

  Record.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        category = doc.data['category'],
        comment = doc.data['text'],
        type = doc.data['type'],
        value = (doc.data['value'] as double),
        receipt = doc.data['receipt'],
        date = (doc.data['datetime'] as Timestamp)
            .toDate(); //Convertir al formato que necesitamos

//TODO editar esta parte
//Para poder guardarlo directamente
  Map<String, dynamic> toFirestore() =>
      {'text': this.comment, 'datetime': this.date};

  Record(this.comment) : date = DateTime.now();

  String get hhmm => '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
}
