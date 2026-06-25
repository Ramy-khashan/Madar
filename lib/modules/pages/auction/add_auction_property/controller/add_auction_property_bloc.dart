import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../model/add_auction_property_form_model.dart';
import '../model/property_details.dart';

part 'add_auction_property_event.dart';
part 'add_auction_property_state.dart';

class AddAuctionPropertyBloc
    extends Bloc<AddAuctionPropertyEvent, AddAuctionPropertyState> {
  AddAuctionPropertyBloc() : super(const AddAuctionPropertyState()) {
    on<AddAuctionPropertyTypeSelected>(_onTypeSelected);
    on<AddAuctionPropertyFieldChanged>(_onFieldChanged);
    on<AddAuctionPropertyCounterChanged>(_onCounterChanged);
    on<AddAuctionPropertySubmit>(_onSubmit);
  }

  static AddAuctionPropertyBloc get(BuildContext context) =>
      BlocProvider.of<AddAuctionPropertyBloc>(context);

  void _onTypeSelected(
    AddAuctionPropertyTypeSelected event,
    Emitter<AddAuctionPropertyState> emit,
  ) {
    emit(
      state.copyWith(form: state.form.copyWith(propertyTypeId: event.typeId)),
    );
  }

  void _onFieldChanged(
    AddAuctionPropertyFieldChanged event,
    Emitter<AddAuctionPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          location: event.location ?? state.form.location,
          startingPrice: event.startingPrice ?? state.form.startingPrice,
          startDate: event.startDate ?? state.form.startDate,
          startTime: event.startTime ?? state.form.startTime,
          endDate: event.endDate ?? state.form.endDate,
          endTime: event.endTime ?? state.form.endTime,
          description: event.description ?? state.form.description,
        ),
      ),
    );
  }

  void _onCounterChanged(
    AddAuctionPropertyCounterChanged event,
    Emitter<AddAuctionPropertyState> emit,
  ) {
    final f = state.form;
    emit(
      state.copyWith(
        form: f.copyWith(
          rooms: event.rooms ?? f.rooms,
          bathrooms: event.bathrooms ?? f.bathrooms,
          area: event.area ?? f.area,
          balcony: event.balcony ?? f.balcony,
          floor: event.floor ?? f.floor,
          propertyNumber: event.propertyNumber ?? f.propertyNumber,
        ),
      ),
    );
  }

  List<CounterItemModel> get counterItems => [
    CounterItemModel(
      label: AppStrings.roomsLabel,
      icon: AppImages.bedroomIcon,
      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.bathroomsLabel,
      icon: AppImages.bathroomIcon,

      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.areaLabel,

      icon: AppImages.totalSpaceIcon,
      suffix: AppStrings.mesurement,
      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.balconyLabel,
      icon: AppImages.balconyIcon,
      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.floorLabel,
      icon: AppImages.floorIcon,
      controller: TextEditingController(),
    ),
    CounterItemModel(
      label: AppStrings.propertyNumberLabel,
      icon: AppImages.propertyNumberIcon,
      controller: TextEditingController(),
    ),
  ];

  Future<void> _onSubmit(
    AddAuctionPropertySubmit event,
    Emitter<AddAuctionPropertyState> emit,
  ) async {
    emit(state.copyWith(submitStatus: RequestStatus.loading));
    emit(state.copyWith(submitStatus: RequestStatus.success));
  }
}
