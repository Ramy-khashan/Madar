import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/functions/responsive.dart';

class PhoneNumberField extends StatefulWidget {
  final String? title;
  final String? hint;
  final String initialCountryCode;
  final ValueChanged<PhoneNumber>? onChanged;
  final String? Function(PhoneNumber?)? validator;
  final TextInputAction textInputAction;
  final AutovalidateMode? autovalidateMode;
  final bool enabled;

  const PhoneNumberField({
    super.key,
    this.title,
    this.hint,
    this.initialCountryCode = 'SA',
    this.onChanged,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.autovalidateMode,
    this.enabled = true,
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  InputBorder _buildBorder(
    AppThemeColors tc, {
    bool isFocused = false,
    bool isError = false,
  }) {
    final Color color;
    if (isError) {
      color = const Color(0xFFB00020);
    } else if (isFocused) {
      color = tc.primaryBrand;
    } else {
      color = tc.textFieldBorder;
    }
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: BorderSide(color: color, width: isFocused ? 1.5 : 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.title != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.height, top: 14.height),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: _isFocused ? tc.primaryBrand : tc.textFieldTitle,
              ),
              child: Text(
                widget.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: IntlPhoneField(
            focusNode: _focusNode,
            enabled: widget.enabled,
            initialCountryCode: widget.initialCountryCode,
            textInputAction: widget.textInputAction,
            autovalidateMode: widget.autovalidateMode ??
                (widget.validator != null
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled),
            onChanged: widget.onChanged,
            validator: widget.validator,
            cursorColor: tc.primaryBrand,
            showCountryFlag: false,
            style: TextStyle(
              color: widget.enabled ? tc.textPrimary : tc.textSecondary,
              fontSize: context.responsiveFontScale(16),
              fontFamily: AppConstant.appFont,
            ),
            dropdownTextStyle: TextStyle(
              color: tc.textPrimary,
              fontSize: context.responsiveFontScale(16),
              fontFamily: AppConstant.appFont,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.enabled
                  ? tc.textFieldFill
                  : tc.textFieldFill.withAlpha(128),
              hintText: widget.hint,
              counterText: '',
              // contentPadding: EdgeInsets.symmetric(
              //   horizontal: 12.width,
              //   vertical: 14.height,
              // ),
              hintStyle: TextStyle(
                fontSize: context.responsiveFontScale(16),
                color: tc.textFieldHint,
                fontFamily: AppConstant.appFont,
              ),
              errorStyle: TextStyle(
                fontSize: context.responsiveFontScale(12),
                fontFamily: AppConstant.appFont,
              ),
              border: _buildBorder(tc),
              enabledBorder: _buildBorder(tc),
              focusedBorder: _buildBorder(tc, isFocused: true),
              disabledBorder: _buildBorder(tc),
              errorBorder: _buildBorder(tc, isError: true),
              focusedErrorBorder: _buildBorder(
                tc,
                isFocused: true,
                isError: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
 