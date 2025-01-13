import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/errors/signUpWithEmailAndPasswordFailure.dart';
import '../../data/models/model.dart';
import '../../data/repositories/signup_repository.dart';
import '../entities/entities.dart';

class SignupRepo implements SignupRepository {
  SignupRepo({FirebaseAuth? firebaseAuth, FirebaseStorage? firebaseStorage})
      : _auth = firebaseAuth ?? FirebaseAuth.instance,
        _storage = firebaseStorage ?? FirebaseStorage.instance;

  final FirebaseStorage _storage;
  final FirebaseAuth _auth;
  final _firestore = FirebaseFirestore.instance;

  //upload profile picture to firebase storage
  @override
  Future<String> uploadProfile({required String picPath}) async {
    try {
      UploadTask uploadTask;
      Reference rootDirectory = _storage.ref();

      //image extansion
      final ext = picPath.split("/").last.split('.').last;

      //unique name for profile picture
      final uniqueName =
          "profile_pic-${DateTime.now().microsecondsSinceEpoch}.$ext";
      Reference childDirectory = rootDirectory.child("profilePic/$uniqueName");
      uploadTask = childDirectory.putFile(File(picPath));
      final task = await uploadTask.whenComplete(() => null);

      String downloadUrl = await task.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  //create account with email and password
  @override
  Future<MyUser> signUpWithEmailAndPassword(
      {required MyUser user,
      required String password,
      required picPath}) async {
    try {
      UserCredential createUser = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: password);

      //get user profile pic url
      String imageUrl = await uploadProfile(picPath: picPath);

      user = user.copyWith(
          id: createUser.user!.uid,
          profilePic: imageUrl,
          lastSeen: Timestamp.now());

      //save user data to firebase fire store
      _saveUserData(user: user);

      return user;
    } on FirebaseException catch (e) {
      throw SignUpWithEmailAndPassword.fromCode(e.code).message;
    } catch (e) {
      throw SignUpWithEmailAndPassword(e.toString()).message;
    }
  }

  //save user data to firebase
  Future<void> _saveUserData({required MyUser user}) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .set(user.toEntity().toDocument());
    } on FirebaseException catch (e) {
      log(e.code);
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  //get user data
  @override
  Future<MyUser> getUserData({required String userId}) async {
    try {
      return _firestore.doc(userId).get().then((user) {
        return MyUser.fromEntity(UserEntites.fromDocument(user.data()!));
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
