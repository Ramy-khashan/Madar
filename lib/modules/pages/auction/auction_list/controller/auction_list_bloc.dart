import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../model/auction_item_model.dart';

part 'auction_list_event.dart';
part 'auction_list_state.dart';

class AuctionListBloc extends Bloc<AuctionListEvent, AuctionListState> {
  AuctionListBloc() : super(const AuctionListState()) {
    on<AuctionListLoad>(_onLoad);
    on<AuctionListFilterChanged>(_onFilterChanged);
  }

  static AuctionListBloc get(BuildContext context) =>
      BlocProvider.of<AuctionListBloc>(context);

  static final List<AuctionItemModel> _allItems = [
    AuctionItemModel(
      id: '1',
      title: 'شقة فاخرة في الملقا',
      location: 'الرياض - حي الملقا',
      currentBid: 850000,
      startingBid: 700000,
      imageUrl: AppImages.propertyImage,
      endTime: DateTime.now().add(const Duration(hours: 2)),
      bidsCount: 12,
      tag: 'شقة',
      status: AuctionStatus.live,
    ),
    AuctionItemModel(
      id: '2',
      title: 'فيلا في حي النرجس',
      location: 'الرياض - حي النرجس',
      currentBid: 2400000,
      startingBid: 2000000,
      imageUrl: AppImages.propertyImage,
      endTime: DateTime.now().add(const Duration(hours: 5)),
      bidsCount: 8,
      tag: 'فيلا',
      status: AuctionStatus.live,
    ),
    AuctionItemModel(
      id: '3',
      title: 'أرض سكنية في الدرعية',
      location: 'الرياض - الدرعية',
      currentBid: 500000,
      startingBid: 450000,
      imageUrl: AppImages.propertyImage,
      endTime: DateTime.now().add(const Duration(days: 1)),
      bidsCount: 5,
      tag: 'أرض',
      status: AuctionStatus.upcoming,
    ),
    AuctionItemModel(
      id: '4',
      title: 'شقة في حي العقيق',
      location: 'الرياض - حي العقيق',
      currentBid: 650000,
      startingBid: 600000,
      imageUrl: AppImages.propertyImage,
      endTime: DateTime.now().subtract(const Duration(hours: 1)),
      bidsCount: 20,
      tag: 'شقة',
      status: AuctionStatus.ended,
    ),
  ];

  Future<void> _onLoad(
    AuctionListLoad event,
    Emitter<AuctionListState> emit,
  ) async {
    emit(state.copyWith(loadStatus: RequestStatus.loading));
     emit(state.copyWith(
      loadStatus: RequestStatus.success,
      allItems: _allItems,
    ));
  }

  void _onFilterChanged(
    AuctionListFilterChanged event,
    Emitter<AuctionListState> emit,
  ) {
    emit(state.copyWith(activeFilter: event.filter));
  }
}
