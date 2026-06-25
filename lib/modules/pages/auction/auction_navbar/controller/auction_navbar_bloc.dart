import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../common/settings/controller/settings_bloc.dart';
import '../../../../common/settings/view/settings_screen.dart';
import '../../add_auction_property/controller/add_auction_property_bloc.dart';
import '../../add_auction_property/view/add_auction_property_screen.dart';
import '../../auction_list/controller/auction_list_bloc.dart';
import '../../auction_list/view/auction_list_screen.dart';
import '../../my_bids/controller/my_bids_bloc.dart';
import '../../my_bids/view/my_bids_screen.dart';
import '../../my_listings/controller/my_listings_bloc.dart';
import '../../my_listings/view/my_listings_screen.dart';
import '../model/auction_navbar_model.dart';

part 'auction_navbar_event.dart';
part 'auction_navbar_state.dart';

class AuctionNavbarBloc extends Bloc<AuctionNavbarEvent, AuctionNavbarState> {
  AuctionNavbarBloc() : super(const AuctionNavbarState()) {
    on<AuctionNavbarEvent>((event, emit) {
      if (event is ChangePageEvent) {
        _onChangePage(event, emit);
      }
    });
  }
  void _onChangePage(ChangePageEvent event, Emitter<AuctionNavbarState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  static AuctionNavbarBloc get(BuildContext context) =>
      BlocProvider.of<AuctionNavbarBloc>(context);
  List<AuctionNavbarModel> get navbarItems => [
    AuctionNavbarModel(
      title: AppStrings.home,
      iconPath: AppImages.auctionHomeIcon,
      page: BlocProvider(
        create: (_) => AuctionListBloc()..add(const AuctionListLoad()),
        child: const AuctionListScreen(),
      ),
    ),
    AuctionNavbarModel(
      title: AppStrings.myBids,
      iconPath: AppImages.auctionIcon,
      page: BlocProvider(
        create: (_) => MyBidsBloc()..add(const MyBidsLoad()),
        child:const MyBidsScreen()),
    ),
    AuctionNavbarModel(
      title: AppStrings.add,
      iconPath: '',
      page:BlocProvider(
      create: (_) => AddAuctionPropertyBloc(),
      child: const AddAuctionPropertyScreen()),
    ),
    AuctionNavbarModel(
      title: AppStrings.myExhibits,
      iconPath: AppImages.myAuctionIcon,
      page:BlocProvider(
        create: (_) => MyListingsBloc()..add(const MyListingsLoad()),
        child:const MyListingsScreen()),
    ),
    AuctionNavbarModel(
      title: AppStrings.settings,
      iconPath: AppImages.auctionSettingIcon,
      page: BlocProvider(
        create: (context) => SettingsBloc()..add(const SettingsLoad()),
        child: const SettingsScreen(),
      ),
    ),
  ];
}
