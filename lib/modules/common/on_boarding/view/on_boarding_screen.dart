import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/responsive_row_column.dart';

import '../../../../core/components/image_item.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../controller/on_boarding_bloc.dart';
import 'widgets/on_boarding_card.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    return Scaffold(
      body: BlocBuilder<OnBoardingBloc, OnBoardingState>(
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                ResponsiveRowColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  isTablet: isTablet,
                  children: [
                    Expanded(
                      flex: isTablet ? 1 : 0,

                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(opacity: animation, child: child),
                          child: ImageItem(
                            key: ValueKey(state.currentPage),
                            OnBoardingBloc
                                .onBoardingData[state.currentPage]
                                .image,
                            fit: BoxFit.contain,
                            height: 360.height,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: isTablet ? 1 : 0,
                      child: OnBoardingCard(currentPage: state.currentPage),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
