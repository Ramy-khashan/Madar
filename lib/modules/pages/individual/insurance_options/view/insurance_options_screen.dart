import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/insurance_options_bloc.dart';
import 'widgets/insurance_options_content_widget.dart';
import 'widgets/insurance_success_dialog_widget.dart';

class InsuranceOptionsScreen extends StatelessWidget {
  const InsuranceOptionsScreen({super.key, this.propertyId = '1'});

  final String propertyId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InsuranceOptionsBloc, InsuranceOptionsState>(
      listenWhen: (prev, curr) => prev.confirmStatus != curr.confirmStatus,
      listener: (ctx, state) {
        if (state.confirmStatus == RequestStatus.success) {
          showDialog(
            context: ctx,
            builder: (_) =>
                InsuranceSuccessDialog(requestNumber: state.requestNumber),
          );
        }
      },
      builder: (context, state) {
        final colors = AppThemeColors.of(context);
        return Scaffold(
          backgroundColor: colors.backgroundPrimary,
          appBar: AppAppbar(title: AppStrings.insuranceOptionsTitle),
          body: SafeArea(
            child: LoadingProcess(
              status: state.getDetailsStatus,
              errorMsg: state.errorMsg,
              onTapRefresh: () => context
                  .read<InsuranceOptionsBloc>()
                  .add(InsuranceOptionsLoad(propertyId)),
              emptyMsg: '',
              isEmptyList: false,
              childIsLoader: true,
              child: const InsuranceOptionsContentWidget(),
            ),
          ),
        );
      },
    );
  }
}
