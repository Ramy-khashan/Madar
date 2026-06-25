import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/tabs_model.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../model/my_listing_item_model.dart';

part 'my_listings_event.dart';
part 'my_listings_state.dart';

class MyListingsBloc extends Bloc<MyListingsEvent, MyListingsState> {
  MyListingsBloc() : super(const MyListingsState()) {
    on<MyListingsLoad>(_onLoad);
    on<MyListingsFilterChanged>(_onFilterChanged);
  }

  static MyListingsBloc get(BuildContext context) =>
      BlocProvider.of<MyListingsBloc>(context);

  static final List<MyListingItemModel> _allItems = [
    MyListingItemModel(
      id: '1',
      title: 'شقة فاخرة في الملقا',
      location: 'الرياض - حي الملقا',
      imageUrl: AppImages.propertyImage,
      rooms: 3,
      bathrooms: 2,
      area: 150,
      tag: 'شقة',
      status: 'active',
      startingBid: 200000,
      endTime: DateTime.now().add(const Duration(hours: 2, minutes: 10)),
    ),
    const MyListingItemModel(
      id: '2',
      title: 'شقة فاخرة في الملقا',
      location: 'الرياض - حي الملقا',
      imageUrl: AppImages.propertyImage,
      rooms: 3,
      bathrooms: 2,
      area: 150,
      tag: 'شقة',
      status: 'completed',
      finalPrice: 3500,
      winnerName: 'Ahmed M.',
      deliveryStatus: 'Shipped',
      receiptFileName: 'receipt-001.pdf',
    ),
    MyListingItemModel(
      id: '3',
      title: 'شقة فاخرة في الملقا',
      location: 'الرياض - حي الملقا',
      imageUrl: AppImages.propertyImage,
      rooms: 3,
      bathrooms: 2,
      area: 150,
      tag: 'شقة',
      status: 'cancelled',

      cancellationReason: 'Item condition misrepresented',
      cancelledAt: DateTime(2025, 12, 6),
    ),
  ];
  static List<TabsModel> tabs = [
    TabsModel(id: 'all', title: AppStrings.allTab),
    TabsModel(id: 'active', title: AppStrings.activeTab),
    TabsModel(id: 'completed', title: AppStrings.completedTab),
    TabsModel(id: 'cancelled', title: AppStrings.cancelledTab),
  ];
  Future<void> _onLoad(
    MyListingsLoad event,
    Emitter<MyListingsState> emit,
  ) async {
    emit(state.copyWith(loadStatus: RequestStatus.loading));
     emit(
      state.copyWith(loadStatus: RequestStatus.success, allItems: _allItems),
    );
  }

  void _onFilterChanged(
    MyListingsFilterChanged event,
    Emitter<MyListingsState> emit,
  ) {
    emit(state.copyWith(activeFilter: event.filter));
  }
}
