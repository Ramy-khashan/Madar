import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_images.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../model/account_model.dart';

part 'choose_account_event.dart';
part 'choose_account_state.dart';

class ChooseAccountBloc extends Bloc<ChooseAccountEvent, ChooseAccountState> {
  ChooseAccountBloc() : super(const ChooseAccountInitial()) {
    on<SelectAccountEvent>((event, emit) {
      if (state is ChooseAccountInitial) {
        emit((state as ChooseAccountInitial).copyWith(selectedIndex: event.index));
      }
    });
  }

  static List<AccountModel> get accounts => [
    AccountModel(
      title: AppStrings.accountTitle1,
      description: AppStrings.accountDescription1,
      image: AppImages.individualIcon,
      accountType: AppConstant.individual,
      badge: AppStrings.accountBadge1,
      features: [
        AppStrings.accountFeature1_1,
        AppStrings.accountFeature1_2,
        AppStrings.accountFeature1_3,
      ],
    ),
    AccountModel(
      title: AppStrings.accountTitle2,
      description: AppStrings.accountDescription2,
      image: AppImages.businessIcon,
      accountType: AppConstant.business,
      badge: AppStrings.accountBadge2,
      features: [
        AppStrings.accountFeature2_1,
        AppStrings.accountFeature2_2,
        AppStrings.accountFeature2_3,
        AppStrings.accountFeature2_4,
      ],
    ),
    AccountModel(
      title: AppStrings.accountTitle3,
      description: AppStrings.accountDescription3,
      image: AppImages.businessIcon,
      accountType: AppConstant.developer,
      badge: AppStrings.accountBadge3,
      features: [
        AppStrings.accountFeature3_1,
        AppStrings.accountFeature3_2,
      ],
    ),
  ];
}

