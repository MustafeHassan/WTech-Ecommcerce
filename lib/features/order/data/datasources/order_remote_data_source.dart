// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wtech_ecommerce/core/errors/exceptions.dart';
import 'package:wtech_ecommerce/features/order/data/models/order_model.dart';

import '../models/credit_card_model.dart';
import '../models/shipping_address_model.dart';

abstract class OrderRemoteDataSource {
  Future<void> placeOrder({
    required String orderId,
    required DateTime orderPlacedDate,
    required Map<String, dynamic> orderStatus,
    required Map<String, dynamic> shippingAddress,
    required Map<String, dynamic> paymentCard,
    required String shippingMethod,
    required double totalToPay,
  });

  Future<CreditCardModel> setPayment({
    required String cardHolder,
    required String cardNumber,
    required String cardExpireDate,
    required int cvc,
    bool? isDefault,
  });

  Future<ShippingAddressModel> setShippingAddress({
    required String contactName,
    required String email,
    required String phoneNumber,
    required String addressLine1,
    required String? addressLine2,
    required String country,
    required String city,
    required int zipCode,
    required bool isDefault,
  });
  Future<List<CreditCardModel>> getAllCreditCards();
  Future<dynamic> getAllShippingAddress();
  Future<List<OrderModel>> getAllOrders();
}

class OrderRemoteDataSourceImp implements OrderRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  OrderRemoteDataSourceImp({
    required this.firestore,
    required this.auth,
  });
  @override
  Future<void> placeOrder(
      {required String orderId,
      required DateTime orderPlacedDate,
      required Map<String, dynamic> orderStatus,
      required Map<String, dynamic> shippingAddress,
      required Map<String, dynamic> paymentCard,
      required String shippingMethod,
      required double totalToPay}) async {
    String uid = auth.currentUser!.uid;
    try {
      await firestore.collection('orders').add(
        {
          'uid': uid,
          'orderId': orderId,
          'orderPlacedDate': orderPlacedDate.millisecondsSinceEpoch,
          'orderStatus': orderStatus,
          'shippingAddress': shippingAddress,
          'paymentCard': paymentCard,
          'shippingMethod': shippingMethod,
          'totalToPay': totalToPay,
        },
      );
    } catch (_) {
      throw UnexpectedErrorException();
    }
  }

  @override
  Future<CreditCardModel> setPayment(
      {required String cardHolder,
      required String cardNumber,
      required String cardExpireDate,
      required int cvc,
      bool? isDefault}) async {
    String uid = auth.currentUser!.uid;
    try {
      var docRef = await firestore
          .collection('users')
          .doc(uid)
          .collection('credit_cards')
          .add(
        {
          'cardHolder': cardHolder,
          'cardNumber': cardNumber,
          'cardExpireDate': cardExpireDate,
          'cvc': cvc,
          'isDefault': isDefault,
        },
      );
      var docSnapshot = await docRef.get();
      return CreditCardModel.fromMap(docSnapshot.data()!);
    } catch (_) {
      throw UnexpectedErrorException();
    }
  }

  @override
  Future<ShippingAddressModel> setShippingAddress(
      {required String contactName,
      required String email,
      required String phoneNumber,
      required String addressLine1,
      required String? addressLine2,
      required String country,
      required String city,
      required int zipCode,
      required bool isDefault}) async {
    String uid = auth.currentUser!.uid;
    try {
      if (isDefault) {
        await firestore.collection('users').doc(uid).update({
          'address': {
            'contactName': contactName,
            'email': email,
            'phoneNumber': phoneNumber,
            'addressLine1': addressLine1,
            'addressLine2': addressLine2,
            'country': country,
            'city': city,
            'zipCode': zipCode,
            'isDefault': true,
          }
        });
        await firestore.collection('users').doc(uid).update({
          'phoneNumber': phoneNumber,
        });
        var docSnapshot = await firestore.collection('users').doc(uid).get();
        return ShippingAddressModel.fromMap(docSnapshot.data()!['address']);
      } else {
        var docRef = await firestore
            .collection('users')
            .doc(uid)
            .collection('shipping_address')
            .add(
          {
            'contactName': contactName,
            'email': email,
            'phoneNumber': phoneNumber,
            'addressLine1': addressLine1,
            'addressLine2': addressLine2,
            'country': country,
            'city': city,
            'zipCode': zipCode,
            'isDefault': isDefault,
          },
        );
        var docSnapshot = await docRef.get();
        return ShippingAddressModel.fromMap(docSnapshot.data()!);
      }
    } catch (_) {
      throw UnexpectedErrorException();
    }
  }

  @override
  Future<List<CreditCardModel>> getAllCreditCards() async {
    String uid = auth.currentUser!.uid;
    List<CreditCardModel> cards = [];
    try {
      var querySnapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('credit_cards')
          .get();

      for (var i = 0; i < querySnapshot.docs.length; i++) {
        cards.add(CreditCardModel.fromMap(querySnapshot.docs[i].data()));
      }
      return cards;
    } catch (_) {
      throw UnexpectedErrorException();
    }
  }

  @override
  Future<dynamic> getAllShippingAddress() async {
    String uid = auth.currentUser!.uid;
    List<ShippingAddressModel> address = [];
    try {
      var query = await firestore.collection('users').doc(uid).get();
      if (query.data()!['address'] != null) {
        return ShippingAddressModel.fromMap(query.data()!['address']!);
      } else {
        var querySnapshot = await firestore
            .collection('users')
            .doc(uid)
            .collection('shipping_address')
            .get();

        for (var i = 0; i < querySnapshot.docs.length; i++) {
          address
              .add(ShippingAddressModel.fromMap(querySnapshot.docs[i].data()));
        }
        return address;
      }
    } catch (_) {
      throw UnexpectedErrorException();
    }
  }

  @override
  Future<List<OrderModel>> getAllOrders() async {
    String uid = auth.currentUser!.uid;
    List<OrderModel> orders = [];
    try {
      var querySnapshot = await firestore
          .collection('orders')
          .where('uid', isEqualTo: uid)
          .get();

      for (var i = 0; i < querySnapshot.docs.length; i++) {
        orders.add(OrderModel.fromMap(querySnapshot.docs[i].data()));
      }
      return orders;
    } catch (_) {
      throw UnexpectedErrorException();
    }
  }
}
