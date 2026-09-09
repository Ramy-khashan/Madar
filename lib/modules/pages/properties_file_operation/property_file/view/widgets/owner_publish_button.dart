import 'package:flutter/material.dart';

import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/account_role.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../individual/add_property/view/widgets/owner_publish_license_sheet.dart';
 import '../../controller/property_file_bloc.dart';

class OwnerPublishButton extends StatelessWidget {
  const OwnerPublishButton({
    super.key,
    required this.bloc,
    required this.state,
  });

  final PropertyFileBloc bloc;
  final PropertyFileState state;

  bool get _canPublish =>
      AccountRole.isOwner &&
      state.details != null &&
      !state.details!.isPublished;

  @override
  Widget build(BuildContext context) {
    if (!_canPublish) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: 16.height, bottom: 12.height),
      child: AppButton(
        text: AppStrings.publishAd,
        isLoading: state.publishStatus == RequestStatus.loading,
        onTap: () async {
          final licenses = await OwnerPublishLicenseSheet.show(context);
          if (licenses == null || !context.mounted) return;
          bloc.add(
            PropertyFilePublishRequested(
              adLicenseNumber: licenses.adLicenseNumber,
              falLicenseNumber: licenses.falLicenseNumber,
            ),
          );
        },
      ),
    );
  }
}
