import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
    String userId) async {
  return await FirebaseFirestore.instance
      .collection('clients')
      .doc(userId)
      .get();
}
