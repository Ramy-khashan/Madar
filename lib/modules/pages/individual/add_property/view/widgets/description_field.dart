import 'package:flutter/material.dart';

import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/constants/app_strings.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      title: AppStrings.descriptionLabel,
      hint: AppStrings.descriptionHint,
      maxLines: 5,
      minLines: 4,
      textInputAction: TextInputAction.newline,
      textInputType: TextInputType.multiline,
    );
  }
}
