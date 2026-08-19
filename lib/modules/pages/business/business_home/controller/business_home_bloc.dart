import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
 import '../../../../../core/utils/functions/service_locator.dart';
import '../../../individual/individual_home/model/portfolio_property_model.dart';
import '../../../individual/individual_home/model/properties_item_model.dart';
import '../../../individual/individual_home/model/smart_service_model.dart';
import '../../business_properties/model/business_property_request_model.dart';
import '../model/business_portfolio_property_model.dart';

part 'business_home_event.dart';
part 'business_home_state.dart';

class BusinessHomeBloc extends Bloc<BusinessHomeEvent, BusinessHomeState> {
  BusinessHomeBloc() : super(const BusinessHomeState()) {
    on<BusinessHomeItemsEvent>((event, emit) {
      add(const BusinessPropertiesLoad());
      add(const PortfolioLoad());
      add(const RequestsLoad());
      add(const IndividualHomeLoadUserLocation());
    });
    on<BusinessPropertiesLoad>(_loadBusinessProperties);
    on<PortfolioLoad>(_getMyProperties);
    on<RequestsLoad>(_getRequests);
    on<IndividualHomeLoadUserLocation>(_getUserLocation);
  }

  Future<void> _loadBusinessProperties(
    BusinessPropertiesLoad? event,
    emit,
  ) async {
    try {
      emit(state.copyWith(businessPropertiesLoadStatus: RequestStatus.loading));
      final res = await sl.get<ApiConsumer>().get(EndPoints.properties);
      await res.fold(
        (failedRes) async {
          emit(
            state.copyWith(
              businessPropertiesLoadStatus: RequestStatus.failed,
              propertiesErrorMessage: failedRes,
            ),
          );
        },
        (successRes) async {
          final List<PropertiesItemModel> items = [];
          for (var item in List.from(successRes.response['properties'])) {
            items.add(PropertiesItemModel.fromJson(item));
          }

          emit(
            state.copyWith(
              properties: items,
              businessPropertiesLoadStatus: RequestStatus.success,
            ),
          );
        },
      );
      emit(state.copyWith(businessPropertiesLoadStatus: RequestStatus.success));
    } catch (e) {
      emit(state.copyWith(businessPropertiesLoadStatus: RequestStatus.failed));
    }
  }

