import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../auction_list/model/auction_item_model.dart';
import '../model/auction_details_model.dart';

part 'auction_details_event.dart';
part 'auction_details_state.dart';

class AuctionDetailsBloc
    extends Bloc<AuctionDetailsEvent, AuctionDetailsState> {
  AuctionDetailsBloc() : super(const AuctionDetailsState()) {
    on<AuctionDetailsLoad>(_onLoad);
    on<AuctionDetailsPlaceBid>(_onPlaceBid);
  }

  static AuctionDetailsBloc get(BuildContext context) =>
      BlocProvider.of<AuctionDetailsBloc>(context);

  Future<void> _onLoad(
    AuctionDetailsLoad event,
    Emitter<AuctionDetailsState> emit,
  ) async {
    emit(state.copyWith(loadStatus: RequestStatus.loading));
     emit(state.copyWith(
      loadStatus: RequestStatus.success,
      auction: AuctionDetailsModel(
        id: event.auctionId,
        title: 'شقة فاخرة في الملقا',
        location: 'الرياض - حي الملقا',
        currentBid: 90000,
        minBidIncrement: 1000,
        imageUrls: [AppImages.propertyImage, AppImages.propertyImage],
        startTime: DateTime.now().subtract(const Duration(hours: 3)),
        endTime: DateTime.now().add(const Duration(days: 2, hours: 2, minutes: 2, seconds: 2)),
        bidsCount: 12,
        propertyType: 'شقة سكنية',
        beds: 3,
        baths: 2,
        area: '150 ${AppStrings.mesurement}',
        floor: 3,
        balconies: 2,
        propertyNumber: '301',
        description:
            'شقة فاخرة بمساحة واسعة مع إطلالة رائعة على المدينة، تشطيب فاخر وموقع مميز',
        status: AuctionStatus.live,
        hasDepositPaid: false,
        startingBid: 80000,
        tag: 'شقة',
        sellerName: 'أحمد محمد',
        sellerRating: 4.8,
        sellerReviewCount: 24,
        depositAmount: 30000,
      ),
    ));
  }

  Future<void> _onPlaceBid(
    AuctionDetailsPlaceBid event,
    Emitter<AuctionDetailsState> emit,
  ) async {
    emit(state.copyWith(bidStatus: RequestStatus.loading));
     if (state.auction == null) return;
    emit(state.copyWith(
      bidStatus: RequestStatus.success,
      auction: state.auction!.copyWith(
        currentBid: state.auction!.currentBid + state.auction!.minBidIncrement,
        bidsCount: state.auction!.bidsCount + 1,
      ),
    ));
  }
}
