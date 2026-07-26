import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/property_filter_model.dart';
import '../../../../core/repository/apis/wishList_apis.dart';
import '../../../../core/utils/constants/app_enums.dart';

part 'my_wishlist_event.dart';
part 'my_wishlist_state.dart';

class MyWishlistBloc extends Bloc<MyWishlistEvent, MyWishlistState> {
  MyWishlistBloc() : super(const MyWishlistState()) {
    on<MyWishlistLoad>(_onLoad);
    // on<PropertiesFilterApplied>(_onFilterApplied);
  }
  static MyWishlistBloc get(BuildContext context) =>
      BlocProvider.of<MyWishlistBloc>(context);
  Future<void> _onLoad(
    MyWishlistLoad event,
    Emitter<MyWishlistState> emit,
  ) async {
    emit(state.copyWith(propertiesStatus: RequestStatus.loading));
    final response = await WishlistApis.getWishlist();
    response.fold(
      (failedResponse) {
        emit(
          state.copyWith(
            propertiesStatus: RequestStatus.failed,
            errorMsg: failedResponse,
          ),
        );
      },
      (successResponse) {
        emit(
          state.copyWith(
            propertiesStatus: RequestStatus.success,
            savedProperties: successResponse['data'],
          ),
        );
      },
    );
  }
}
