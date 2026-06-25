import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../model/portfolio_property_model.dart';
import '../model/property_model.dart';
import '../model/smart_service_model.dart';

part 'individual_home_event.dart';
part 'individual_home_state.dart';

class IndividualHomeBloc
    extends Bloc<IndividualHomeEvent, IndividualHomeState> {
  IndividualHomeBloc() : super(const IndividualHomeState()) {
    on<IndividualHomeLoad>(_onLoad);
  }

  static IndividualHomeBloc get(BuildContext context) =>
      BlocProvider.of<IndividualHomeBloc>(context);

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
      tag: 'فلل',
    ),
    PropertyModel(
      id: '2',
      title: 'فيلا حديثة في النرجس',
      location: 'الرياض - حي النرجس',
      imageUrl: AppImages.propertyImage,
      beds: 5,
      baths: 4,
      area: '350 ${AppStrings.mesurement}',
      price: 2200000,
      tag: 'شقه',
      isBookmarked: true,
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
      tag: 'فلل',
    ),
  ];

  static final List<PortfolioPropertyModel> _mockPortfolio = [
    PortfolioPropertyModel(
      id: '1',
      title: 'شقة فاخرة في الملقا',
      location: 'الرياض - حي الملقا',
      imageUrl: AppImages.propertyImage,
      status: 'مؤجر',
      bed: 3,
      bath: 2,
      area: '150 ${AppStrings.mesurement}',
    ),
    PortfolioPropertyModel(
      id: '2',
      title: 'فيلا النرجس',
      location: 'الرياض - حي النرجس',
      imageUrl: AppImages.propertyImage,
      status: 'شاغر',
      bed: 5,
      bath: 4,
      area: '350 ${AppStrings.mesurement}',
    ),
  ];

Future<void> getProperties()async{}
Future<void> getMyProperties()async{

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

  void _onLoad(IndividualHomeLoad event, Emitter<IndividualHomeState> emit) {
    emit(
      state.copyWith(
        properties: _mockProperties,
        portfolio: _mockPortfolio,
        userLocation: 'الرياض , المملكة العربية السعودية',
      ),
    );
  }
}
