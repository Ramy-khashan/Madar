import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/account_role.dart';
import '../../../../../../core/utils/functions/guest_mode.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import 'broker_step6_buttons.dart';

class Step6Buttons extends StatelessWidget {
  const Step6Buttons({super.key, required this.tc});
  final AppThemeColors tc;

  bool get _isBroker => AccountRole.isBroker;

  @override
  Widget build(BuildContext context) {
    if (_isBroker) return const BrokerStep6Buttons();
    return Padding(
      padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
      child: Column(
        children: [
          AppButton(
            text: AppStrings.saveToMyPropertyFiles,
            onTap: () {
              if (!GuestMode.requireAuth(
                context,
                subtitle: AppStrings.guestCompleteProcess,
              )) {
                return;
              }
              AddPropertyBloc.get(context).add(const ShowPortfolioSheetEvent());
            },
          ),
          12.height.toSizedBox,
          AppButton(
            text: AppStrings.sendToBrokerProperty,
            isOutline: true,
            onTap: () {
              if (!GuestMode.requireAuth(
                context,
                subtitle: AppStrings.guestCompleteProcess,
              )) {
                return;
              }
              AddPropertyBloc.get(context).add(
                const ConfirmSaveEvent(openChooseBrokerOnSuccess: true),
              );
            },
          ),
        ],
      ),
    );
  }
}
