import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_dashboard/core/validators/product_form.dart';
import 'package:wtech_dashboard/core/widgets/drop_down_button.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/widgets/button.dart';
import '../../widgets/image_viewr.dart';
import '../../widgets/product_form.dart';

class AddProductScreenMobile extends StatefulWidget {
  const AddProductScreenMobile({super.key});

  @override
  State<AddProductScreenMobile> createState() => _AddProductScreenMobileState();
}

class _AddProductScreenMobileState extends State<AddProductScreenMobile> {
  List<File> _images = [];
  List<ValueNotifier<bool>> _isHovered = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColor.bgColor,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Text('Add Products', style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonWithIcon(
                  onPressed: () {},
                  text: 'Save to draft',
                ),
                ButtonPrimary(
                  onPressed: () {},
                  width: 120,
                  text: 'Publish now',
                ),
              ],
            ),
            ReactiveForm(
              formGroup: productForm,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 35,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.white,
                    ),
                    child: Column(
                      children: [
                        ProductForm(
                          controllerName: 'Name',
                          lable: 'Type..',
                          title: 'Product Name',
                          validators: productFormValidator(),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: ProductForm(
                                controllerName: 'Color',
                                lable: 'Type..',
                                title: 'Color',
                                validators: productFormValidator(),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: ProductForm(
                                controllerName: 'Brand',
                                lable: 'Type..',
                                title: 'Brand',
                                validators: productFormValidator(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        ...List.generate(4, (index) {
                          index++;
                          return Row(
                            children: [
                              Expanded(
                                child: ProductForm(
                                  controllerName: 'Specification - $index',
                                  lable: 'Type..',
                                  title: 'Spec Title',
                                  validators: productFormValidator(),
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: ProductForm(
                                  controllerName: 'Value - $index',
                                  lable: 'Type..',
                                  title: 'Spec Value',
                                  validators: productFormValidator(),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  const FullDescription(isNotDesktop: true),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 55,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.white,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: ProductForm(
                                controllerName: 'Price',
                                lable: '0.0',
                                title: 'Price',
                                validators: productFormValidator(),
                              ),
                            ),
                            const Divider(),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: DropDownButtonCustom(
                                  width: double.infinity,
                                  menutItems: [],
                                  hintText: 'Category'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 55,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 25,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StatefulBuilder(builder: (context, setState) {
                              return Wrap(
                                spacing: 24,
                                runAlignment: WrapAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 140,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.captionColor
                                              .withOpacity(0.5)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Material(
                                      color: AppColor.bgColor,
                                      borderRadius: BorderRadius.circular(10),
                                      child: InkWell(
                                        onTap: () async {
                                          var uploaded = await FilePicker
                                              .platform
                                              .pickFiles(
                                            allowMultiple: true,
                                            allowedExtensions: ['jpg', 'png'],
                                          );
                                          if (uploaded != null) {
                                            var files = uploaded.paths
                                                .map((file) => File(file!))
                                                .toList();
                                            _isHovered = List.generate(
                                              files.length,
                                              (index) => ValueNotifier(false),
                                            );
                                            setState(() {
                                              _images = files;
                                            });
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.cloud_upload_rounded,
                                              color: AppColor.captionColor
                                                  .withOpacity(0.6),
                                              size: 40,
                                            ),
                                            Text(
                                              'Upload',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  ...List.generate(
                                    _images.length,
                                    (index) => ImageViewer(
                                      isNotDesktop: true,
                                      remove: () {
                                        setState(() {
                                          _images.removeAt(index);
                                        });
                                      },
                                      zoom: () {
                                        zoomImage(context, index);
                                      },
                                      isHovered: _isHovered,
                                      images: _images,
                                      index: index,
                                    ),
                                  ).toList(),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> zoomImage(BuildContext context, int index) {
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
          _images[index],
        ),
      ),
    );
  }
}
