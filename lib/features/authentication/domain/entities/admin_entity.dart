import 'package:equatable/equatable.dart';

class AdminE extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final Map<String, dynamic>? address;
  final String? profilePicture;
  final String email;
  final String password;
  const AdminE({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.profilePicture,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        password,
        email,
        address,
        profilePicture,
        phoneNumber
      ];
}
