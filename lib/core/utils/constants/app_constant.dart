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

  static List<Map<String, String>> get areaTypes => [
    {'id': 'office', 'label': 'office'.trans},
    {'id': 'shop', 'label': 'shop'.trans},
    {'id': 'warehouse', 'label': 'warehouse'.trans},
    {'id': 'commercial_building', 'label': 'commercial_building'.trans},
  ];

  static List<String> get finishingLevels => [
    'STANDARD',
    'LUXURY',
    'SUPER_LUXE',
  ];

  static List<String> get purposes => ['SALE', 'RENT'];

  static List<String> get propertyAges => [
    'NEW',
    'ONE_TO_FIVE',
    'FIVE_TO_TEN',
    'TEN_PLUS',
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

  static List<String> get propertyTypes => [
    'APARTMENT',
    'VILLA',
    'FLOOR',
    'TOWNHOUSE',
    'LAND',
    'BUILDING',
    'TOWER',
    'RESTHOUSE',
    'OFFICE',
    'SHOP',
    'WAREHOUSE',
    'FARM',
  ];
  static List<String> get basicServices => [
    'INTERNET',
    'WATER',
    'ELECTRICITY',
    'SEWAGE',
    'ELEVATOR',
    'CENTRAL_AC',
    'PARKING',
    'SECURITY',
    'CCTV',
    'ELECTRONIC_GATE',
  ];
  static List<String> get propertyFeature => [
    'DRIVER_ROOM',
    'MAID_ROOM',
    'BASEMENT',
    'ROOF',
    'STORAGE',
    'TWO_ENTRANCES',
    'CAR_SHADE',
    'PARKING',
    'GARDEN',
    'POOL',
    'WATER_WELL',
    'ROOFTOP',
    'HEALTH_CLUB',
    'MOSQUE_IN_COMPOUND',
  ];
  static List<String> get furnishingOptions=>[
    "FURNISHED", "UNFURNISHED"
  ];  static List<String> get availabilityOptions=>[
    "EXIST", "NOT_EXIST"
  ];

}
