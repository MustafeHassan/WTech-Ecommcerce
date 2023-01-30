import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

Future<UserModel> setOrGetDocumentToFirestore(
    UserCredential userCred, FirebaseFirestore firebaseFirestore) async {
  var queryDocumentSnapshot = await firebaseFirestore
      .collection('Users')
      .where('email', isEqualTo: userCred.user!.email)
      .limit(1)
      .get();
  if (queryDocumentSnapshot.docs.isNotEmpty) {
    return UserModel.fromMap(queryDocumentSnapshot.docs.single.data());
  } else {
    await firebaseFirestore.collection('users').doc(userCred.user!.uid).set({
      'userId': userCred.user!.uid,
      'userName': userCred.user!.displayName,
      'email': userCred.user!.email,
      'phoneNumber': userCred.user!.phoneNumber ?? 'N/A',
      'address': null,
      'profilePicture': userCred.user!.photoURL,
      'isVerified': true,
    });
    var documentSnapshot = await firebaseFirestore
        .collection('users')
        .doc(userCred.user!.uid)
        .get();
    return UserModel.fromMap(documentSnapshot.data()!);
  }
}

Future<UserModel> signInAndCheckFirestore(String email, String password,
    FirebaseAuth firebaseAuth, FirebaseFirestore firebaseFirestore) async {
  var userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email, password: password);
  var documentSnapshot = await firebaseFirestore
      .collection('users')
      .doc(userCredential.user!.uid)
      .get();

  return UserModel.fromMap(documentSnapshot.data()!);
}

Future<UserModel> createAccountThenSaveToFirestore(
    UserCredential userCredential,
    String userName,
    String email,
    String phoneNumber,
    FirebaseFirestore firebaseFirestore) async {
  await firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
    {
      'userId': userCredential.user!.uid,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': null,
      'profilePicture': null,
      'isVerified': false,
    },
  );
  return UserModel.fromMap({
    'userId': userCredential.user!.uid,
    'userName': userName,
    'email': email,
    'phoneNumber': phoneNumber,
    'address': null,
    'profilePicture': null,
    'isVerified': false,
  });
}