  Future<void> _getMyProperties(
    PortfolioLoad event,
    Emitter<BusinessHomeState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          portfolioLoadStatus: RequestStatus.loading,
          portfolio: [],
        ),
      );
      final response = await sl.get<ApiConsumer>().get(EndPoints.portfolio);
      await response.fold(
        (failedResponse) async {
          emit(
            state.copyWith(
              portfolioLoadStatus: RequestStatus.failed,
              portfolioErrorMessage: failedResponse,
              performanceSummary: [
                SmartServiceModel(
                  id: '1',
                  title: AppStrings.propertyCount,
                  description: '0',
                  icon: AppImages.propertyCountIcon,
                ),
                SmartServiceModel(
                  id: '2',
                  title: AppStrings.occupancyRate,
                  description: '0%',
                  icon: AppImages.occupancyRateIcon,
                ),
                SmartServiceModel(
                  id: '3',
                  title: AppStrings.monthlyIncome,
                  description: '0 ${AppStrings.currency}',
                  icon: AppImages.monthlyIncomeIcon,
                ),
              ],
            ),
          );
        },
        (successResponse) async {
          final List<MyPropertiesModel> items = [];
          for (var item in List.from(successResponse.response['data'])) {
            items.add(MyPropertiesModel.fromJson(item));
          }
          final int propertiesCount =
              successResponse.response['summary']['totalProperties'] ?? 0;
          final int occupancyRate =
              successResponse.response['summary']['occupancyRate'] ?? 0;
          final int monthlyIncome =
              successResponse.response['summary']['monthlyIncome'] ?? 0;
          emit(
            state.copyWith(
              portfolioLoadStatus: RequestStatus.success,
              portfolio: items,
              performanceSummary: [
                SmartServiceModel(
                  id: '1',
                  title: AppStrings.propertyCount,
                  description: '$propertiesCount',
                  icon: AppImages.propertyCountIcon,
                ),
                SmartServiceModel(
                  id: '2',
                  title: AppStrings.occupancyRate,
                  description: '$occupancyRate%',
                  icon: AppImages.occupancyRateIcon,
                ),
                SmartServiceModel(
                  id: '3',
                  title: AppStrings.monthlyIncome,
                  description: '$monthlyIncome ${AppStrings.currency}',
                  icon: AppImages.monthlyIncomeIcon,
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          portfolioErrorMessage: AppStrings.somethingWentWrong,
          portfolioLoadStatus: RequestStatus.failed,
          performanceSummary: [
            SmartServiceModel(
              id: '1',
              title: AppStrings.propertyCount,
              description: '0',
              icon: AppImages.propertyCountIcon,
            ),
            SmartServiceModel(
              id: '2',
              title: AppStrings.occupancyRate,
              description: '0%',
              icon: AppImages.occupancyRateIcon,
            ),
            SmartServiceModel(
              id: '3',
              title: AppStrings.monthlyIncome,
              description: '0 ${AppStrings.currency}',
              icon: AppImages.monthlyIncomeIcon,
            ),
          ],
        ),
      );
    }
  }

  Future<void> _getRequests(
    RequestsLoad event,
    Emitter<BusinessHomeState> emit,
  ) async {
    try {
      emit(state.copyWith(requestsLoadStatus: RequestStatus.loading));
      final response = await sl.get<ApiConsumer>().get(EndPoints.requests);
      await response.fold(
        (failedResponse) async {
          emit(
            state.copyWith(
              requestsLoadStatus: RequestStatus.failed,
              requestsErrorMessage: failedResponse,
            ),
          );
        },
        (successResponse) async {
          final List items = [];
          // final List<PortfolioPropertyModel> items = [];
          for (var item in List.from(successResponse.response['requests'])) {
            items.add(PortfolioPropertyModel.fromJson(item));
          }
          emit(
            state.copyWith(
              requestsLoadStatus: RequestStatus.success,
              requests: [],
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          requestsErrorMessage: AppStrings.somethingWentWrong,
          requestsLoadStatus: RequestStatus.failed,
        ),
      );
    }
  }

  Future<void> _getUserLocation(
    IndividualHomeLoadUserLocation event,
    Emitter<BusinessHomeState> emit,
  ) async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(location: ''));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        emit(state.copyWith(location: ''));
        return;
      }
      if (permission == LocationPermission.deniedForever) {
        emit(state.copyWith(location: ''));
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
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

      emit(state.copyWith(location: locationLabel));
      await _updateUserLocation(position, locationLabel);
    } catch (e) {
      emit(state.copyWith(location: ''));
    }
  }

  Future<void> _updateUserLocation(Position position, String location) async {
    await sl.get<ApiConsumer>().put(
      EndPoints.profile,
      body: {'latitude': position.latitude, 'longitude': position.longitude, 'location': location},
    );
  }

  static List<SmartServiceModel> get mockSmartServices => [
    SmartServiceModel(
      route: AppRouterKeys.realEstateDevelopmentList,
      id: '1',
      title: AppStrings.realEstateDevelopment,
      description: AppStrings.realEstateDevelopmentDescription,
      icon: AppImages.propertiesDevelopmentIcon,
    ),
    SmartServiceModel(
      route: AppRouterKeys.rateProperty,
      id: '7',
      title: AppStrings.propertyEvaluation,
      description: AppStrings.propertyEvaluationDescription,
      icon: AppImages.ratingIcon,
    ),
    SmartServiceModel(
      route: AppRouterKeys.propertyInsurance,
      id: '6',
      title: AppStrings.insuranceProperty,
      description: AppStrings.insurancePropertyDescription,
      icon: AppImages.safetyIcon,
    ),

    SmartServiceModel(
      id: '2',
      title: AppStrings.performanceReports,
      description: AppStrings.performanceReportsDescription,
      icon: AppImages.performanceReportsIcon,
      // route: AppRouterKeys.performanceReports,
      route: AppRouterKeys.constructionReportsScreen,
    ),
    SmartServiceModel(
      // route: AppRouterKeys.financialReports,
      route: AppRouterKeys.financialReportsScreen,
      id: '3',
      title: AppStrings.financialReports,
      description: AppStrings.financialReportsDescription,
      icon: AppImages.financialReportsIcon,
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
