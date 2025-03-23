import 'package:equatable/equatable.dart';

import '../../domain/entities/entities.dart';

class MyUser extends Equatable {
  final String email;
  final String fullName;
  final String gender;
  final String? profilePic;

  const MyUser({
    required this.email,
    required this.fullName,
    required this.gender,
    this.profilePic,
  });

  //empty user
  static MyUser empty =
      const MyUser(email: '', fullName: '', gender: '', profilePic: '');

  //copy with method
  MyUser copyWith(
      {String? email,
      String? fullname,
      String? gender,
      String? profilePic,
     }) {
    return MyUser(
      email: email ?? this.email,
      fullName: fullname ?? fullName,
      gender: gender ?? this.gender,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  UserEntites toEntity() {
    return UserEntites(
      email: email,
      fullname: fullName,
      gender: gender,
      profilePic: profilePic,
    );
  }

  static MyUser fromEntity(UserEntites userEntity) {
    return MyUser(
      email: userEntity.email,
      fullName: userEntity.fullname,
      gender: userEntity.gender,
      profilePic: userEntity.profilePic,
    );
  }

  @override
  List<Object?> get props => [email, fullName, gender, profilePic];
}
