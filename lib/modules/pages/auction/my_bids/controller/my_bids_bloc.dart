import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/tabs_model.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../model/my_bid_item_model.dart';

part 'my_bids_event.dart';
part 'my_bids_state.dart';

class MyBidsBloc extends Bloc<MyBidsEvent, MyBidsState> {
  MyBidsBloc() : super(const MyBidsState()) {
    on<MyBidsLoad>(_onLoad);
    on<MyBidsFilterChanged>(_onFilterChanged);
  }

  static MyBidsBloc get(BuildContext context) =>
      BlocProvider.of<MyBidsBloc>(context);

  static final List<MyBidItemModel> _allItems = [
    MyBidItemModel(
      id: '1',
      title: 'شقة فاخرة في الملقا',
      location: 'الرياض - حي الملقا',
      startingBid: 200000,
      imageUrl: AppImages.propertyImage,
      endTime: DateTime.now().add(const Duration(hours: 2)),
      rooms: 3,
      bathrooms: 2,
      area: 150,
      tag: 'شقة',
      status: 'ongoing',
    ),
    MyBidItemModel(
      id: '2',
      title: 'شقة فاخرة في الملقا',
      location: 'الرياض - حي الملقا',
      startingBid: 200000,
      imageUrl: AppImages.propertyImage,
      endTime: DateTime.now().add(const Duration(hours: 5)),
      rooms: 3,
      bathrooms: 2,
      area: 150,
      tag: 'شقة',
      status: 'ongoing',
    ),
    MyBidItemModel(
      id: '3',
      title: 'فلة في حي النرجس',
      location: 'الرياض - حي النرجس',
      startingBid: 500000,
      imageUrl: AppImages.propertyImage,
      endTime: DateTime.now().subtract(const Duration(days: 1)),
      rooms: 4,
      bathrooms: 3,
      area: 300,
      tag: 'فلة',
      status: 'completed',
    ),
    MyBidItemModel(
      id: '4',
      title: 'أرض سكنية في الدرعية',
      location: 'الرياض - الدرعية',
      startingBid: 150000,
      imageUrl: AppImages.propertyImage,
      endTime: DateTime.now().subtract(const Duration(days: 2)),
      rooms: 0,
      bathrooms: 0,
      area: 500,
      tag: 'أرض',
      status: 'cancelled',
    ),
  ];
  static List<TabsModel> tabs = [
    TabsModel(id: 'all', title: AppStrings.allTab),
    TabsModel(id: 'completed', title: AppStrings.completedTab),
    TabsModel(id: 'ongoing', title: AppStrings.ongoingTab),

    TabsModel(id: 'cancelled', title: AppStrings.cancelledTab),
  ];
  Future<void> _onLoad(MyBidsLoad event, Emitter<MyBidsState> emit) async {
    emit(state.copyWith(loadStatus: RequestStatus.loading));
     emit(
      state.copyWith(loadStatus: RequestStatus.success, allItems: _allItems),
    );
  }

  void _onFilterChanged(MyBidsFilterChanged event, Emitter<MyBidsState> emit) {
    if (state.loadStatus == RequestStatus.loading) {
      return;
    }
    emit(state.copyWith(activeFilter: event.filter));
  }
}
