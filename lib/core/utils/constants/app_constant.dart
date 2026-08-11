import 'package:flutter/material.dart';

import '../functions/translation.dart';
import 'app_colors.dart';

class AppConstant {
  static const String appName = 'مدار';
  static const String splashName = 'مـــــــــدار';
  static const String splashEnName = 'MADAR';

  static const String appFont = 'app-font';
  static const String appHeaderFont = 'app-header-font';
  static const String individual = 'individual';
  static const String business = 'broker';
  static const String developer = 'project_manager';
  static const String realtor = 'realtor';
  static const String owner = 'owner';
  static const String cairoFont = 'cairo-font';
  static const String residentialProjectType = 'RESIDENTIAL';
  static const String commercialProjectType = 'COMMERCIAL';

  static List<Map<String, String>> get propertyTypes => [
    {'id': 'villa', 'label': 'property_type_villa'.trans},
    {'id': 'floor', 'label': 'property_type_floor'.trans},
    {'id': 'apartment', 'label': 'property_type_apartment'.trans},
    {'id': 'studio', 'label': 'property_type_studio'.trans},
    {'id': 'land', 'label': 'property_type_land'.trans},
  ];

  static List<Map<String, String>> get areaTypes => [
    {'id': 'office', 'label': 'office'.trans},
    {'id': 'shop', 'label': 'shop'.trans},
    {'id': 'warehouse', 'label': 'warehouse'.trans},
    {'id': 'commercial_building', 'label': 'commercial_building'.trans},
  ];

  static List<String> get finishingLevels => [
    'finishing_level_regular'.trans,
    'finishing_level_medium'.trans,
    'finishing_level_luxury'.trans,
    'finishing_level_super_lux'.trans,
  ];

  static List<String> get purposes => [
    'purpose_sell'.trans,
    'purpose_buy'.trans,
    'purpose_finance'.trans,
    'purpose_insurance'.trans,
    'purpose_rent'.trans,
  ];

  static List<String> get propertyAges => [
    'property_age_less_1'.trans,
    'property_age_1_5'.trans,
    'property_age_5_10'.trans,
    'property_age_10_20'.trans,
    'property_age_more_20'.trans,
  ];

  static List<String> get paymentSystems => [
    'payment_cash'.trans,
    'payment_installment'.trans,
  ];

  static List<String> get durations => [
    'duration_3_months'.trans,
    'duration_6_months'.trans,
    'duration_1_year'.trans,
    'duration_2_years'.trans,
  ];

  static Color getStatusColor(String status) {
    final color = switch (status) {
      'IN_PROGRESS' => AppColors.orangeColor,
      'DELAYED' => AppColors.errorColor,
      'COMPLETED' => AppColors.successColor,
      _ => AppColors.orangeColor,
    };
    return color;
  }
}
