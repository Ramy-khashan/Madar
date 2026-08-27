import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_validator.dart';

class PriceInputSection extends StatelessWidget {
  const PriceInputSection({
    super.key,
    required this.controller,
    required this.tc,
  });
  final TextEditingController controller;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.fieldErrors[AddPropertyField.price] !=
          curr.fieldErrors[AddPropertyField.price],
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              controller: controller,
              title: AppStrings.listingPrice,
              hint: '0',
              textInputType: TextInputType.number,
              errorText: state.fieldErrors[AddPropertyField.price],
              suffixIconWidget: Padding(
                padding: EdgeInsetsDirectional.only(top: 12.height),
                child: Text(
                  AppStrings.currency,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    color: tc.primaryBrand,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 6.height),
            Row(
              children: [
                ImageItem(
                  AppImages.doneIcon,
                  color: AppThemeColors.of(context).textFieldTitle,
                  width: 14.width,
                  height: 14.width,
                ),
                SizedBox(width: 4.width),
                Text(
                  AppStrings.competitivePriceInRange,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(11),
                    fontWeight: FontWeight.w500,
                    color: AppThemeColors.of(context).textFieldTitle,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
