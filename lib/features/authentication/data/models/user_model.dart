import 'package:wtech_ecommerce/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserE {
  const UserModel({
    required super.userId,
    required super.userName,
    required super.email,
    required super.phoneNumber,
    super.profilePicture,
    super.address,
    super.isVerified,
  });
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profilePicture: map['profilePicture'],
      address: map['address'],
      isVerified: map['isVerified'] as bool,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'address': address,
      'isVerified': isVerified,
    };
  }
}
