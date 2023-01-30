import 'package:equatable/equatable.dart';

class UserE extends Equatable {
  final String? userId;
  final String userName;
  final String email;
  final String phoneNumber;
  final String? profilePicture;
  final Map<String, dynamic>? address;
  final bool isVerified;

  const UserE({
    required this.userId,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    this.profilePicture,
    this.address,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [
        userId,
        userName,
        email,
        phoneNumber,
        profilePicture,
        address,
        isVerified
      ];

  @override
  bool get stringify => true;
}
