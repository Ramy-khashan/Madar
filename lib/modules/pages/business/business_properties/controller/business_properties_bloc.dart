 import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_images.dart';
 import '../model/business_property_request_model.dart';

part 'business_properties_event.dart';
part 'business_properties_state.dart';

class BusinessPropertiesBloc
    extends Bloc<BusinessPropertiesEvent, BusinessPropertiesState> {
  BusinessPropertiesBloc() : super(const BusinessPropertiesState()) {
    on<BusinessPropertiesLoad>(_onLoad);
    on<BusinessPropertiesTabChanged>(_onTabChanged);
    on<BusinessPropertiesAccept>(_onAccept);
    on<BusinessPropertiesReject>(_onReject);
  }

  static const _mockRequests = [
    BusinessPropertyRequestModel(
      id: '1',
      title: 'شقة فاخرة في الملقا',
      location: 'الرياض - حي الملقا',
      individualName: 'محمد العتيبي',
      requestDate: '01-02-2026',
      imageUrl: 'assets/images/property.png',
      status: 'بانتظار الرد',
    ),
    BusinessPropertyRequestModel(
      id: '2',
      title: 'شقة فاخرة في الملقا',
      location: 'الرياض - حي الملقا',
      individualName: 'محمد العتيبي',
      requestDate: '01-02-2026',
      imageUrl: 'assets/images/property.png',
      status: 'بانتظار الرد',
    ),
    BusinessPropertyRequestModel(
      id: '3',
      title: 'شقة فاخرة في الملقا',
      location: 'الرياض - حي الملقا',
      individualName: 'محمد العتيبي',
      requestDate: '01-02-2026',
      imageUrl: 'assets/images/property.png',
      status: 'بانتظار الرد',
    ),
  ];

  static const _mockPublished = [
    BusinessRequestPublishedPropertyModel(
      id: '1',
      title: 'شقة فاخرة في الملقا',
      location: 'الرياض - حي الملقا',
      imageUrl: AppImages.propertyImage,
      contractNumber: 3,
      occupancyRate: 2,
      lastUpdate: 'منذ اسبوع',
      status: 'مؤجر',
    ),
    BusinessRequestPublishedPropertyModel(
      id: '2',
      title: 'فيلا حديثة في النرجس',
      location: 'الرياض - حي النرجس',
      imageUrl: AppImages.propertyImage,
      contractNumber: 5,
      occupancyRate: 4,
      lastUpdate: 'منذ اسبوع',
      status: 'مؤجر',
    ),
    BusinessRequestPublishedPropertyModel(
      id: '3',
      title: 'شقة في حي العليا',
      location: 'الرياض - حي العليا',
      imageUrl: AppImages.propertyImage,
      contractNumber: 2,
      occupancyRate: 1,
      lastUpdate: 'منذ شهر',
      status: 'مؤجر',
    ),
  ];

  void _onLoad(
    BusinessPropertiesLoad event,
    Emitter<BusinessPropertiesState> emit,
  ) {
    emit(state.copyWith(requests: _mockRequests, published: _mockPublished));
  }

  void _onTabChanged(
    BusinessPropertiesTabChanged event,
    Emitter<BusinessPropertiesState> emit,
  ) {
    emit(state.copyWith(currentTab: event.index));
  }

  void _onAccept(
    BusinessPropertiesAccept event,
    Emitter<BusinessPropertiesState> emit,
  ) {
    final updated = state.requests.where((r) => r.id != event.id).toList();
    emit(state.copyWith(requests: updated));
  }

  void _onReject(
    BusinessPropertiesReject event,
    Emitter<BusinessPropertiesState> emit,
  ) {
    final updated = state.requests.where((r) => r.id != event.id).toList();
    emit(state.copyWith(requests: updated));
  }
}
