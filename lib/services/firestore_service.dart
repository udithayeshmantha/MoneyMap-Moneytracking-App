// filepath: /C:/Users/User/OneDrive/Desktop/Semester 5/Mobile Computing/money_tracking_app/lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracking_app/models/userdetails.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserDetails user) {
    return _db.collection('users').doc(user.id).set(user.toFirestore());
  }

  Stream<List<UserDetails>> getUsers() {
    return _db.collection('users').snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => UserDetails.fromFirestore(doc)).toList());
  }
}
