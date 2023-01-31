import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

Future<dynamic> zoomImage(BuildContext context, int index,
    [List<File>? images, File? image]) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      actionsAlignment: MainAxisAlignment.center,
      title: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.clear,
          color: AppColor.white,
          size: 50,
        ),
      ),
      content: Image.file(
        images?[index] ?? image!,
      ),
    ),
  );
}

Future<dynamic> zoomImageWeb(BuildContext context, int index,
    [List<Uint8List>? images, Uint8List? image]) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      actionsAlignment: MainAxisAlignment.center,
      title: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.clear,
          color: AppColor.white,
          size: 50,
        ),
      ),
      content: Image.memory(
        images?[index] ?? image!,
      ),
    ),
  );
}
