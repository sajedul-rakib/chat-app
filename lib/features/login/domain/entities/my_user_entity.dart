class MyUserEntity {
  String id;
  String email;
  String name;
  String? profilePic;

  MyUserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.profilePic,
  });

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profilePic': profilePic,
    };
  }

  MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
      email: doc['email'] as String,
      name: doc['name'] as String,
      profilePic: doc['profilePic'] as String?,
    );
  }
}
