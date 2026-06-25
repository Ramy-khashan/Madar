import 'package:flutter/material.dart';

import '../../../config/theme/app_theme_colors.dart';
import '../../../core/components/app_textfield.dart';

class PasswordItem extends StatefulWidget {
  const PasswordItem({super.key, required this.title,this.controller, required this.hint, this.validator});
  final String title;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<PasswordItem> createState() => _PasswordItemState();
}

class _PasswordItemState extends State<PasswordItem> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      validator: widget.validator,
      title: widget.title,
      hint: widget.hint,
      isWithTitle: true,
      controller: widget.controller,
      obscureText: !isPasswordVisible,
      textInputType: TextInputType.visiblePassword,
      suffixIconWidget: IconButton(
        icon: Icon(
          isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: AppThemeColors.of(context).textFieldHint,
        ),
        onPressed: () {
          setState(() {
            isPasswordVisible = !isPasswordVisible;
          });
        },
      ),
    );
  }
}
