import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/auction_deposit_bloc.dart';
import '../model/auction_deposit_model.dart';
import 'widgets/auction_deposit_payment_step_widget.dart';
import 'widgets/auction_deposit_processing_widget.dart';
import 'widgets/auction_deposit_success_widget.dart';

class AuctionDepositScreen extends StatelessWidget {
  const AuctionDepositScreen({super.key, this.auctionId = '1'});
  final String auctionId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionDepositBloc, AuctionDepositState>(
      builder: (context, state) {
        final colors = AppThemeColors.of(context);
        return Scaffold(
          backgroundColor: colors.backgroundPrimary,
          appBar: state.step == AuctionDepositStep.processing
              ? null
              : AppAppbar(
                  title: switch (state.step) {
                    AuctionDepositStep.paymentSelection =>
                      AppStrings.depositPaymentTitle,
                    AuctionDepositStep.processing => '',
                    AuctionDepositStep.success =>
                      AppStrings.depositSuccessTitle,
                  },
                ),
          body: SafeArea(
            child: LoadingProcess(
              status: state.loadStatus,
              errorMsg: state.errorMsg,
              onTapRefresh: () => context
                  .read<AuctionDepositBloc>()
                  .add(AuctionDepositLoad(auctionId)),
              emptyMsg: '',
              isEmptyList: false,
              childIsLoader: true,
              child: switch (state.step) {
                AuctionDepositStep.paymentSelection =>
                  const AuctionDepositPaymentStepWidget(),
                AuctionDepositStep.processing =>
                  const AuctionDepositProcessingWidget(),
                AuctionDepositStep.success =>
                  const AuctionDepositSuccessWidget(),
              },
            ),
          ),
        );
      },
    );
  }
}
