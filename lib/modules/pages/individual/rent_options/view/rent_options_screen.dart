import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/rent_options_bloc.dart';
import 'widgets/rent_options_content_widget.dart';
import 'widgets/rent_success_dialog_widget.dart';

class RentOptionsScreen extends StatelessWidget {
  const RentOptionsScreen({super.key, this.propertyId = '1'});

  final String propertyId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RentOptionsBloc, RentOptionsState>(
      listenWhen: (prev, curr) => prev.confirmStatus != curr.confirmStatus,
      listener: (ctx, state) {
        if (state.confirmStatus == RequestStatus.success) {
          showDialog(
            context: ctx,
            builder: (_) =>
                RentSuccessDialog(requestNumber: state.requestNumber),
          );
        }
      },
      builder: (context, state) {
        final colors = AppThemeColors.of(context);
        return Scaffold(
          backgroundColor: colors.backgroundPrimary,
          appBar: AppAppbar(title: AppStrings.installmentOptionsTitle),
          body: SafeArea(
            child: LoadingProcess(
              status: state.getDetailsStatus,
              errorMsg: state.errorMsg,
              onTapRefresh: () => context.read<RentOptionsBloc>().add(
                RentOptionsLoad(propertyId),
              ),
              emptyMsg: '',
              isEmptyList: false,
              childIsLoader: true,
              child: const RentOptionsContentWidget(),
            ),
          ),
        );
      },
    );
  }
}
