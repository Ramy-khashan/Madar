import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_button.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../controller/on_boarding_bloc.dart';
import 'indicator_item.dart';

class OnBoardingCard extends StatelessWidget {
  const OnBoardingCard({super.key, required this.currentPage});
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.width,
                vertical: 10.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  IndicatorItem(selectedIndex: currentPage),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    transitionBuilder: (child, animation) => SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(0.15, 0),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOut,
                            ),
                          ),
                      child: FadeTransition(opacity: animation, child: child),
                    ),
                    child: Column(
                      key: ValueKey(currentPage),
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 38.height,
                            bottom: 12.height,
                          ),
                          child: Text(
                            OnBoardingBloc.onBoardingData[currentPage].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(18),
                              fontWeight: FontWeight.bold,
                              color: AppThemeColors.of(context).textFieldTitle,
                            ),
                          ),
                        ),
                        Text(
                          OnBoardingBloc
                              .onBoardingData[currentPage]
                              .description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(16),
                            color: AppThemeColors.of(context).textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.height),
              child: Center(
                child: AppButton(
                  width: 560.width,
                  onTap: () {
                    OnBoardingBloc.get(
                      context,
                    ).add(OnBoardingChangePage(context: context));
                  },
                  childText: AppStrings.next,
                ),
              ),
            ),

            // AnimatedSwitcher(
            //   duration: const Duration(milliseconds: 400),
            //   transitionBuilder: (child, animation) => SlideTransition(
            //     position:
            //         Tween<Offset>(
            //           begin: const Offset(0, 0.5),
            //           end: Offset.zero,
            //         ).animate(
            //           CurvedAnimation(parent: animation, curve: Curves.easeOut),
            //         ),
            //     child: FadeTransition(opacity: animation, child: child),
            //   ),
            // child: currentPage == OnBoardingBloc.onBoardingData.length - 1
            //     ? Padding(
            //         key: const ValueKey('guest'),
            //         padding: EdgeInsets.only(top: 15.height),
            //         child: AppTextButton(
            //           color: AppThemeColors.of(context).primaryBrand,
            //           text: AppStrings.guestMode,
            //           onTap: () {
            //             RouterHandler.navigate(
            //               context,
            //               AppRouterKeys.navbar,
            //               routerType: RouterType.goName,
            //             );
            //           },
            //         ),
            //       )
            //     : SizedBox(key: const ValueKey('empty'), height: 8.height),
            // ),
          ],
        ),
      ),
    );
  }
}
