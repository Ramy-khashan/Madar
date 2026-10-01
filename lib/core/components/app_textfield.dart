import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/functions/common_fun.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';
import 'app_textfield_focus_cubit.dart';

class AppTextField extends StatelessWidget {
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final String? hint;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final VoidCallback? onEditingComplete;
  final TextEditingController? controller;
  final String? title;
  final VoidCallback? onTapSuffixIcon;
  final VoidCallback? onTapPrefixIcon;
  final VoidCallback? onTapField;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final String? suffixImage;
  final String? prefixImage;
  final double? suffixIconSize;
  final double? prefixIconSize;
  final List<TextInputFormatter> inputFormatters;
  final Widget? prefixIconWidget;
  final Widget? suffixIconWidget;
  final Color? fillColor;
  final Color? borderColor;
  final Color? hintColor;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final bool isReadOnly;
  final bool isWithTitle;
  final bool isUnderLineBorder;
  final bool isDense;
  final bool enabled;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? titleStyle;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final double? bottomPadding;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final EdgeInsetsGeometry? prefixIconPadding;
  final EdgeInsetsGeometry? suffixIconPadding;
  final String? errorText;
  final TextStyle? errorStyle;
  final AutovalidateMode? autovalidateMode;
  final bool isPrice;

  const AppTextField({
    super.key,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.hint,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.validator,
    this.onEditingComplete,
    this.controller,
    this.title,
    this.onTapSuffixIcon,
    this.onTapPrefixIcon,
    this.onTapField,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixImage,
    this.prefixImage,
    this.suffixIconSize,
    this.prefixIconSize,
    this.inputFormatters = const [],
    this.prefixIconWidget,
    this.suffixIconWidget,
    this.fillColor,
    this.borderColor,
    this.hintColor,
    this.prefixIconColor,
    this.suffixIconColor,
    this.isReadOnly = false,
    this.isWithTitle = true,
    this.isUnderLineBorder = false,
    this.isDense = false,
    this.enabled = true,
    this.borderRadius = 32,
    this.borderWidth = 1,
    this.contentPadding,
    this.hintStyle,
    this.titleStyle,
    this.onChanged,
    this.onSubmitted,
    this.bottomPadding,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.prefixIconPadding,
    this.suffixIconPadding,
    this.errorText,
    this.errorStyle,
    this.autovalidateMode,
    this.isPrice = false,
  }) : assert(
         !(obscureText && maxLines > 1),
         'obscureText cannot be used with multiline',
       );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppTextFieldFocusCubit(focusNode),
      child: BlocBuilder<AppTextFieldFocusCubit, bool>(
        builder: (context, isFocused) {
          final tc = AppThemeColors.of(context);
          final activeFocusNode = context.read<AppTextFieldFocusCubit>().node;

          final effectiveFillColor = !enabled
              ? (fillColor ?? tc.textFieldFill).withValues(alpha: 0.5)
              : fillColor ?? tc.textFieldFill;

          final padding =
              contentPadding ??
              EdgeInsets.symmetric(horizontal: 12.width, vertical: 14.height);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isWithTitle && title != null) ...[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: bottomPadding ?? 8.height,
                    top: 14.height,
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style:
                        titleStyle ??
                        TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConstant.appHeaderFont,
                          color: isFocused
                              ? (borderColor ?? tc.primaryBrand)
                              : tc.textFieldTitle,
                        ),
                    child: Text(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],

              TextFormField(
                enabled: enabled,
                controller: controller,
                focusNode: activeFocusNode,
                obscureText: obscureText,
                readOnly: isReadOnly,
                maxLines: maxLines,
                minLines: minLines,
                maxLength: maxLength,
                textAlign: textAlign,
                textInputAction: textInputAction,
                keyboardType: textInputType,
                inputFormatters: [
                  if (isPrice) ThousandsSeparatorInputFormatter(),
                  ...inputFormatters,
                ],
                validator: validator,
                onChanged: onChanged,
                onTap: onTapField,
                onEditingComplete: onEditingComplete,
                onFieldSubmitted: onSubmitted,
                cursorColor: borderColor ?? tc.primaryBrand,
                autovalidateMode:
                    autovalidateMode ?? AutovalidateMode.onUserInteraction,

                onTapUpOutside: (_) {
                  FocusScope.of(context).unfocus();
                },

                style: TextStyle(
                  color: enabled ? tc.textPrimary : tc.textSecondary,
                  fontSize: context.responsiveFontScale(18),
                ),

                decoration: InputDecoration(
                  filled: true,
                  fillColor: effectiveFillColor,
                  isDense: isDense,
                  contentPadding: padding,
                  hintText: hint,
                  errorText: errorText,
                  counterText: '',
                  hintStyle:
                      hintStyle ??
                      TextStyle(
                        fontSize: context.responsiveFontScale(16),
                        color: hintColor ?? tc.textFieldHint,
                        fontFamily: AppConstant.appFont,
                      ),
                  errorStyle:
                      errorStyle ??
                      TextStyle(
                        fontSize: context.responsiveFontScale(12),
                        fontFamily: AppConstant.appFont,
                      ),

                  border: _buildBorder(tc),
                  enabledBorder: _buildBorder(tc),
                  focusedBorder: _buildBorder(tc, isFocused: true),
                  disabledBorder: _buildBorder(tc, isDisabled: true),
                  errorBorder: _buildBorder(tc, isError: true),
                  focusedErrorBorder: _buildBorder(
                    tc,
                    isFocused: true,
                    isError: true,
                  ),

                  prefixIconConstraints: prefixIconConstraints,
                  suffixIconConstraints: suffixIconConstraints,
                  prefixIcon: _buildPrefix(tc, isFocused),
                  suffixIcon: _buildSuffix(tc, isFocused),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  InputBorder _buildBorder(
    AppThemeColors tc, {
    bool isFocused = false,
    bool isDisabled = false,
    bool isError = false,
  }) {
    final Color color;
    if (isError) {
      color = const Color(0xFFB00020);
    } else if (isDisabled) {
      color = (borderColor ?? tc.textFieldBorder).withValues(alpha: 0.4);
    } else if (isFocused) {
      color = borderColor ?? tc.primaryBrand;
    } else {
      color = borderColor ?? tc.textFieldBorder;
    }

    final side = BorderSide(
      color: color,
      width: isFocused ? borderWidth + 0.5 : borderWidth,
    );

    if (isUnderLineBorder) {
      return UnderlineInputBorder(borderSide: side);
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: side,
    );
  }

  Widget? _buildPrefix(AppThemeColors tc, bool isFocused) {
    if (prefixIconWidget != null) return prefixIconWidget;

    final effectivePrefixPadding =
        prefixIconPadding ?? EdgeInsets.symmetric(horizontal: 12.width);

    if (prefixIcon != null) {
      return GestureDetector(
        onTap: onTapPrefixIcon,
        child: Padding(
          padding: effectivePrefixPadding,
          child: Icon(
            prefixIcon,
            size: prefixIconSize ?? 22,
            color: isFocused
                ? (prefixIconColor ?? tc.primaryBrand)
                : (prefixIconColor ?? tc.textFieldBorder),
          ),
        ),
      );
    }

    if (prefixImage != null) {
      return SizedBox(
        child: GestureDetector(
          onTap: onTapPrefixIcon,
          child: Padding(
            padding: effectivePrefixPadding,
            child: IntrinsicHeight(
              child: ImageItem(
                prefixImage!,
                width: prefixIconSize ?? 18,
                height: prefixIconSize ?? 18,
                color: prefixIconColor,
              ),
            ),
          ),
        ),
      );
    }

    return null;
  }

  Widget? _buildSuffix(AppThemeColors tc, bool isFocused) {
    final effectiveSuffixPadding =
        suffixIconPadding ?? EdgeInsets.symmetric(horizontal: 12.width);
    if (suffixIconWidget != null) return suffixIconWidget;

    if (suffixIcon != null) {
      return GestureDetector(
        onTap: onTapSuffixIcon,
        child: Padding(
          padding: effectiveSuffixPadding,
          child: Icon(
            suffixIcon,
            size: suffixIconSize ?? 22,
            color: isFocused
                ? (suffixIconColor ?? tc.primaryBrand)
                : (suffixIconColor ?? tc.textFieldBorder),
          ),
        ),
      );
    }

    if (suffixImage != null) {
      return GestureDetector(
        onTap: onTapSuffixIcon,
        child: Padding(
          padding: effectiveSuffixPadding,
          child: ImageItem(
            suffixImage!,
            width: suffixIconSize ?? 18,
            height: suffixIconSize ?? 18,
            color: suffixIconColor,
          ),
        ),
      );
    }

    return null;
  }
}
