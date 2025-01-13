import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntites extends Equatable {
  final String? id;
  final String email;
  final String fullname;
  final String gender;
  final String? profilePic;
  final Timestamp? lastSeen;

  const UserEntites(
      {this.id,
      required this.email,
      required this.fullname,
      required this.gender,
      this.profilePic,
      this.lastSeen});

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'gender': gender,
      'profilePic': profilePic,
      'lastSeen': Timestamp.now()
    };
  }

  static UserEntites fromDocument(Map<String, dynamic> data) {
    return UserEntites(
        id: data['id'] as String,
        email: data['email'] as String,
        fullname: data['fullname'] as String,
        gender: data['gender'] as String,
        profilePic: data['profilePic'] as String?,
        lastSeen: data['lastSeen'] as Timestamp?);
  }

  @override
  List<Object?> get props => [email, fullname, gender, profilePic, lastSeen];
}
