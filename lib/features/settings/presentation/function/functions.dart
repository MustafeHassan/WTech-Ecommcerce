// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wtech_ecommerce/features/order/data/models/shipping_address_model.dart';
import '../cubit/profile_picture_cubit.dart';
import 'package:wtech_ecommerce/services_locator.dart' as di;

void uploadImage(String source, BuildContext context, String id) async {
  if (source == 'Camera') {
    XFile? ximage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (ximage != null) {
      File image = File(ximage.path);
      await context.read<ProfilePictureCubit>().changeProfilePictureCubit(
            image: image,
            uid: id,
          );
      Navigator.of(context).pop();
    }
  } else {
    XFile? ximage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (ximage != null) {
      File image = File(ximage.path);
      await context.read<ProfilePictureCubit>().changeProfilePictureCubit(
            image: image,
            uid: id,
          );
      Navigator.of(context).pop();
    }
  }
}

Future<List<ShippingAddressModel>> getShippingAddress(String uid) async {
  List<ShippingAddressModel> address = [];
  var querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('shipping_address')
      .get();

  for (var i = 0; i < querySnapshot.docs.length; i++) {
    address.add(ShippingAddressModel.fromMap(querySnapshot.docs[i].data()));
  }
  return address;
}

Future<void> updateAddress({
  required String uid,
  required String addressLine1,
  String? addressLine2,
  required String country,
  required String city,
  required int zipCode,
  required bool isDefault,
}) async {
  await FirebaseFirestore.instance.collection('users').doc(uid).update({
    'address': {
      'address line 1': addressLine1,
      'address line 2': addressLine2,
      'country': country,
      'city': city,
      'zib': city,
      'zipCode': zipCode,
      'isDefault': isDefault,
    },
  });
  var user =
      jsonDecode(di.preferences.getString('user')!) as Map<String, dynamic>;
  user.update(
    'address',
    (value) => {
      'address line 1': addressLine1,
      'address line 2': addressLine2,
      'country': country,
      'city': city,
      'zipCode': zipCode,
    },
  );
  await di.preferences.setString('user', jsonEncode(user));
}

Future<bool> deleteShippingAddress({
  required String uid,
  required int zipCode,
}) async {
  var snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('shipping_address')
      .where('zipCode', isEqualTo: zipCode)
      .get();

  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('shipping_address')
      .doc(snapshot.docs.first.id)
      .delete();
  return true;
}

Future<bool> deleteCreditCards({
  required String uid,
  required String cardNumber,
}) async {
  var snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('credit_cards')
      .where('cardNumber', isEqualTo: cardNumber)
      .get();

  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('credit_cards')
      .doc(snapshot.docs.first.id)
      .delete();
  return true;
}
