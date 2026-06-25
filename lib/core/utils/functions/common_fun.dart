import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../config/theme/app_theme_colors.dart';
import '../../../madar_app.dart';
import '../constants/app_colors.dart';


String formatPrice(double price) {
  final formatter = NumberFormat('#,###');
  return formatter.format(price);
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
