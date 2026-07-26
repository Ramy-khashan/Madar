import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/print_state.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../model/ads_item_model.dart';
import '../model/portfolio_property_model.dart';
import '../model/properties_item_model.dart';
import '../model/smart_service_model.dart';

part 'individual_home_event.dart';
part 'individual_home_state.dart';

class IndividualHomeBloc
    extends Bloc<IndividualHomeEvent, IndividualHomeState> {
  IndividualHomeBloc() : super(const IndividualHomeState()) {
    on<IndividualHomeLoad>((even, emit) async {
      add(const IndividualHomeLoadProperties());

      add(const IndividualHomeLoadPortfolio());

      add(const IndividualHomeLoadAds());
      add(const IndividualHomeLoadUserLocation());
    });
    on<IndividualHomeLoadProperties>(_getProperties);
    on<IndividualHomeLoadPortfolio>(_getMyProperties);
    on<IndividualHomeLoadAds>(_getAds);
    on<IndividualHomeLoadUserLocation>(_getUserLocation);
  }

  static IndividualHomeBloc get(BuildContext context) =>
      BlocProvider.of<IndividualHomeBloc>(context);

  Future<void> _getAds(
    IndividualHomeLoadAds event,
    Emitter<IndividualHomeState> emit,
  ) async {
    try {
      emit(state.copyWith(adsStatus: RequestStatus.loading, adsItem: []));

      final response = await sl.get<ApiConsumer>().get(EndPoints.ads);
      await response.fold(
        (failedResponse) async {
          emit(
            state.copyWith(
              adsStatus: RequestStatus.failed,
              adsErrorMsg: failedResponse,
            ),
          );
        },
        (successResponse) async {
          final List<AdsItemModel> items = [];
          for (var item in List.from(successResponse.response['data'])) {
            items.add(AdsItemModel.fromJson(item));
          }
          emit(
            state.copyWith(adsStatus: RequestStatus.success, adsItem: items),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          adsErrorMsg: AppStrings.somethingWentWrong,
          adsStatus: RequestStatus.failed,
        ),
      );
    }
  }

  Future<void> _getProperties(
    IndividualHomeLoadProperties event,
    Emitter<IndividualHomeState> emit,
  ) async {
    try {
      emit(
        state.copyWith(propertiesStatus: RequestStatus.loading, properties: []),
      );
      final response = await sl.get<ApiConsumer>().get(EndPoints.properties);
      await response.fold(
        (failedResponse) async {
          emit(
            state.copyWith(
              propertiesStatus: RequestStatus.failed,
              propertiesErrorMsg: failedResponse,
            ),
          );
        },
        (successResponse) async {
          final List<PropertiesItemModel> items = [];
          for (var item in List.from(successResponse.response['properties'])) {
            items.add(PropertiesItemModel.fromJson(item));
          }
          emit(
            state.copyWith(
              propertiesStatus: RequestStatus.success,
              properties: items,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          propertiesErrorMsg: AppStrings.somethingWentWrong,
          propertiesStatus: RequestStatus.failed,
        ),
      );
    }
  }

  Future<void> _getMyProperties(
    IndividualHomeLoadPortfolio event,
    Emitter<IndividualHomeState> emit,
  ) async {
    try {
      emit(
        state.copyWith(portfolioStatus: RequestStatus.loading, portfolio: []),
      );
      final response = await sl.get<ApiConsumer>().get(EndPoints.portfolio);
      await response.fold(
        (failedResponse) async {
          emit(
            state.copyWith(
              portfolioStatus: RequestStatus.failed,
              portfolioErrorMsg: failedResponse,
            ),
          );
        },
        (successResponse) async {
     
          final List<PortfolioPropertyModel> items = [];
          for (var item in List.from(
            successResponse.response['data'] ,
          )) {
            items.add(PortfolioPropertyModel.fromJson(item));
          }
          emit(
            state.copyWith(
              portfolioStatus: RequestStatus.success,
              portfolio: items,
            ),
          );
        },
      );
    } catch (e) {
      printState(e.toString());
      emit(
        state.copyWith(
          portfolioErrorMsg: AppStrings.somethingWentWrong,
          portfolioStatus: RequestStatus.failed,
        ),
      );
    }
  }

  Future<void> _getUserLocation(
    IndividualHomeLoadUserLocation event,
    Emitter<IndividualHomeState> emit,
  ) async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(userLocation: ''));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        emit(state.copyWith(userLocation: ''));
        return;
      }
      if (permission == LocationPermission.deniedForever) {
        emit(state.copyWith(userLocation: ''));
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      await _updateUserLocation(position);
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String locationLabel = '';
      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        final parts = [
          place.country,
          place.administrativeArea,
          place.locality,

          place.subLocality,
        ].where((p) => p != null && p.isNotEmpty).join(', ');
        locationLabel = parts;
      }

      emit(state.copyWith(userLocation: locationLabel));
    } catch (e) {
      printState(e.toString());
      emit(state.copyWith(userLocation: ''));
    }
  }

  Future<void> _updateUserLocation(Position position) async {
    await sl.get<ApiConsumer>().put(
      EndPoints.profile,
      body: {'latitude': position.latitude, 'longitude': position.longitude},
    );
  }

  static List<SmartServiceModel> get mockSmartServices => [
    SmartServiceModel(
      route: AppRouterKeys.rentInstallment,
      id: '1',
      title: AppStrings.rentInstallment,
      description: AppStrings.rentInstallmentDescription,
      icon: AppImages.rentIcon,
    ),
    SmartServiceModel(
      route: AppRouterKeys.propertyInsurance,
      id: '2',
      title: AppStrings.insuranceProperty,
      description: AppStrings.insurancePropertyDescription,
      icon: AppImages.safetyIcon,
    ),
    SmartServiceModel(
      route: AppRouterKeys.rateProperty,
      id: '3',
      title: AppStrings.propertyEvaluation,
      description: AppStrings.propertyEvaluationDescription,
      icon: AppImages.ratingIcon,
    ),
    SmartServiceModel(
      id: '4',
      title: AppStrings.auctionProperty,
      description: AppStrings.auctionPropertyDescription,
      icon: AppImages.auctionIcon,
      route: AppRouterKeys.auctionNavbar,
    ),
    SmartServiceModel(
      route: AppRouterKeys.realEstateNews,
      id: '5',
      title: AppStrings.realEstateNews,
      description: AppStrings.realEstateNewsDescription,
      icon: AppImages.newsIcon,
    ),
  ];
}
