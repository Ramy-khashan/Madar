import 'package:flutter/material.dart';

import '../../../../core/components/app_appbar.dart';
import '../../../../core/utils/constants/app_strings.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: AppStrings.termsAndConditions),
      body: const SizedBox.shrink(),
    );
  }
}
