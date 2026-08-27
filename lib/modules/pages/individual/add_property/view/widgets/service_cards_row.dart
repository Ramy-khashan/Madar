import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import 'service_card.dart';

class ServiceCardsRow extends StatelessWidget {
  const ServiceCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.hasRentInstallment != curr.model.hasRentInstallment ||
          prev.model.hasInsurance != curr.model.hasInsurance,
      builder: (context, state) {
        final tc = AppThemeColors.of(context);
        return Row(
          children: [
            Expanded(
              child: ServiceCard(
                icon: AppImages.safetyIcon,
                label: AppStrings.propertyInsuranceLabel,
                subtitle: AppStrings.comprehensiveProtection,
                isSelected: state.model.hasInsurance,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const ToggleInsuranceEvent()),
                tc: tc,
              ),
            ),
            SizedBox(width: 10.width),
            Expanded(
              child: ServiceCard(
                icon: AppImages.rentIcon,
                label: AppStrings.rentInstallmentLabel,
                subtitle: AppStrings.marketReport,
                isSelected: state.model.hasRentInstallment,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const ToggleRentInstallmentEvent()),
                tc: tc,
              ),
            ),
          ],
        );
      },
    );
  }
}
