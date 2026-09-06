import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/app_images.dart';
import '../../../../core/utils/functions/account_role.dart';
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
import 'navbar_refresh.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(const NavbarState()) {
    NavbarRefresh.bind(_boundReload);
    on<NavBarInitList>(_onInitOrReload);
    on<NavbarReload>(_onInitOrReload);
    on<NavbarItemSelected>(_onChangePage);
  }

  late final void Function({bool resetToHome}) _boundReload = _requestReload;

  void _requestReload({bool resetToHome = false}) {
    add(NavbarReload(resetToHome: resetToHome));
  }

  static NavbarBloc get(BuildContext context) =>
      BlocProvider.of<NavbarBloc>(context);

  Future<void> reload({bool resetToHome = false}) {
    final nextId = state.refreshId + 1;
    final done = stream.firstWhere((s) => s.refreshId >= nextId);
    add(NavbarReload(resetToHome: resetToHome));
    return done.timeout(const Duration(seconds: 8), onTimeout: () => state);
  }

  void _onInitOrReload(NavbarEvent event, Emitter<NavbarState> emit) {
    final resetToHome = event is NavbarReload && event.resetToHome;
    final nextRefresh = state.refreshId + 1;
    emit(
      state.copyWith(
        navbarItems: AccountRole.isIndividual
            ? buildIndividualItems(nextRefresh)
            : buildBusinessItems(nextRefresh),
        selectedItem: resetToHome ? 0 : state.selectedItem,
        refreshId: nextRefresh,
      ),
    );
  }

  Future<void> _onChangePage(
    NavbarItemSelected event,
    Emitter<NavbarState> emit,
  ) async {
    emit(state.copyWith(selectedItem: event.selectedItem));
  }

  static List<NavbarModel> buildIndividualItems(int refreshId) => [
    NavbarModel(
      title: 'home',
      icon: AppImages.homeIcon,
      screen: BlocProvider(
        key: ValueKey('individual_home_$refreshId'),
        create: (context) =>
            IndividualHomeBloc()..add(const IndividualHomeLoad()),
        child: const IndividualHomeView(),
      ),
    ),
    NavbarModel(
      title: 'chat',
      icon: AppImages.chatIcon,
      screen: BlocProvider(
        key: ValueKey('individual_chat_$refreshId'),
        create: (context) =>
            ConversationsBloc()..add(const ConversationsLoad()),
        child: const ConversationsScreen(),
      ),
    ),
    NavbarModel(title: '', icon: '', screen: const Scaffold()),
    NavbarModel(
      title: 'documents',
      icon: AppImages.documentsIcon,
      screen: BlocProvider(
        key: ValueKey('individual_docs_$refreshId'),
        create: (_) => ContractsBloc()..add(const ContractsLoad()),
        child: const ContractsScreen(),
      ),
    ),
    NavbarModel(
      title: 'account',
      icon: AppImages.accountIcon,
      screen: BlocProvider(
        key: ValueKey('individual_account_$refreshId'),
        create: (_) => SettingsBloc()..add(const SettingsLoad()),
        child: const SettingsScreen(),
      ),
    ),
  ];
  static List<NavbarModel> buildBusinessItems(int refreshId) => [
    NavbarModel(
      title: 'home',
      icon: AppImages.homeIcon,
      screen: BlocProvider(
        key: ValueKey('business_home_$refreshId'),
        create: (context) =>
            BusinessHomeBloc()..add(const BusinessHomeItemsEvent()),
        child: const BusinessHomeScreen(),
      ),
    ),
    NavbarModel(
      title: 'chat',
      icon: AppImages.chatIcon,
      screen: BlocProvider(
        key: ValueKey('business_chat_$refreshId'),
        create: (context) =>
            ConversationsBloc()..add(const ConversationsLoad()),
        child: const ConversationsScreen(),
      ),
    ),
    NavbarModel(title: '', icon: '', screen: const Scaffold()),
    NavbarModel(
      title: 'documents',
      icon: AppImages.documentsIcon,
      screen: BlocProvider(
        key: ValueKey('business_docs_$refreshId'),
        create: (_) => ContractsBloc()..add(const ContractsLoad()),
        child: const ContractsScreen(),
      ),
    ),
    NavbarModel(
      title: 'account',
      icon: AppImages.accountIcon,
      screen: BlocProvider(
        key: ValueKey('business_account_$refreshId'),
        create: (_) => SettingsBloc()
          ..add(const SettingsLoad())
          ..add(const SettingsGetSavedCount()),
        child: const SettingsScreen(),
      ),
    ),
  ];

  @override
  Future<void> close() {
    NavbarRefresh.unbind(_boundReload);
    return super.close();
  }
}
