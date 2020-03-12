import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gvconta/widgets/dynamic_treeview.dart';

class Category implements BaseData {
  final String id;
  final String parentId;
  String name;
  //String fullpath;

  ///Any extra data you want to get when tapped on children
  Map<String, dynamic> extras;
  //uid = userID
  //type = expenses/incomes

  Category({this.id, this.parentId, this.name, this.extras});
  @override
  String getId() {
    return this.id.toString();
  }

  @override
  Map<String, dynamic> getExtraData() {
    return this.extras;
  }

  @override
  String getParentId() {
    return this.parentId.toString();
  }

  @override
  String getTitle() {
    return this.name;
  }

  Category.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID, // int.parse(doc.documentID),
        name = doc.data['name'],
        parentId = doc.data['parentId'];

//Para poder guardarlo directamente
  Map<String, dynamic> toFirestore() => {
        'name': this.name,
        'parentId': this.parentId,
      };
}

List<Category> toCategoryList(QuerySnapshot query) {
  //Paso la lista de QuerySnapshot a Category
  return query.documents.map((doc) => Category.fromFirestore(doc)).toList();
}

List<Category> toExpenseList(QuerySnapshot query) {
  //Paso la lista de QuerySnapshot a Category
  return query.documents.map((doc) {
    Category expense = Category.fromFirestore(doc);
    expense.extras = {'type': 'expenses'};
    return expense;
  }).toList();
}

List<Category> toIncomeList(QuerySnapshot query) {
  //Paso la lista de QuerySnapshot a Category
  return query.documents.map((doc) {
    Category expense = Category.fromFirestore(doc);
    expense.extras = {'type': 'incomes'};
    return expense;
  }).toList();
}
