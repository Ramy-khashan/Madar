import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/components/loading_process.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/individual_home_bloc.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndividualHomeBloc, IndividualHomeState>(
      builder: (context, state) {
        return LoadingProcess(
          status: state.adsStatus,
          emptyMsg: '',
          isEmptyList: state.adsItem.isEmpty,
          onTapRefresh: () {
            context.read<IndividualHomeBloc>().add(const IndividualHomeLoadAds());
          },
          childIsLoader: true,
          errorMsg: state.adsErrorMsg,
          child: state.adsStatus == RequestStatus.failed
              ? const SizedBox()
              : state.adsStatus == RequestStatus.success &&
                    state.adsItem.isEmpty
              ? const SizedBox()
              : Container(
                  height: 163.height,
                  margin: EdgeInsets.symmetric(
                    horizontal: context.responsiveHorizontalPadding,
                  ),
                  child: PageView.builder(
                    itemCount: state.adsStatus == RequestStatus.loading
                        ? 10
                        : state.adsItem.length,
                    itemBuilder: (context, index) {
                      final item = state.adsStatus == RequestStatus.loading
                          ? null
                          : state.adsItem[index];
                      return InkWell(
                        onTap: () async {
                          if (item?.targetUrl != null) {
                             await urlLauncher(item!.targetUrl!);
                          }
                        },
                        child: Container(
                          margin: EdgeInsetsDirectional.symmetric(
                            horizontal: 3.width,
                          ),
                          height: 163.height,
                          width: double.infinity,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.radius),
                          ),

                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ImageItem(
                                item?.mediaUrl ?? '',
                                fit: BoxFit.cover,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(
                                        0xff0A1E3C,
                                      ).withValues(alpha: 0.8),
                                      const Color(
                                        0xff0A1D38,
                                      ).withValues(alpha: 0.2),
                                    ],
                                    end: AlignmentDirectional.centerEnd,
                                    begin: AlignmentDirectional.centerStart,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(16.width),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item?.title ?? '',
                                      style: TextStyle(
                                        fontSize: context.responsiveFontScale(
                                          16,
                                        ),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: AppConstant.appHeaderFont,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 6.height),
                                    Text(
                                      item?.description ?? '',
                                      style: TextStyle(
                                        fontSize: context.responsiveFontScale(
                                          11,
                                        ),
                                        fontFamily: AppConstant.appHeaderFont,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withValues(
                                          alpha: 0.9,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
