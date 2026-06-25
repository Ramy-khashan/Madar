import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router_keys.dart';
import '../../../../core/utils/constants/app_images.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/constants/storage_keys.dart';
import '../../../../core/utils/functions/preference_utils.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../model/on_boarding_model.dart';

part 'on_boarding_event.dart';
part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(const OnBoardingState()) {
    on<OnBoardingChangePage>(_onChangePage);
  }
  static OnBoardingBloc get(BuildContext context) =>
      BlocProvider.of<OnBoardingBloc>(context);
  Future<void> _onChangePage(
    OnBoardingChangePage event,
    Emitter<OnBoardingState> emit,
  ) async {
    if (state.currentPage == onBoardingData.length - 1) {
      await PreferenceUtils()
          .setBool(StorageKeys.onboardingCompleted, true)
          .whenComplete(() {
            if (event.context.mounted) {
              RouterHandler.navigate(
                event.context,
                AppRouterKeys.chooseAccount,
              );
            }
          });

      return;
    }
    emit(state.copyWith(currentPage: state.currentPage + 1));
  }

  static List<OnBoardingModel> onBoardingData = [
    OnBoardingModel(
      title: AppStrings.onBoardingTitle1,
      description: AppStrings.onBoardingDesc1,
      image: AppImages.onBoarding1,
    ),
    OnBoardingModel(
      title: AppStrings.onBoardingTitle2,
      description: AppStrings.onBoardingDesc2,
      image: AppImages.onBoarding2,
    ),
    OnBoardingModel(
      title: AppStrings.onBoardingTitle3,
      description: AppStrings.onBoardingDesc3,
      image: AppImages.onBoarding3,
    ),
  ];
}
