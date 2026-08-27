import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/app_button.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/guest_mode.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../controller/auction_details_bloc.dart';
import 'widgets/auction_details_content_widget.dart';

class AuctionDetailsScreen extends StatelessWidget {
  const AuctionDetailsScreen({super.key, this.auctionId = '1'});
  final String auctionId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionDetailsBloc, AuctionDetailsState>(
      listenWhen: (prev, curr) => prev.bidStatus != curr.bidStatus,
      listener: (ctx, state) {
        if (state.bidStatus == RequestStatus.success) {
          RouterHandler.navigate(
            ctx,
            AppRouterKeys.auctionBidResult,
            extra: auctionId,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppAppbar(title: AppStrings.auctionDetailsTitle),
          body: SafeArea(
            child: LoadingProcess(
              status: state.loadStatus,
              errorMsg: state.errorMsg,
              onTapRefresh: () => context.read<AuctionDetailsBloc>().add(
                AuctionDetailsLoad(auctionId),
              ),
              emptyMsg: '',
              isEmptyList: false,
              childIsLoader: true,
              child: const AuctionDetailsContentWidget(),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveHorizontalPadding,
                vertical: 12,
              ),
              child: BlocBuilder<AuctionDetailsBloc, AuctionDetailsState>(
                builder: (context, state) {
                  final hasDeposit = state.auction?.hasDepositPaid ?? false;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      AppButton(
                        width: 560.width,
                        onTap: () {
                          if (!GuestMode.requireAuth(
                            context,
                            subtitle: AppStrings.guestCompleteProcess,
                          )) {
                            return;
                          }
                          if (hasDeposit) {
                            context.read<AuctionDetailsBloc>().add(
                              const AuctionDetailsPlaceBid(),
                            );
                          } else {
                            RouterHandler.navigate(
                              context,
                              AppRouterKeys.auctionDeposit,
                              extra: auctionId,
                            );
                          }
                        },
                        text: hasDeposit
                            ? AppStrings.placeBidBtn
                            : AppStrings.payDepositBtn,
                        isLoading: state.bidStatus == RequestStatus.loading,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
