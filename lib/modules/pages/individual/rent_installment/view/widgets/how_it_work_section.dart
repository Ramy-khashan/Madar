
import 'package:flutter/material.dart';
 
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/components/info_card_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/rent_installment_bloc.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key, required this.colors});
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.howInstallmentWorksTitle,
            style: TextStyle(
              fontSize: context.responsiveFontScale(15),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
          SizedBox(height: 16.height),
          ...RentInstallmentBloc.stepsItem.map(
            (step) => Padding(
              padding: EdgeInsets.only(bottom: 12.height),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18.width,
                    backgroundColor: AppColors.backgroundLight,
                    child: ImageItem(
                      step.icon,
                      color: colors.primaryBrand,
                      width: 20,
                    ),
                  ),
                  SizedBox(width: 10.width),
                  Expanded(
                    child: Text(
                      step.title,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
                        color: colors.textFieldTitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 4.height),
          InfoCardItem(title: AppStrings.installmentApprovalNote),
        ],
      ),
    );
  }
}
