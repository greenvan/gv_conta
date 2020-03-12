import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gvconta/model/account.dart';
import 'package:gvconta/model/category.dart';
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

Stream<List<Account>> getAccountList(String uid) {
  return Firestore.instance
      .collection('users/$uid/accounts')
      .snapshots()
      .map(toAccountList);
}

Future<void> updateUserName(User user) async {
  Map<String, dynamic> values = new Map<String, dynamic>();
  values["name"] = user.name;
  await Firestore.instance.document('users/${user.uid}/').updateData(values);
}

Future<void> updateAccountName(User user, Account account) async {
  Map<String, dynamic> values = new Map<String, dynamic>();
  values["name"] = account.name;
  await Firestore.instance
      .document('users/${user.uid}/accounts/${account.id}')
      .updateData(values);
}

Future<void> addAccount(User user, Account account) async {
  await Firestore.instance
      .collection('users/${user.uid}/accounts')
      .add(account.toFirestore());
}

Future<void> addUser(User user) async {
  await Firestore.instance
      .collection('users')
      .document(user.uid)
      .setData(user.toFirestore());
}
/*
Stream<List<Category>> getExpenseList(String uid) {
  return Firestore.instance
      .collection('users/$uid/expenses')
      .snapshots()
      .map(toCategoryList);
}*/

Stream<List<Category>> getExpenseList(String uid) {
  return Firestore.instance
      .collection('users/$uid/expenses')
      .orderBy('name', descending: false) //TODO: not working???
      .snapshots()
      .map(toExpenseList);
}

Stream<List<Category>> getIncomeList(String uid) {
  return Firestore.instance
      .collection('users/$uid/incomes')
      .snapshots()
      .map(toIncomeList);
}

Future<void> addExpense(User user, Category expense) async {
  await Firestore.instance
      .collection('users/${user.uid}/expenses')
      .add(expense.toFirestore());
}

Future<void> addIncome(User user, Category income) async {
  await Firestore.instance
      .collection('users/${user.uid}/incomes')
      .add(income.toFirestore());
}

Future<void> updateCategoryName(User user, Category category) async {
  String type = category.extras['type'];

  Map<String, dynamic> values = new Map<String, dynamic>();
  values["name"] = category.name;

  await Firestore.instance
      .document('users/${user.uid}/$type/${category.id}')
      .updateData(values);
}

Future<void> deleteCategory(User user, Category category) async {
  String type = category.extras['type'];

  await Firestore.instance
      .document('users/${user.uid}/$type/${category.id}')
      .delete();
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
