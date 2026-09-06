import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/theme/app_theme_colors.dart';
import '../../../madar_app.dart';
import '../constants/app_colors.dart';

String formatPrice(double price) {
  final formatter = NumberFormat('#,###');
  return formatter.format(price);
}

String digitsOnly(String value) {
  final buffer = StringBuffer();
  for (final char in value.split('')) {
    final isDigit = char.compareTo('0') >= 0 && char.compareTo('9') <= 0;
    if (isDigit || char == '.') buffer.write(char);
  }
  return buffer.toString();
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = digitsOnly(newValue.text).replaceAll('.', '');
    if (digits.isEmpty) {
      return const TextEditingValue(text: '');
    }
    final formatted = formatPrice(double.parse(digits));
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

Future<void> urlLauncher(String url) async {
   if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

class AppToast {
  AppToast(
    String message, {
    double? fontSize,
    bool isError = false,
    Color? fontColor,
    Color? background,
    String? webBgColor,
  }) {
    Fluttertoast.cancel();

    Fluttertoast.showToast(
      webBgColor: webBgColor,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 7,
      toastLength: Toast.LENGTH_LONG,
      msg: message.toString(),
      fontSize: fontSize ?? 15,
      textColor: AppColors.white,
      backgroundColor: isError
          ? AppColors.errorColor
          : MadarApp.navigatorKey.currentContext == null
          ? AppColors.primary300
          : AppThemeColors.of(
              MadarApp.navigatorKey.currentContext!,
            ).primaryBrand,
    );
  }
}
