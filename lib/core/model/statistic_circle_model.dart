import 'package:flutter/material.dart';

class StatisticCircleModel {
  const StatisticCircleModel({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;
}