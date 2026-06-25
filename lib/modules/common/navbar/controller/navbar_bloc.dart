import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/functions/preference_utils.dart';
import '../../../../core/utils/constants/app_images.dart';

import '../../../../core/utils/constants/storage_keys.dart';
import '../../../../core/utils/functions/service_locator.dart';
import '../../../pages/business/business_home/controller/business_home_bloc.dart';
import '../../../pages/business/business_home/view/business_home_screen.dart';
import '../../../pages/individual/individual_home/controller/individual_home_bloc.dart';
import '../../../pages/individual/individual_home/view/individual_home_screen.dart';
import '../../chats/conversations/controller/conversations_bloc.dart';
import '../../chats/conversations/view/conversations_screen.dart';
import '../../contracts/controller/contracts_bloc.dart';
import '../../contracts/view/contracts_screen.dart';
import '../../settings/controller/settings_bloc.dart';
import '../../settings/view/settings_screen.dart';
import '../model/navbar_model.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(const NavbarState()) {
    on<NavBarInitList>((event, emit) {
      String userType = sl.get<PreferenceUtils>().getString(
        StorageKeys.accountType,
      ); // This should be fetched from user preferences or authentication state
      List<NavbarModel> items = userType == AppConstant.individual
          ? NavbarBloc.navbarIndividualItems
          : NavbarBloc.navbarBusinessItems;
      emit(state.copyWith(navbarItems: items));
    });
    on<NavbarItemSelected>(_onChangePage);
  }
  static NavbarBloc get(BuildContext context) =>
      BlocProvider.of<NavbarBloc>(context);
  Future<void> _onChangePage(
    NavbarItemSelected event,
    Emitter<NavbarState> emit,
  ) async {
    emit(state.copyWith(selectedItem: event.selectedItem));
  }

  static List<NavbarModel> navbarIndividualItems = [
    NavbarModel(
      title: 'home',
      icon: AppImages.homeIcon,
      screen: BlocProvider(
        create: (context) =>
            IndividualHomeBloc()..add(const IndividualHomeLoad()),
        child: const IndividualHomeView(),
      ),
    ),
    NavbarModel(
      title: 'chat',
      icon: AppImages.chatIcon,
      screen: BlocProvider(
        create: (context) =>
            ConversationsBloc()..add(const ConversationsLoad()),
        child: const ConversationsScreen(),
      ),
    ),
    NavbarModel(title: '', icon: "", screen: Scaffold()),
    NavbarModel(
      title: 'documents',
      icon: AppImages.documentsIcon,
      screen: BlocProvider(
        create: (_) => ContractsBloc()..add(const ContractsLoad()),
        child: const ContractsScreen(),
      ),
    ),
    NavbarModel(
      title: 'account',
      icon: AppImages.accountIcon,
      screen: BlocProvider(
        create: (_) => SettingsBloc()..add(const SettingsLoad()),
        child: const SettingsScreen(),
      ),
    ),
  ];
  static List<NavbarModel> navbarBusinessItems = [
    NavbarModel(
      title: 'home',
      icon: AppImages.homeIcon,
      screen: BlocProvider(
        create: (context) =>
            BusinessHomeBloc()..add(const BusinessHomeItemsEvent()),
        child: const BusinessHomeScreen(),
      ),
    ),
    NavbarModel(
      title: 'chat',
      icon: AppImages.chatIcon,
      screen: BlocProvider(
        create: (context) =>
            ConversationsBloc()..add(const ConversationsLoad()),
        child: const ConversationsScreen(),
      ),
    ),
    NavbarModel(title: '', icon: "", screen: Scaffold()),

    NavbarModel(
      title: 'documents',
      icon: AppImages.documentsIcon,
      screen: BlocProvider(
        create: (_) => ContractsBloc()..add(const ContractsLoad()),
        child: const ContractsScreen(),
      ),
    ),
    NavbarModel(
      title: 'settings',
      icon: AppImages.settingsIcon,
      screen: BlocProvider(
        create: (_) => SettingsBloc()..add(const SettingsLoad()),
        child: const SettingsScreen(),
      ),
    ),
  ];
}
