import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/info_card_item.dart'; 
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/rent_installment_bloc.dart';
import 'how_it_work_section.dart';
import 'service_description_item.dart';

class InstallmentInfoTabWidget extends StatelessWidget {
  const InstallmentInfoTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<RentInstallmentBloc, RentInstallmentState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveHorizontalPadding,
                  vertical: 8.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ServiceDescriptionSection(colors: colors),
                    SizedBox(height: 16.height),
                    HowItWorksSection(colors: colors),
                    SizedBox(height: 16.height),
                    OutlinedSection(
                      title: AppStrings.approvedInstallmentProvidersTitle,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...state.providers.asMap().entries.map((entry) {
                            final provider = entry.value;
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 8.height),
                              decoration: BoxDecoration(
                                color: colors.backgroundSecondary,
                                borderRadius: BorderRadius.circular(24.radius),
                                border: Border.all(
                                  color: colors.borderColor,
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.all(16.width),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          provider.name,
                                          style: TextStyle(
                                            fontSize: context
                                                .responsiveFontScale(18),
                                            fontWeight: FontWeight.w600,
                                            color: colors.textFieldTitle,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.width,
                                          vertical: 4.height,
                                        ),
                                        decoration: BoxDecoration(
                                          color: colors.primaryBrand.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20.radius,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            ImageItem(
                                              AppImages.trackRequestImage,
                                              color: colors.primaryBrand,
                                            ),
                                            SizedBox(width: 4.width),
                                            Text(
                                              AppStrings.certifiedBadge,
                                              style: TextStyle(
                                                fontSize: context
                                                    .responsiveFontScale(12),
                                                color: colors.primaryBrand,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.height),
                                  Text(
                                    provider.subtitle,
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(14),
                                      color: colors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.height),
                    InfoCardItem(
                      title: AppStrings.installmentTrustNote,
                      iconImage: AppImages.safetyChecked,
                    ),
                    SizedBox(height: 16.height),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveHorizontalPadding,
                vertical: 16.height,
              ),
              child: AppButton(
                text: AppStrings.choosePropertyForInstallment,
                onTap: () {
                  RouterHandler.navigate(context, AppRouterKeys.propertiesListing);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
