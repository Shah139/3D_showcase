import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference modelsCollection =
      FirebaseFirestore.instance.collection('plane');

  Stream<QuerySnapshot> getModelsStream() {
    return modelsCollection.snapshots();
  }
}