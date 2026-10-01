import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import 'custom_sub_stage_cubit.dart';

class CustomSubStageInput extends StatelessWidget {
  const CustomSubStageInput({super.key, required this.onAdd});

  final ValueChanged<String> onAdd;

  void _submit(BuildContext context) {
    final name = context.read<CustomSubStageCubit>().takeName();
    if (name.isEmpty) return;
    onAdd(name);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomSubStageCubit(),
      child: Builder(
        builder: (context) {
          final colors = AppThemeColors.of(context);
          final controller = context.read<CustomSubStageCubit>().controller;
          return Padding(
            padding: EdgeInsets.only(bottom: 8.height, top: 4.height),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (_) => _submit(context),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: AppStrings.customSubStageHint,
                      hintStyle: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        color: colors.textSecondary,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      color: colors.textFieldTitle,
                      fontFamily: AppConstant.appFont,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _submit(context),
                  child: Text(AppStrings.addCustomSubStage),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
