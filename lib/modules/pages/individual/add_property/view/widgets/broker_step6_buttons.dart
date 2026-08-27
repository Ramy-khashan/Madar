import 'package:flutter/material.dart';

import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/guest_mode.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import 'publish_ad_license_sheet.dart';

class BrokerStep6Buttons extends StatelessWidget {
  const BrokerStep6Buttons({super.key});

  Future<void> _publish(BuildContext context) async {
    if (!GuestMode.requireAuth(
      context,
      subtitle: AppStrings.guestCompleteProcess,
    )) {
      return;
    }
    final license = await PublishAdLicenseSheet.show(context);
    if (license == null || license.isEmpty || !context.mounted) return;
    AddPropertyBloc.get(context).add(ConfirmSaveEvent(adLicenseNumber: license));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
      child: Column(
        children: [
          AppButton(
            text: AppStrings.publishAd,
            onTap: () => _publish(context),
          ),
          12.height.toSizedBox,
          AppButton(
            text: AppStrings.saveToMyPropertyFiles,
            isOutline: true,
            onTap: () {
              if (!GuestMode.requireAuth(
                context,
                subtitle: AppStrings.guestCompleteProcess,
              )) {
                return;
              }
              AddPropertyBloc.get(context).add(const ConfirmSaveEvent());
            },
          ),
        ],
      ),
    );
  }
}
