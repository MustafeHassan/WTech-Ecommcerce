// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:wtech_dashboard/core/errors/exceptions.dart';

import 'package:wtech_dashboard/features/authentication/data/models/admin_model.dart';

abstract class AuthDataSource {
  Future<AdminModel> logIn({required String email, required String password});
  Future<void> forgotPassword({required String email});
}

class AuthDataSourceImp implements AuthDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthDataSourceImp({
    required this.auth,
    required this.firestore,
  });
  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (_) {
      if (_.code == 'invalid-email' || _.code == 'user-not-found') {
        throw EmailNotExist();
      } else {
        throw UnexpectedErrorException();
      }
    }
  }

  @override
  Future<AdminModel> logIn(
      {required String email, required String password}) async {
    try {
      var userCred = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await firestore.collection('users').doc(userCred.user!.uid).set({
        'email': email,
        'phoneNumber': null,
        'address': null,
        'profilePicture': null,
        'firstName': null,
        'lastName': null,
      });
      return AdminModel.fromMap({
        'email': email,
        'password': 'N/A',
        'phoneNumber': null,
        'address': null,
        'profilePicture': null,
        'firstName': null,
        'lastName': null,
      });
    } on FirebaseAuthException catch (_) {
      if (_.code == 'invalid-email' ||
          _.code == 'user-not-found' ||
          _.code == 'wrong-password') {
        throw SignInException();
      } else {
        throw UnexpectedErrorException();
      }
    }
  }
}
