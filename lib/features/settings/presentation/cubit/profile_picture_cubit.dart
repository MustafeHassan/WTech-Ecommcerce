import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wtech_ecommerce/services_locator.dart' as di;

import 'package:path/path.dart' as path;

part 'profile_picture_state.dart';

class ProfilePictureCubit extends Cubit<ProfilePictureState> {
  ProfilePictureCubit() : super(ProfilePictureInitial());
  Future<void> changeProfilePictureCubit(
      {required File image, required String uid}) async {
    try {
      emit(ProfilePictureLoading());
      final Reference reference = FirebaseStorage.instance.ref().child(
            'Profile_Picture/$uid/${path.basename(image.path)}',
          );
      final UploadTask uploadTask = reference.putFile(
        image,
      );
      await uploadTask.whenComplete(() => null);
      final String downloadUrl = await reference.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'profilePicture': downloadUrl,
      });
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(downloadUrl);
      var userJson = di.preferences.getString('user');
      var user = jsonDecode(userJson!) as Map<String, dynamic>;
      user.update('profilePicture', (value) => downloadUrl);
      di.preferences.setString('user', jsonEncode(user));
      emit(
        ProfilePictureUpdated(profilePicture: downloadUrl),
      );
    } catch (_) {
      debugPrint(_.toString());
      emit(ProfilePictureError());
    }
  }
}
