import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {

  final String id;

  final String name;

  final String email;



  UserDetails({required this.id, required this.name, required this.email});



  factory UserDetails.fromFirestore(DocumentSnapshot doc) {

    Map data = doc.data() as Map;

    return UserDetails(

      id: doc.id,

      name: data['name'] ?? '',

      email: data['email'] ?? '',

    );

  }



  Map<String, dynamic> toFirestore() {

    return {

      'id': id,

      'name': name,

      'email': email,

    };

  }

}