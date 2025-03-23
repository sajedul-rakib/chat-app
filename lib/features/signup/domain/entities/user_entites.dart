import 'package:equatable/equatable.dart';

class UserEntites extends Equatable {
  final String email;
  final String fullname;
  final String gender;
  final String? profilePic;

  const UserEntites({
    required this.email,
    required this.fullname,
    required this.gender,
    this.profilePic,
  });

  Map<String, Object?> toDocument() {
    return {
      'fullName': fullname,
      'email': email,
      'gender': gender,
      'profilePic': profilePic,
    };
  }

  static UserEntites fromDocument(Map<String, dynamic> data) {
    return UserEntites(
      email: data['email'] as String,
      fullname: data['fullName'] as String,
      gender: data['gender'] as String,
      profilePic: data['profilePic'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        email,
        fullname,
        gender,
        profilePic,
      ];
}
