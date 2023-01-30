import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme.dart';

class OtpTextFields extends StatelessWidget {
  const OtpTextFields({
    super.key,
    this.otpController,
    required this.isLastOtpField,
    this.validateOtpCode,
  });
  final TextEditingController? otpController;
  final bool isLastOtpField;
  final VoidCallback? validateOtpCode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1,
      child: TextFormField(
        controller: otpController,
        onChanged: (value) {
          if (value.length == 1) {
            if (isLastOtpField) {
              FocusScope.of(context).unfocus();
              validateOtpCode!();
            } else {
              FocusScope.of(context).nextFocus();
            }
          } else {
            FocusScope.of(context).previousFocus();
          }
        },
        keyboardType: TextInputType.number,
        maxLength: 1,
        autofocus: true,
        style: TextStyle(fontSize: 20.sp),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: '',
          contentPadding: const EdgeInsets.only(bottom: -10),
          hintStyle: TextStyle(
            fontSize: 60.sp,
            color: AppTheme.borderColor.withOpacity(0.5),
          ),
          hintText: '.',
        ),
      ),
    );
  }
}
