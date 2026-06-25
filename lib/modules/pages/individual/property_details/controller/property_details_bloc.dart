import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../model/property_details_buyer_model.dart';

part 'property_details_event.dart';
part 'property_details_state.dart';

class PropertyDetailsBloc
    extends Bloc<PropertyDetailsEvent, PropertyDetailsState> {
  PropertyDetailsBloc() : super(const PropertyDetailsState()) {
    on<PropertyDetailsLoad>(_onLoad);
    on<PropertyDetailsToggleBookmark>(_onToggleBookmark);
    on<PropertyDetailsSubmitRequest>(_onSubmitRequest);
  }

  static PropertyDetailsBloc get(BuildContext context) =>
      BlocProvider.of<PropertyDetailsBloc>(context);

  Future<void> _onLoad(
    PropertyDetailsLoad event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    emit(state.copyWith(getDetailsStatus: RequestStatus.loading));
     emit(
      state.copyWith(
        getDetailsStatus: RequestStatus.success,
        property: PropertyBuyerModel(
          id: event.propertyId,
          title: 'شقة فاخرة في الملقا',
          location: 'الرياض - حي الملقا',
          occupancyRate: '85%',
          price: 850000,
          imageUrls: [
            AppImages.propertyImage,
            AppImages.propertyImage,
          ],
          beds: 3,
          balconies: 3,
          baths: 3,
          area: '150 ${AppStrings.mesurement}',
          floor: 3,
          propertyNumber: '3',
          paymentMethod: 'كاش او تقسيط',
          tag: 'فلل',
          isBookmarked: false,
          description:
 'فيلا عصرية بتصميم معاصر في أرقى أحياء شمال الرياض. تتميز بإطلالة مفتوحة، تشطيبات فاخرة، مسبح خاص، ومدخلين مستقلين. قريبة من المدارس العالمية ومول النخيل  ومدخلين مستقلين. قريبة من المدارس العالمية ومول النخيل.',          propertyType: 'شقة سكنية',
          advertiser: const AdvertiserModel(
            name: 'محمد عبدالله',
            role: 'مالك العقار',
            badgeLabel: 'مالك فولو',
            isVerified: true,
            falLicenseNumber: '1234567890',
            adLicenseNumber: '1234567890',
            totalProperties: 39,
          ),
          rentInfo: const RentInstallmentInfoModel(
            isEligible: true,
            annualRentValue: 400,
            minMonthlyInstallment: 400,
            providersCount: 3,
          ),
          insuranceInfo: const InsuranceInfoModel(
            isInsured: false,
            availableTypes: ['شامل', 'أساسي'],
            companiesCount: 3,
          ),
          latLng: const LatLng(24.7749, 46.7381),
          nearbyPlaces: const [
            NearbyPlaceModel(name: 'مدرسة المنارات الاهلية', distance: '0.8 كم'),
            NearbyPlaceModel(name: 'مول النخيل', distance: '0.8 كم'),
            NearbyPlaceModel(name: 'مستشفى الملك فيصل', distance: '0.8 كم'),
          ],
        ),
      ),
    );
  }

  void _onToggleBookmark(
    PropertyDetailsToggleBookmark event,
    Emitter<PropertyDetailsState> emit,
  ) {
    if (state.property == null) return;
    emit(
      state.copyWith(
        property: state.property!.copyWith(
          isBookmarked: !state.property!.isBookmarked,
        ),
      ),
    );
  }

  Future<void> _onSubmitRequest(
    PropertyDetailsSubmitRequest event,
    Emitter<PropertyDetailsState> emit,
  ) async {
    emit(state.copyWith(submitStatus: RequestStatus.loading));
     emit(state.copyWith(submitStatus: RequestStatus.success));
  }
}
