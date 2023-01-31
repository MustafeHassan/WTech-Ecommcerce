import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    Key? key,
    this.images,
    required this.index,
    this.isHovered,
    required this.zoom,
    required this.remove,
    this.isNotDesktop = false,
    this.isHoveredSingle,
    this.image,
  }) : super(key: key);
  final bool isNotDesktop;

  final VoidCallback zoom;
  final VoidCallback remove;
  final List<File>? images;
  final File? image;
  final int index;
  final List<ValueNotifier<bool>>? isHovered;
  final ValueNotifier<bool>? isHoveredSingle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isNotDesktop ? double.infinity : 130,
      height: 140,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.captionColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        onHover: (value) {
          if (isHovered != null) {
            isHovered![index].value = value;
          } else {
            isHoveredSingle!.value = value;
          }
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(
                images?[index] ?? image!,
              ),
            ),
          ),
          child: ValueListenableBuilder<bool>(
            valueListenable: isHovered?[index] ?? isHoveredSingle!,
            builder: (context, value, child) {
              return Visibility(
                visible: value,
                child: Container(
                  color: AppColor.borderColor.withOpacity(0.6),
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 17,
                        backgroundColor: AppColor.white,
                        child: IconButton(
                          onPressed: remove,
                          icon: Icon(
                            Icons.delete,
                            size: 17,
                            color: AppColor.captionColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                      const SizedBox(width: 13),
                      CircleAvatar(
                        radius: 17,
                        backgroundColor: AppColor.white,
                        child: IconButton(
                          onPressed: zoom,
                          icon: Icon(
                            Icons.zoom_out_map_rounded,
                            size: 17,
                            color: AppColor.captionColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ImageViewerWeb extends StatelessWidget {
  const ImageViewerWeb({
    Key? key,
    this.images,
    required this.index,
    this.isHovered,
    required this.zoom,
    required this.remove,
    this.isNotDesktop = false,
    this.isHoveredSingle,
    this.image,
  }) : super(key: key);
  final bool isNotDesktop;

  final VoidCallback zoom;
  final VoidCallback remove;
  final List<Uint8List>? images;
  final Uint8List? image;
  final int index;
  final List<ValueNotifier<bool>>? isHovered;
  final ValueNotifier<bool>? isHoveredSingle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isNotDesktop ? double.infinity : 130,
      height: 140,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.captionColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        onHover: (value) {
          if (isHovered != null) {
            isHovered![index].value = value;
          } else {
            isHoveredSingle!.value = value;
          }
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: MemoryImage(
                images?[index] ?? image!,
              ),
            ),
          ),
          child: ValueListenableBuilder<bool>(
            valueListenable: isHovered?[index] ?? isHoveredSingle!,
            builder: (context, value, child) {
              return Visibility(
                visible: value,
                child: Container(
                  color: AppColor.borderColor.withOpacity(0.6),
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 17,
                        backgroundColor: AppColor.white,
                        child: IconButton(
                          onPressed: remove,
                          icon: Icon(
                            Icons.delete,
                            size: 17,
                            color: AppColor.captionColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                      const SizedBox(width: 13),
                      CircleAvatar(
                        radius: 17,
                        backgroundColor: AppColor.white,
                        child: IconButton(
                          onPressed: zoom,
                          icon: Icon(
                            Icons.zoom_out_map_rounded,
                            size: 17,
                            color: AppColor.captionColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
