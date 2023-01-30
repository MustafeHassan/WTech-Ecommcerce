// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_picture_cubit.dart';

abstract class ProfilePictureState extends Equatable {
  const ProfilePictureState();

  @override
  List<Object> get props => [];
}

class ProfilePictureInitial extends ProfilePictureState {}

class ProfilePictureLoading extends ProfilePictureState {}

class ProfilePictureUpdated extends ProfilePictureState {
  final String profilePicture;
  const ProfilePictureUpdated({
    required this.profilePicture,
  });
  @override
  List<Object> get props => [profilePicture];
}

class ProfilePictureError extends ProfilePictureState {}
