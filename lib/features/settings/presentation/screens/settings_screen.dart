// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:lottie/lottie.dart';
import 'package:wtech_ecommerce/core/functions/snackbars.dart';
import 'package:wtech_ecommerce/core/routes/app_route.dart';
import 'package:wtech_ecommerce/core/theme/animations_asset.dart';
import 'package:wtech_ecommerce/core/theme/theme.dart';
import 'package:wtech_ecommerce/core/widgets/loading.dart';
import 'package:wtech_ecommerce/core/widgets/scaffold_body.dart';
import 'package:wtech_ecommerce/features/settings/presentation/cubit/profile_picture_cubit.dart';
import 'package:wtech_ecommerce/services_locator.dart' as di;

import '../../../authentication/presentation/bloc/authentication_bloc.dart';
import '../function/functions.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static var userJson = di.preferences.getString('user');

  @override
  Widget build(BuildContext context) {
    var user = jsonDecode(userJson!) as Map<String, dynamic>;
    List<Map<String, dynamic>> listTileData = [
      {
        'title': 'Order History',
        'Icon': const Icon(
          Icons.arrow_forward_ios,
        ),
        'onTap': () {
          context.pushNamed(orderHistory);
        },
      },
      {
        'title': 'My Addresses',
        'Icon': const Icon(
          Icons.arrow_forward_ios,
        ),
        'onTap': () {
          context.pushNamed(addressScreen);
        },
      },
      {
        'title': 'My Cards',
        'Icon': const Icon(
          Icons.arrow_forward_ios,
        ),
        'onTap': () {
          context.pushNamed(creditCardsScreen);
        },
      },
      {
        'title': 'Vouchers',
        'Icon': const Icon(
          Icons.arrow_forward_ios,
        ),
        'onTap': () {
          showSnackBar(
            context: context,
            iconData: Icons.info,
            title: 'There is no any vouchers available',
            statusColor: AppTheme.borderColor,
          );
        },
      },
      {
        'title': 'Nearby Stores',
        'Icon': const Icon(
          Icons.arrow_forward_ios,
        ),
        'onTap': () {
          showSnackBar(
            context: context,
            iconData: Icons.info,
            title: 'There is no any vouchers available',
            statusColor: AppTheme.borderColor,
          );
        },
      },
      {
        'title': 'Sign Out',
        'Icon': Icon(
          Icons.logout_outlined,
          color: AppTheme.captionColor,
        ),
        'onTap': () {
          context.read<AuthenticationBloc>().add(SignedOut());
        },
      },
    ];

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is UnAthenticatedState) {
          context.replaceNamed(signInScreen);
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const Loading();
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'SETTINGS',
            ),
          ),
          body: ScaffoldBody(
            child: Column(
              children: [
                SizedBox(height: 30.h),
                BlocConsumer<ProfilePictureCubit, ProfilePictureState>(
                  listener: (context, state) {
                    if (state is ProfilePictureError) {
                      showSnackBar(
                          context: context,
                          iconData: Icons.error,
                          title: 'Could not change profile picture !',
                          statusColor: AppTheme.red);
                    }
                  },
                  builder: (context, state) {
                    if (state is ProfilePictureLoading) {
                      return LottieBuilder.asset(miniLoading,
                          width: 50, height: 50);
                    }
                    if (state is ProfilePictureUpdated) {
                      return ProfilePictureWidget(
                        profilePicture: state.profilePicture,
                        id: user['id'],
                      );
                    }
                    return ProfilePictureWidget(
                      profilePicture: user['profilePicture'],
                      id: user['id'],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(user['name'],
                      style: Theme.of(context).textTheme.headline4),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 15),
                  child: Text(user['email'],
                      style: Theme.of(context).textTheme.bodyText1),
                ),
                ...List.generate(
                  listTileData.length,
                  (index) => Column(
                    children: [
                      ListTile(
                        title: Text(listTileData[index]['title'],
                            style: Theme.of(context).textTheme.bodyText1),
                        trailing: listTileData[index]['Icon'],
                        onTap: listTileData[index]['onTap'],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          color: AppTheme.captionColor.withOpacity(0.7),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget(
      {super.key, required this.profilePicture, required this.id});
  final String? profilePicture;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        profilePicture == null
            ? Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.captionColor.withOpacity(0.5),
                ),
                child: Transform.scale(
                  scale: 0.6,
                  child: Image.asset(
                    'assets/icons/image_grey.png',
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          insetPadding: const EdgeInsets.only(),
                          content: Image.network(
                            profilePicture ?? '',
                            fit: BoxFit.contain,
                          ),
                        );
                      });
                },
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundImage: NetworkImage(profilePicture!),
                ),
              ),
        Positioned(
          bottom: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              uploadImage('Camera', context, id);
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  child: Icon(
                                    CupertinoIcons.camera_fill,
                                    size: 50,
                                    color: AppTheme.white,
                                  ),
                                ),
                                SizedBox(height: 10.w),
                                Text(
                                  'Camera',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              uploadImage('Gallery', context, id);
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  child: Icon(
                                    CupertinoIcons.photo_fill_on_rectangle_fill,
                                    size: 50,
                                    color: AppTheme.white,
                                  ),
                                ),
                                SizedBox(height: 10.w),
                                Text(
                                  'Gallery',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            child: const CircleAvatar(
              child: Icon(
                CupertinoIcons.camera,
                size: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}
