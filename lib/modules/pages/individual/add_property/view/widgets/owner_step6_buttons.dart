import 'package:flutter/material.dart';

import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/guest_mode.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import 'owner_publish_license_sheet.dart';

class OwnerStep6Buttons extends StatelessWidget {
  const OwnerStep6Buttons({super.key});

  Future<void> _publish(BuildContext context) async {
    if (!GuestMode.requireAuth(
      context,
      subtitle: AppStrings.guestCompleteProcess,
    )) {
      return;
    }
    final licenses = await OwnerPublishLicenseSheet.show(context);
    if (licenses == null || !context.mounted) return;
    AddPropertyBloc.get(context).add(
      ConfirmSaveEvent(
        adLicenseNumber: licenses.adLicenseNumber,
        falLicenseNumber: licenses.falLicenseNumber,
      ),
    );
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
              AddPropertyBloc.get(context).add(const ShowPortfolioSheetEvent());
            },
          ),
        ],
      ),
    );
  }
}
