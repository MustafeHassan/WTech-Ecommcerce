import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/validators/product_form.dart';
import '../../../../core/widgets/r_text_field.dart';

class ProductForm extends StatelessWidget {
  const ProductForm({
    Key? key,
    required this.controllerName,
    required this.lable,
    required this.title,
    this.validators,
    this.maxLines,
  }) : super(key: key);
  final String controllerName;
  final String lable;
  final String title;
  final int? maxLines;
  final Map<String, String Function(Object)>? validators;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headline4),
        RTextFormField(
          maxLines: maxLines,
          validationMessages: validators,
          controllerName: controllerName,
          label: lable,
        ),
      ],
    );
  }
}

class FullDescription extends StatelessWidget {
  const FullDescription({
    Key? key,
    this.isNotDesktop = false,
  }) : super(key: key);
  final bool isNotDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 35,
        right: isNotDesktop ? 0 : 50,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.white,
      ),
      child: ProductForm(
        maxLines: 5,
        controllerName: 'Full Description',
        lable: 'Type here ..',
        title: 'Full Description',
        validators: productFormValidator(),
      ),
    );
  }
}
