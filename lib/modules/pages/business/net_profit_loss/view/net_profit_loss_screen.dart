import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/net_profit_loss_bloc.dart';
import 'widgets/net_profit_loss_actions_widget.dart';
import 'widgets/net_profit_loss_comparison_widget.dart';
import 'widgets/net_profit_loss_header_widget.dart';
import 'widgets/net_profit_loss_notes_widget.dart';

class NetProfitLossScreen extends StatelessWidget {
  const NetProfitLossScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          NetProfitLossBloc()..add(const NetProfitLossLoad()),
      child: const _NetProfitLossView(),
    );
  }
}

class _NetProfitLossView extends StatelessWidget {
  const _NetProfitLossView();

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppAppbar(title: AppStrings.netProfitLossTitle),
      body: BlocBuilder<NetProfitLossBloc, NetProfitLossState>(
        builder: (context, state) {
          if (state.status == RequestStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NetProfitLossHeaderWidget(state: state),
                  NetProfitLossComparisonWidget(state: state),
                  const NetProfitLossNotesWidget(),
                  const NetProfitLossActionsWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
