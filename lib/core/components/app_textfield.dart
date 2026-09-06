import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/functions/common_fun.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';

class AppTextField extends StatefulWidget {
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
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.removeListener(_onFocusChange);
      if (oldWidget.focusNode == null) _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChange);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);

    final effectiveFillColor = !widget.enabled
        ? (widget.fillColor ?? tc.textFieldFill).withValues(alpha: 0.5)
        : widget.fillColor ?? tc.textFieldFill;

    final padding = widget.contentPadding ??
        EdgeInsets.symmetric(
          horizontal: 12.width,
          vertical: 14.height,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.isWithTitle && widget.title != null) ...[
          Padding(
            padding: EdgeInsets.only(
              bottom: widget.bottomPadding ?? 8.height,
              top: 14.height,
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: widget.titleStyle ??
                  TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConstant.appHeaderFont,
                    color: _isFocused
                        ? (widget.borderColor ?? tc.primaryBrand)
                        : tc.textFieldTitle,
                  ),
              child: Text(
                widget.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],

        TextFormField(
          enabled: widget.enabled,
          controller: widget.controller,
          focusNode: _focusNode,
          obscureText: widget.obscureText,
          readOnly: widget.isReadOnly,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          textAlign: widget.textAlign,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          inputFormatters: [
            if (widget.isPrice) ThousandsSeparatorInputFormatter(),
            ...widget.inputFormatters,
          ],
          validator: widget.validator,
          onChanged: widget.onChanged,
          onTap: widget.onTapField,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onSubmitted,
          cursorColor: widget.borderColor ?? tc.primaryBrand,
          autovalidateMode:
              widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,

          onTapUpOutside: (_) {
            FocusScope.of(context).unfocus();
          },

          style: TextStyle(
            color: widget.enabled ? tc.textPrimary : tc.textSecondary,
            fontSize: context.responsiveFontScale(18),
          ),

          decoration: InputDecoration(
            filled: true,
            fillColor: effectiveFillColor,
            isDense: widget.isDense,
            contentPadding: padding,
            hintText: widget.hint,
            errorText: widget.errorText,
            counterText: '',
            hintStyle: widget.hintStyle ??
                TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  color: widget.hintColor ?? tc.textFieldHint,
                  fontFamily: AppConstant.appFont,
                ),
            errorStyle: widget.errorStyle ??
                TextStyle(
                  fontSize: context.responsiveFontScale(12),
                  fontFamily: AppConstant.appFont,
                ),

            border: _buildBorder(tc),
            enabledBorder: _buildBorder(tc),
            focusedBorder: _buildBorder(tc, isFocused: true),
            disabledBorder: _buildBorder(tc, isDisabled: true),
            errorBorder: _buildBorder(tc, isError: true),
            focusedErrorBorder: _buildBorder(tc, isFocused: true, isError: true),

            prefixIconConstraints: widget.prefixIconConstraints,
            suffixIconConstraints: widget.suffixIconConstraints,
            prefixIcon: _buildPrefix(tc),
            suffixIcon: _buildSuffix(tc),
          ),
        ),
      ],
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
      color = (widget.borderColor ?? tc.textFieldBorder).withValues(alpha: 0.4);
    } else if (isFocused) {
      color = widget.borderColor ?? tc.primaryBrand;
    } else {
      color = widget.borderColor ?? tc.textFieldBorder;
    }

    final side = BorderSide(
      color: color,
      width: isFocused ? widget.borderWidth + 0.5 : widget.borderWidth,
    );

    if (widget.isUnderLineBorder) {
      return UnderlineInputBorder(borderSide: side);
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: side,
    );
  }

  Widget? _buildPrefix(AppThemeColors tc) {
    if (widget.prefixIconWidget != null) return widget.prefixIconWidget;

    final effectivePrefixPadding =
        widget.prefixIconPadding ?? EdgeInsets.symmetric(horizontal: 12.width);

    if (widget.prefixIcon != null) {
      return GestureDetector(
        onTap: widget.onTapPrefixIcon,
        child: Padding(
          padding: effectivePrefixPadding,
          child: Icon(
            widget.prefixIcon,
            size: widget.prefixIconSize ?? 22,
            color: _isFocused
                ? (widget.prefixIconColor ?? tc.primaryBrand)
                : (widget.prefixIconColor ?? tc.textFieldBorder),
          ),
        ),
      );
    }

    if (widget.prefixImage != null) {
      return SizedBox(
        
        child: GestureDetector(
          onTap: widget.onTapPrefixIcon,
          child: Padding(
            padding: effectivePrefixPadding,
            child: IntrinsicHeight(
              child: ImageItem(
                widget.prefixImage!,
                width: widget.prefixIconSize ?? 18,
                height: widget.prefixIconSize ?? 18,
                color: widget.prefixIconColor,
              ),
            ),
          ),
        ),
      );
    }

    return null;
  }

  Widget? _buildSuffix(AppThemeColors tc) {
     final effectiveSuffixPadding =
        widget.suffixIconPadding ?? EdgeInsets.symmetric(horizontal: 12.width);
    if (widget.suffixIconWidget != null) return widget.suffixIconWidget;
   
    if (widget.suffixIcon != null) {
      return GestureDetector(
        onTap: widget.onTapSuffixIcon,
        child: Padding(
          padding: effectiveSuffixPadding,
          child: Icon(
            widget.suffixIcon,
            size: widget.suffixIconSize ?? 22,
            color: _isFocused
                ? (widget.suffixIconColor ?? tc.primaryBrand)
                : (widget.suffixIconColor ?? tc.textFieldBorder),
          ),
        ),
      );
    }

    if (widget.suffixImage != null) {
      return GestureDetector(
        onTap: widget.onTapSuffixIcon,
        child: Padding(
          padding: effectiveSuffixPadding,
          child: ImageItem(
            widget.suffixImage!,
            width: widget.suffixIconSize ?? 18,
            height: widget.suffixIconSize ?? 18,
            color: widget.suffixIconColor,
          ),
        ),
      );
    }

    return null;
  }
}