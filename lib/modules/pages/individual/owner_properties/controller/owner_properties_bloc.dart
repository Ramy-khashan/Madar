import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/property_filter_model.dart';
import '../../../../../core/model/property_listing_user_model.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../pages/individual/individual_home/model/property_model.dart';
 
part 'owner_properties_event.dart';
part 'owner_properties_state.dart';

class OwnerPropertiesBloc
    extends Bloc<OwnerPropertiesEvent, OwnerPropertiesState> {
  OwnerPropertiesBloc() : super(OwnerPropertiesInitial()) {
    on<OwnerPropertiesLoad>(_onLoad);
    on<OwnerPropertiesFilterApplied>(_onFilterApplied);
  }

  static const PropertyListingUserModel _mockOwner = PropertyListingUserModel(
    name: 'محمد عبدالله',
 
    propertiesCount: 45,
  ); 
  void _onLoad(OwnerPropertiesLoad event, Emitter<OwnerPropertiesState> emit) {
    emit(OwnerPropertiesLoaded(owner: _mockOwner, properties: []));
  }

  void _onFilterApplied(
    OwnerPropertiesFilterApplied event,
    Emitter<OwnerPropertiesState> emit,
  ) {
    final f = event.filter;
    // final filtered = _mockProperties.where((p) {
    //   if (p.isForSale != f.isForSale) return false;
    //   if (f.propertyTypeId != null && p.typeId != f.propertyTypeId)
    //     return false;
    //   if (p.price > f.maxPrice) return false;
    //   return true;
    // }).toList();
    emit(OwnerPropertiesLoaded(owner: _mockOwner, properties: [], filter: f));
  }
}
