import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference get payments => firestore.collection('payment');
  CollectionReference get users => firestore.collection('user');

  Future updateUserData(int fico, double line) async {
    return await users.doc(uid).update({'fico': fico, 'line': line});
  }

  Future createPayment(int pyments, double amout) async {
    return await payments
        .add({'userId': uid, 'pyments': pyments, 'amout': amout});
  }
}
