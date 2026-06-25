import 'package:flutter/material.dart';
import '../../../../../core/components/responsive_row_column.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/storage_keys.dart';
import '../../../../../core/utils/functions/preference_utils.dart';

import '../../../../../core/components/app_button.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';

class ContractActionsPart extends StatelessWidget {
  const ContractActionsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.width),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (PreferenceUtils().getString(StorageKeys.accountType) ==
                AppConstant.individual)
              AppButton(
                width: 560.width,
                onTap: () {},
                text: AppStrings.downloadPdf,
              ),
            if (PreferenceUtils().getString(StorageKeys.accountType) ==
                AppConstant.business)
              ResponsiveRowColumn(
                isTablet: context.isTablet,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: context.isTablet ? 1 : 0,

                    child: AppButton(
                      width: 560.width,
                      onTap: () {},
                      text: AppStrings.saveContract,
                    ),
                  ),
                  SizedBox(width: 16.width, height: 16.height),
                  Expanded(
                    flex: context.isTablet ? 1 : 0,
                    child: AppButton(
                      isOutline: true,
                      width: 560.width,
                      onTap: () {},
                      text: AppStrings.renewalContract,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
