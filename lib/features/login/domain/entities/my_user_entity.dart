import 'package:cloud_firestore/cloud_firestore.dart';

class MyUserEntity {
  String id;
  String email;
  String name;
  String? profilePic;
  Timestamp? lastSeen;

  MyUserEntity(
      {required this.id,
      required this.email,
      required this.name,
      this.profilePic,
      this.lastSeen});

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profilePic': profilePic,
      'lastSeen': lastSeen
    };
  }

  MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
        id: doc['id'] as String,
        email: doc['email'] as String,
        name: doc['name'] as String,
        profilePic: doc['profilePic'] as String?,
        lastSeen: doc['lastSeen'] as Timestamp?);
  }
}
