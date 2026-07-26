import 'package:flutter/material.dart';
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

Future<void> urlLauncher(String url) async {
  print('urlLauncher: $url');
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
