import 'package:universal_io/io.dart';
import 'dart:html' as html;
import 'dart:math';

import 'dart:convert';
import 'package:path/path.dart' as path;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_dashboard/core/validators/product_form.dart';
import 'package:wtech_dashboard/core/validators/search_validator.dart';
import 'package:wtech_dashboard/core/widgets/drop_down_button.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../../core/theme/colors.dart';
import '../../../../../core/widgets/button.dart';
import '../../widgets/image_viewr.dart';
import '../../widgets/image_zoom.dart';
import '../../widgets/product_form.dart';

class AddProductScreenDesktop extends StatefulWidget {
  const AddProductScreenDesktop({super.key});

  @override
  State<AddProductScreenDesktop> createState() =>
      _AddProductScreenDesktopState();
}

class _AddProductScreenDesktopState extends State<AddProductScreenDesktop> {
  final List<Map<String, dynamic>> _imagesToUpload = [];
  final List<Uint8List> _imageBytes = [];
  List<dynamic> loadedJson = [];
  List<String> imageUrls = [];
  int indexJson = 8;
  List<ValueNotifier<bool>> _isHovered = [];

  Future<List<dynamic>> loadJson(String filePath) async {
    final String jsonString = await rootBundle.loadString(filePath);
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse;
  }

  Future<void> brandsToCloud() async {
    var printers = loadJson('animations/printers.json');
    var storageList = await FirebaseStorage.instance
        .ref()
        .child(
          'categories/',
        )
        .listAll();
    var storageProduct = await FirebaseStorage.instance
        .ref()
        .child(
          'products/printers/',
        )
        .listAll();

    List<Map<String, dynamic>> map = [];

    for (var i = 0; i < storageList.items.length; i++) {
      String imageUrl = await storageList.items[i].getDownloadURL();
      map.add(
        {
          'categoreyId': Random().nextInt(9999),
          'categoreyName': storageList.items[i].name
              .split('.')
              .first
              .replaceFirst(
                  storageList.items[i].name.split('.').first[0],
                  storageList.items[i].name.split('.').first[0].toUpperCase(),
                  0),
          'categoreyImageUrl': imageUrl,
        },
      );
    }
    for (var element in map) {
      FirebaseFirestore.instance.collection('categories').add(element);
    }
    print('Done');
  }

  void toFirestore(Map<String, dynamic> data) async {
    debugPrint('$data is Added To Cloud Firestore!');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColor.bgColor,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Spacer(),
                Wrap(
                  spacing: 20,
                  children: [
                    ButtonWithIcon(
                      onPressed: () async {},
                      text: 'load json',
                    ),
                    ButtonPrimary(
                      onPressed: () async {
                        await brandsToCloud();
                      },
                      width: 120,
                      text: 'Publish now',
                    ),
                  ],
                ),
              ],
            ),
            ReactiveForm(
              formGroup: productForm,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Add Products',
                            style: Theme.of(context).textTheme.headline4),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 35,
                            right: 50,
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
                                        controllerName:
                                            'Specification - $index',
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
                        const FullDescription(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
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
                                      width: 130,
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
                                              type: FileType.image,
                                              allowMultiple: true,
                                            );
                                            if (uploaded != null) {
                                              for (var element
                                                  in uploaded.files) {
                                                _imagesToUpload.add({
                                                  'imageName': element.name
                                                      .toLowerCase(),
                                                  'imageData': element.bytes,
                                                });
                                                _imageBytes.add(element.bytes!);
                                              }
                                              setState(() {});
                                            }
                                            if (_imagesToUpload.isNotEmpty) {
                                              _isHovered = List.generate(
                                                _imagesToUpload.length,
                                                (index) => ValueNotifier(false),
                                              );
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
                                            imageUrls.length,
                                            (index) =>
                                                Image.network(imageUrls[index]))
                                        .toList(),
                                    ...List.generate(
                                      _imagesToUpload.length,
                                      (index) => ImageViewerWeb(
                                        remove: () {
                                          setState(() {
                                            _imagesToUpload.removeAt(index);
                                          });
                                        },
                                        zoom: () {
                                          zoomImageWeb(
                                              context, index, _imageBytes);
                                        },
                                        isHovered: _isHovered,
                                        images: _imageBytes,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
