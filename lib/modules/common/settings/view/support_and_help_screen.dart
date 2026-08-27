import 'package:flutter/material.dart';

import '../../../../core/components/app_appbar.dart';
import '../../../../core/utils/constants/app_strings.dart';

class SupportAndHelpScreen extends StatelessWidget {
  const SupportAndHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: AppStrings.helpAndSupport),
      body: const SizedBox.shrink(),
    );
  }
}
