import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../widgets/rate_property_form_item.dart';
import '../../controller/rate_property_certified_bloc.dart';

class Step1PropertyData extends StatelessWidget {
  const Step1PropertyData({
    super.key,
    required this.colors,
    required this.state,
  });

  final AppThemeColors colors;
  final RatePropertyCertifiedState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 16.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            AppStrings.propertyType,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontWeight: FontWeight.w600,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
          SizedBox(height: 8.height),
          RatePropertyFormItem(
            propertyController: RatePropertyCertifiedBloc.get(context).propertyController,
            properties: const [],
            onSearch: (value) {
              // Implement property search if needed in future
            },
            onSelectProperty: (value) {
              // Implement property selection if needed in future
            },
            ratePropertyArea: RatePropertyCertifiedBloc.get(
              context,
            ).areaController,
            propertyLocation: RatePropertyCertifiedBloc.get(
              context,
            ).locationController,
            propertyAge:state.propertyAge,
            finishingLevel: state.finishingLevel,
            purpose: state.purpose,
            onPropertyAgeChanged: (v) => context
                .read<RatePropertyCertifiedBloc>()
                .add(RatePropertyCertifiedFieldChanged(propertyAge: v)),
            onFinishingLevelChanged: (v) => context
                .read<RatePropertyCertifiedBloc>()
                .add(RatePropertyCertifiedFieldChanged(finishingLevel: v)),
            onPurposeChanged: (v) => context
                .read<RatePropertyCertifiedBloc>()
                .add(RatePropertyCertifiedFieldChanged(purpose: v)),
            selectedType: state.selectedType,
            onTapPropertyType: (String p1) {
              context.read<RatePropertyCertifiedBloc>().add(
                RatePropertyCertifiedTypeSelected(p1),
              );
            },
          ),
        ],
      ),
    );
  }
}
