import 'package:flutter/material.dart';

class CounterItemModel {
  final String label;
   final String icon;
  final String? suffix;
  final TextEditingController controller;

  CounterItemModel({
    required this.label,
     required this.icon,
    this.suffix,
    required this.controller,
  });
}