import 'package:wtech_dashboard/features/authentication/domain/entities/admin_entity.dart';

class AdminModel extends AdminE {
  const AdminModel({
    required super.email,
    required super.password,
    super.address,
    super.firstName,
    super.lastName,
    super.phoneNumber,
    super.profilePicture,
  });

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        phoneNumber: map['phoneNumber'],
        address: map['address'],
        profilePicture: map['profilePicture'],
        password: map['password']);
  }
}
