import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../pages/business/business_properties/view/widgets/request_action_dialogs.dart';
import '../../controller/property_details_bloc.dart';

class BrokerRequestActions extends StatelessWidget {
  const BrokerRequestActions({super.key, required this.state});

  final PropertyDetailsState state;

  Future<void> _accept(BuildContext context) async {
    final license = await showDialog<String>(
      context: context,
      builder: (_) =>
          AcceptRequestDialog(initialLicense: state.adLicenseNumber ?? ''),
    );
    if (license == null || license.isEmpty || !context.mounted) return;
    context.read<PropertyDetailsBloc>().add(
      PropertyDetailsBrokerAccept(adLicenseNumber: license),
    );
  }

  Future<void> _reject(BuildContext context) async {
    final reason = await showDialog<String>(
      context: context,
      builder: (_) => const RejectRequestDialog(),
    );
    if (reason == null || reason.isEmpty || !context.mounted) return;
    context.read<PropertyDetailsBloc>().add(
      PropertyDetailsBrokerReject(rejectReason: reason),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loading = state.actionStatus == RequestStatus.loading;
    return Row(
      children: [
        Expanded(
          child: AppButton(
            childText: AppStrings.businessPropertiesAccept,
            childIcon: Icons.check,
            colorBG: AppColors.successColor,
            isLoading: loading,
            onTap: () => _accept(context),
          ),
        ),
        SizedBox(width: 12.width),
        Expanded(
          child: AppButton(
            childText: AppStrings.businessPropertiesReject,
            childIcon: Icons.close,
            colorBG: AppColors.errorColor.shade100,
            textColor: AppColors.errorColor,
            borderColor: AppColors.errorColor,
            isLoading: loading,
            onTap: () => _reject(context),
          ),
        ),
      ],
    );
  }
}
