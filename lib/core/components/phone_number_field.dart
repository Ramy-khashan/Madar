import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/functions/responsive.dart';
import 'phone_number_focus_cubit.dart';

class PhoneNumberField extends StatelessWidget {
  final String? title;
  final String? hint;
  final String initialCountryCode;
  final String? initialValue;
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
    this.initialValue,
    this.onChanged,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.autovalidateMode,
    this.enabled = true,
  });

  PhoneNumber? get _parsedInitial {
    final raw = initialValue?.trim() ?? '';
    if (raw.isEmpty || !raw.startsWith('+')) return null;
    try {
      final parsed = PhoneNumber.fromCompleteNumber(completeNumber: raw);
      if (parsed.countryISOCode.isEmpty) return null;
      return parsed;
    } catch (_) {
      return null;
    }
  }

  String get _resolvedCountryCode =>
      _parsedInitial?.countryISOCode.isNotEmpty == true
      ? _parsedInitial!.countryISOCode
      : initialCountryCode;

  String? get _resolvedNationalNumber {
    final parsed = _parsedInitial;
    if (parsed != null) return parsed.number;
    final raw = initialValue?.trim() ?? '';
    return raw.isEmpty ? null : raw;
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
    return BlocProvider(
      create: (_) => PhoneNumberFocusCubit(),
      child: BlocBuilder<PhoneNumberFocusCubit, bool>(
        builder: (context, isFocused) {
          final tc = AppThemeColors.of(context);
          final focusNode = context.read<PhoneNumberFocusCubit>().node;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 8.height, top: 14.height),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontWeight: FontWeight.w700,
                      fontFamily: AppConstant.appHeaderFont,
                      color: isFocused ? tc.primaryBrand : tc.textFieldTitle,
                    ),
                    child: Text(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: IntlPhoneField(
                  focusNode: focusNode,
                  enabled: enabled,
                  initialCountryCode: _resolvedCountryCode,
                  initialValue: _resolvedNationalNumber,
                  textInputAction: textInputAction,
                  autovalidateMode:
                      autovalidateMode ??
                      (validator != null
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled),
                  onChanged: onChanged,
                  validator: validator,
                  cursorColor: tc.primaryBrand,
                  showCountryFlag: false,
                  style: TextStyle(
                    color: enabled ? tc.textPrimary : tc.textSecondary,
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
                    fillColor: enabled
                        ? tc.textFieldFill
                        : tc.textFieldFill.withAlpha(128),
                    hintText: hint,
                    counterText: '',
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
        },
      ),
    );
  }
}
