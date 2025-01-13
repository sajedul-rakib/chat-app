import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/entities.dart';

class MyUser extends Equatable {
  final String? id;
  final String email;
  final String fullname;
  final String gender;
  final String? profilePic;
  final Timestamp? lastSeen;

  const MyUser(
      {this.id,
      required this.email,
      required this.fullname,
      required this.gender,
      this.profilePic,
      this.lastSeen});

  //empty user
  static MyUser empty =
      const MyUser(id: '', email: '', fullname: '', gender: '', profilePic: '');

  //copy with method
  MyUser copyWith(
      {String? id,
      String? email,
      String? fullname,
      String? gender,
      String? profilePic,
      Timestamp? lastSeen}) {
    return MyUser(
        id: id ?? this.id,
        email: email ?? this.email,
        fullname: fullname ?? this.fullname,
        gender: gender ?? this.gender,
        profilePic: profilePic ?? this.profilePic,
        lastSeen: lastSeen ?? this.lastSeen);
  }

  UserEntites toEntity() {
    return UserEntites(
        id: id,
        email: email,
        fullname: fullname,
        gender: gender,
        profilePic: profilePic,
        lastSeen: lastSeen);
  }

  static MyUser fromEntity(UserEntites userEntity) {
    return MyUser(
        id: userEntity.id,
        email: userEntity.email,
        fullname: userEntity.fullname,
        gender: userEntity.gender,
        profilePic: userEntity.profilePic,
        lastSeen: userEntity.lastSeen);
  }

  @override
  List<Object?> get props =>
      [id, email, fullname, gender, profilePic, lastSeen];
}
