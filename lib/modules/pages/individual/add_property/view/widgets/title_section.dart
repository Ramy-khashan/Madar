import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_validator.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.controller, required this.tc});
  final TextEditingController controller;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.fieldErrors[AddPropertyField.title] !=
          curr.fieldErrors[AddPropertyField.title],
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: controller,
              title: AppStrings.listingTitle,
              hint: AppStrings.listingTitle,
              errorText: state.fieldErrors[AddPropertyField.title],
            ),
            SizedBox(height: 6.height),
            Row(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color: AppThemeColors.of(context).textFieldTitle,
                  size: 14.width,
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
