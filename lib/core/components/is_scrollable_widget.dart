import 'package:flutter/material.dart';

import '../utils/functions/responsive.dart';

class IsScrollableWidget extends StatelessWidget {
  const IsScrollableWidget({
    super.key,
    required this.isScroll,
    required this.child,
    this.padding,
  });
  final bool isScroll;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return isScroll
        ? SingleChildScrollView(
            padding: padding ?? EdgeInsets.all(14.width),

            child: child,
          )
        : child;
  }
}
