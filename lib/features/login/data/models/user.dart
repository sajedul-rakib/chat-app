import 'package:chat_app/features/login/domain/entities/my_user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  const MyUser({
    required this.id,
    required this.email,
    required this.name,
    this.profilePic,
    this.lastSeen,
  });

  final String name;
  final String email;
  final String id;
  final String? profilePic;
  final Timestamp? lastSeen;

  static const MyUser empty =
      MyUser(id: '', email: '', name: '', profilePic: '', lastSeen: null);

  //modify my user parameters
  MyUser copyWith(String? id, String? email, String? name, String? profilePic,
      Timestamp? lastSeen) {
    return MyUser(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        profilePic: profilePic ?? this.profilePic,
        lastSeen: lastSeen ?? this.lastSeen);
  }

  factory MyUser.fromDocument(Map<String, dynamic> data) {
    return MyUser(
        id: data['id'] as String,
        email: data['email'] as String,
        name: data['name'] as String,
        profilePic: data['profilePic'] as String?,
        lastSeen: data['lastSeen'] as Timestamp?);
  }

  MyUserEntity toEntity() {
    return MyUserEntity(id: id, name: name, email: email);
  }

  static MyUser fromEntity(MyUserEntity myUserEntity) {
    return MyUser(
        id: myUserEntity.id,
        email: myUserEntity.email,
        name: myUserEntity.name,
        profilePic: myUserEntity.profilePic,
        lastSeen: myUserEntity.lastSeen);
  }

  @override
  List<Object?> get props => [name, email, profilePic, id, lastSeen];
}
