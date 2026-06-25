import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/info_row_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/rent_installment_bloc.dart';
import '../../model/rent_installment_model.dart';

class InstallmentRequestCardWidget extends StatelessWidget {
  const InstallmentRequestCardWidget({super.key, required this.request});

  final RentInstallmentRequestModel request;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 16.height),
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request.propertyName,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textFieldTitle,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.width,
                  vertical: 4.height,
                ),
                decoration: BoxDecoration(
                  color: RentInstallmentBloc.statusInfo(
                    request.status,
                  ).color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.radius),
                  border: Border.all(
                    color: RentInstallmentBloc.statusInfo(request.status).color,
                  ),
                ),
                child: Text(
                  RentInstallmentBloc.statusInfo(request.status).label,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w600,
                    color: RentInstallmentBloc.statusInfo(request.status).color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.height),
          InfoRow(
            label: AppStrings.requestNumberLabel,
            value: request.requestNumber,

            colors: colors,
          ),
          SizedBox(height: 6.height),
          InfoRow(
            isSpaceBetween: true,
            label: AppStrings.rentValueLabel,
            value: '${formatPrice(request.rentValue)} ${AppStrings.currency}',
            colors: colors,
          ),
          SizedBox(height: 6.height),
          InfoRow(
            isSpaceBetween: true,

            label: AppStrings.installmentPlanMonthsLabel,
            value: '${request.planMonths} ${AppStrings.processingHoursLabel}',
            colors: colors,
          ),
          SizedBox(height: 6.height),
          InfoRow(
            isSpaceBetween: true,

            label: AppStrings.installmentProviderLabel,
            value: request.providerName,
            colors: colors,
          ),
          SizedBox(height: 12.height),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle_outline_rounded,
                size: 16.width,
                color: RentInstallmentBloc.requestNoteStatus(request.status).$2,
              ),
              SizedBox(width: 6.width),
              Expanded(
                child: Text(
                  RentInstallmentBloc.requestNoteStatus(request.status).$1,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: RentInstallmentBloc.requestNoteStatus(
                      request.status,
                    ).$2,
                  ),
                ),
              ),
            ],
          ),
          if (request.status == 'rejected') ...[
            SizedBox(height: 12.height),
            AppButton(
              text: AppStrings.viewReasonBtn,
              onTap: () {},
              isOutline: true,
              textSize: 14,
              height: 44.height,
              btnPadding: EdgeInsets.zero,
            ),
          ],
        ],
      ),
    );
  }
}
