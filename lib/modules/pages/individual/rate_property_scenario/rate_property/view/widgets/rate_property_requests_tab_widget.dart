import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/components/loading_process.dart';
import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../controller/rate_property_bloc.dart';
import 'rate_property_request_card_widget.dart';

class RatePropertyRequestsTabWidget extends StatelessWidget {
  const RatePropertyRequestsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatePropertyBloc, RatePropertyState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            RatePropertyBloc.get(context).add(const RatePropertyLoad());
          },
          child: LoadingProcess(
            status: state.loadStatus,
            errorMsg: '',
            onTapRefresh: () {
              RatePropertyBloc.get(context).add(const RatePropertyLoad());
            },
            childIsLoader: true,
            emptyMsg: AppStrings.ratePropertyNoRequests,
            isEmptyList: state.requests.isEmpty,
            child:  GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                      vertical: 8.height,
                    ),
                    itemCount: state.requests.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 1,
                        mobileLandscape: 2,
                        tabletPortrait: 2,
                        tabletLandscape: 3,
                      ).toInt(),
                      crossAxisSpacing: 8.width,
                      mainAxisSpacing: 8.height,
                      mainAxisExtent: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 290.height,
                        mobileLandscape: 270.height,
                        tabletPortrait: 200.height,
                        tabletLandscape: 275.height,
                      ),
                    ),
              itemBuilder: (ctx, i) => RatePropertyRequestCard(
                request: state.loadStatus == RequestStatus.loading
                    ? null
                    : state.requests[i],
              ),
            ),
          ),
        );
      },
    );
  }
}
