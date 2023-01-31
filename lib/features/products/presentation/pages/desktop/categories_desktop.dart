import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_dashboard/core/widgets/button.dart';
import 'package:wtech_dashboard/core/widgets/r_text_field.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/validators/categories_form.dart';
import '../../../../../core/widgets/main_container.dart';
import '../../widgets/categories_table.dart';
import '../../widgets/image_viewr.dart';
import '../../widgets/image_zoom.dart';

class CategoriesScreenDesktop extends StatefulWidget {
  const CategoriesScreenDesktop({super.key});

  @override
  State<CategoriesScreenDesktop> createState() =>
      _CategoriesScreenDesktopState();
}

class _CategoriesScreenDesktopState extends State<CategoriesScreenDesktop> {
  File? _categoryImage = File('path');
  final ValueNotifier<bool> _isHovered = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Categories',
                    style: Theme.of(context).textTheme.headline4),
                ButtonPrimary(
                  onPressed: () {},
                  iconData: Icons.add,
                  text: 'Create new',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: MainContainer(
                    height: 480,
                    child: ReactiveForm(
                      formGroup: categoriesForm,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                RTextFormField(
                                  controllerName: 'Name',
                                  label: 'Type..',
                                  validationMessages: categoriesValidator(),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Description',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                RTextFormField(
                                  maxLines: 5,
                                  controllerName: 'Description',
                                  label: 'Type..',
                                  validationMessages: categoriesValidator(),
                                ),
                              ],
                            ),
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
                                            allowedExtensions: ['jpg', 'png'],
                                          );
                                          if (uploaded != null) {
                                            var file = uploaded.paths.first;
                                            setState(() {
                                              _categoryImage = File(file!);
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
                                  Visibility(
                                    visible: _categoryImage != null,
                                    child: ImageViewer(
                                      remove: () async {
                                        setState(() {
                                          _categoryImage = null;
                                        });
                                      },
                                      zoom: () {
                                        zoomImage(
                                            context, 0, null, _categoryImage);
                                      },
                                      isHoveredSingle: _isHovered,
                                      image: _categoryImage,
                                      index: 0,
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  flex: 4,
                  child: MainContainer(
                    height: 480,
                    child: StatefulBuilder(builder: (context, setState) {
                      return const CategoryDataTable(
                        showCheckBox: true,
                        columns: [
                          'ID',
                          'Name',
                          'Description',
                          'Orders',
                          'Action'
                        ],
                        rows: [],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
