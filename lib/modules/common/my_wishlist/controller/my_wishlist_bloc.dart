import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/property_filter_model.dart';
import '../../../../core/repository/apis/wish_list_apis.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/functions/guest_mode.dart';
import '../../../pages/individual/individual_home/model/properties_item_model.dart';

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
    if (event.isReset) {
      emit(state.copyWith(savedProperties: []));
    }
    if (GuestMode.isGuest) {
      emit(
        state.copyWith(
          propertiesStatus: RequestStatus.success,
          savedProperties: [],
        ),
      );
      return;
    }
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
        final List<PropertiesItemModel> properties = [...state.savedProperties];
        for (var element in successResponse) {
          properties.add(PropertiesItemModel.fromJson(element));
        }
        emit(
          state.copyWith(
            propertiesStatus: RequestStatus.success,
            savedProperties: properties,
          ),
        );
      },
    );
  }
}
