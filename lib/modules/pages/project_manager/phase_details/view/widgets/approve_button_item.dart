
import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/phase_details_bloc.dart';

class ApproveButtonItem extends StatelessWidget {
  const ApproveButtonItem({super.key, required this.state, required this.tc});
  final PhaseDetailsState state;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    final canApprove =
        state.phase.canApprove && state.phase.status != 'completed';
    return Padding(
      padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
      child: AppButton(
        text: state.phase.status == 'completed'
            ? AppStrings.phaseApproved
            : AppStrings.phaseApprove,
        isLoading: state.isApproving,
        onTap: canApprove
            ? () => PhaseDetailsBloc.get(context).add(const ApprovePhaseEvent())
            : null,
        colorBG: canApprove ? tc.primaryBrand : tc.borderColor,
        textColor: canApprove ? tc.onPrimary : tc.textSecondary,
      ),
    );
  }
}
