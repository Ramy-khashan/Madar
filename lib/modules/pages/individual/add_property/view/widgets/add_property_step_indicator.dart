import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class AddPropertyStepIndicator extends StatelessWidget {
  const AddPropertyStepIndicator({super.key, required this.tc});
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) => prev.indicatorIndex != curr.indicatorIndex,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.fromLTRB(16.width, 4.height, 16.width, 12.height),
          child: Row(
            children: List.generate(AddPropertyState.totalIndicatorSteps, (i) {
              final isActive = i <= state.indicatorIndex;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.width),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 4,
                    decoration: BoxDecoration(
                      color: isActive ? tc.primaryBrand : tc.borderColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
