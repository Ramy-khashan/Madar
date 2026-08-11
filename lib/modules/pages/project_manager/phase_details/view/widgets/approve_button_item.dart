
import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/phase_details_bloc.dart';

class ApproveButtonItem extends StatelessWidget {
  const ApproveButtonItem({super.key, required this.state, required this.tc, required this.projectId});
  final PhaseDetailsState state;
  final String projectId;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    final canApprove =
       (state.phase.status??'').toLowerCase() != 'completed';
    return Padding(
      padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
      child: AppButton(
        text: (state.phase.status??'').toLowerCase() == 'completed'
            ? AppStrings.phaseApproved
            : AppStrings.phaseApprove,
        isLoading: state.loadingStatus == RequestStatus.loading,
        onTap: canApprove
            ? () => PhaseDetailsBloc.get(context).add(ApprovePhaseEvent(projectId: projectId))
            : null,
        colorBG: canApprove ? tc.primaryBrand : tc.borderColor,
        textColor: canApprove ? tc.onPrimary : tc.textSecondary,
      ),
    );
  }
}
