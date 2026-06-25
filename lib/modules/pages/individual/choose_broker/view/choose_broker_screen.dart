import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/choose_broker_bloc.dart';
import 'widgets/broker_details_content_widget.dart';
import 'widgets/broker_list_content_widget.dart';

class ChooseBrokerScreen extends StatelessWidget {
  const ChooseBrokerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChooseBrokerBloc, ChooseBrokerState>(
      listenWhen: (prev, curr) => prev.confirmStatus != curr.confirmStatus,
      listener: (ctx, state) {
        if (state.confirmStatus == RequestStatus.success) {
          Navigator.of(ctx).popUntil((route) => route.isFirst);
        }
      },
      builder: (context, state) {
        final colors = AppThemeColors.of(context);
        return PopScope(
          canPop: state.step != ChooseBrokerStep.details,
          onPopInvokedWithResult: (didPop, result) {
            if (state.step == ChooseBrokerStep.details) {
              context.read<ChooseBrokerBloc>().add(const ChooseBrokerBack());
            }
          },
          child: Scaffold(
            backgroundColor: colors.backgroundPrimary,
            appBar: AppAppbar(
              title: AppStrings.chooseBrokerTitle,
              onTapBack: () {
                if (state.step == ChooseBrokerStep.details) {
                  context.read<ChooseBrokerBloc>().add(
                    const ChooseBrokerBack(),
                  );
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
            body: SafeArea(
              child: state.step == ChooseBrokerStep.list
                  ? const BrokerListContentWidget()
                  : const BrokerDetailsContentWidget(),
            ),
          ),
        );
      },
    );
  }
}
