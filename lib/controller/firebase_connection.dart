import 'package:cloud_firestore/cloud_firestore.dart';

// all Data store in clients_data list from clients collection firebase
final clients_data = [];

Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
    String userId) async {
  return await FirebaseFirestore.instance
      .collection('clients')
      .doc(userId)
      .get();
}

class FirebaseProvider {
  /// connect FirebaseFirestore

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // get all Data from banner collection
  Stream<QuerySnapshot<Map<String, dynamic>>> getBanner() {
    var banner = firestore.collection("banner");
    return banner.snapshots();
  }

  // get all Data from clients collection
  Stream<QuerySnapshot<Map<String, dynamic>>> getClients() {
    var clients = firestore.collection("clients");
    return clients.snapshots();
  }
}
