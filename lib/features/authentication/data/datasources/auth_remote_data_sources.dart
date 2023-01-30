import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:wtech_ecommerce/core/errors/exceptions.dart';
import 'package:wtech_ecommerce/features/authentication/data/models/user_model.dart';

import 'helper_fucntions.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
  });
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();

  Future<void> signOut();
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  FacebookAuth facebookAuth;
  GoogleSignIn googleSignIn;
  EmailAuth? emailAuth;
  AuthRemoteDataSourceImp({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.facebookAuth,
    required this.googleSignIn,
    this.emailAuth,
  });

  @override
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await signInAndCheckFirestore(
        email,
        password,
        firebaseAuth,
        firebaseFirestore,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email' ||
          error.code == 'user-not-found' ||
          error.code == 'wrong-password') {
        throw SignInException();
      } else {
        throw UnexpectedErrorException();
      }
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      final LoginResult result = await facebookAuth.login();
      if (result.accessToken == null) {
        throw NullSafetyException();
      } else {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        var userCred = await firebaseAuth.signInWithCredential(credential);

        return await setOrGetDocumentToFirestore(userCred, firebaseFirestore);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'account-exists-with-different-credential') {
        throw FacebookLoginException();
      } else {
        debugPrint(error.toString());

        throw UnexpectedErrorException();
      }
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAuth = await googleSignIn.signIn();
      GoogleSignInAuthentication googleUser = await googleAuth!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleUser.accessToken,
        idToken: googleUser.idToken,
      );
      var userCred = await firebaseAuth.signInWithCredential(credential);

      return await setOrGetDocumentToFirestore(userCred, firebaseFirestore);
    } catch (error) {
      debugPrint(error.toString());

      throw UnexpectedErrorException();
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String userName,
      required String phoneNumber}) async {
    try {
      var userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return await createAccountThenSaveToFirestore(
        userCredential,
        userName,
        email,
        phoneNumber,
        firebaseFirestore,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        throw EmailAlreadyExistException();
      } else {
        debugPrint(error.toString());
        throw UnexpectedErrorException();
      }
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (_) {
      throw UnexpectedErrorException();
    }
  }
}
