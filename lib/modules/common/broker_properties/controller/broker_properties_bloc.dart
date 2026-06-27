import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/property_filter_model.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
 import '../../../../../core/model/property_listing_user_model.dart';
import '../../../pages/individual/individual_home/model/property_model.dart';

part 'broker_properties_event.dart';
part 'broker_properties_state.dart';

class BrokerPropertiesBloc
    extends Bloc<BrokerPropertiesEvent, BrokerPropertiesState> {
  BrokerPropertiesBloc() : super(BrokerPropertiesInitial()) {
    on<BrokerPropertiesLoad>(_onLoad);
    on<BrokerPropertiesFilterApplied>(_onFilterApplied);
  }

  static const PropertyListingUserModel _mockBroker = PropertyListingUserModel(
    name: 'مكتب العقارات المتميزة',
    rating: 4.9,
    reviewsCount: 127,
    propertiesCount: 45,
  );

  static final List<PropertyModel> _mockProperties = [
    PropertyModel(
      id: '1',
      title: 'شقة فاخرة في الملقا',
      location: 'الرياض - حي الملقا',
      imageUrl: AppImages.propertyImage,
      beds: 3,
      baths: 2,
      area: '150 ${AppStrings.mesurement}',
      price: 850000,
      tag: 'شقة',
      typeId: 'apartment',
      isForSale: true,
    ),
      PropertyModel(
      id: '2',
      title: 'فيلا النرجس',
      location: 'الرياض - حي النرجس',
      imageUrl: AppImages.propertyImage,
      beds: 5,
      baths: 4,
      area: '350 ${AppStrings.mesurement}',
      price: 2200000,
      tag: 'فيلا',
      typeId: 'villa',
      isForSale: true,
    ),
      PropertyModel(
      id: '3',
      title: 'شقة في حي العليا',
      location: 'الرياض - حي العليا',
      imageUrl: AppImages.propertyImage,
      beds: 2,
      baths: 1,
      area: '110 ${AppStrings.mesurement}',
      price: 620000,
      tag: 'شقة',
      typeId: 'apartment',
      isForSale: false,
    ),
      PropertyModel(
      id: '4',
      title: 'دور في حي الورود',
      location: 'الرياض - حي الورود',
      imageUrl: AppImages.propertyImage,
      beds: 4,
      baths: 3,
      area: '200 ${AppStrings.mesurement}',
      price: 1100000,
      tag: 'دور',
      typeId: 'floor',
      isForSale: true,
    ),
  ];

  void _onLoad(
    BrokerPropertiesLoad event,
    Emitter<BrokerPropertiesState> emit,
  ) {
    emit(
      BrokerPropertiesLoaded(
        broker: _mockBroker,
        properties: _mockProperties,
      ),
    );
  }

  void _onFilterApplied(
    BrokerPropertiesFilterApplied event,
    Emitter<BrokerPropertiesState> emit,
  ) {
    final f = event.filter;
    final filtered = _mockProperties.where((p) {
      if (p.isForSale != f.isForSale) return false;
      if (f.propertyTypeId != null && p.typeId != f.propertyTypeId) return false;
      if (p.price > f.maxPrice) return false;
      return true;
    }).toList();
    emit(BrokerPropertiesLoaded(
      broker: _mockBroker,
      properties: filtered,
      filter: f,
    ));
  }
}
