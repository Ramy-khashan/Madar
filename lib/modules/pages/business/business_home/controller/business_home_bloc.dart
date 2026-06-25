import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/router/app_router_keys.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../individual/individual_home/model/portfolio_property_model.dart';
import '../../../individual/individual_home/model/property_model.dart';
import '../../../individual/individual_home/model/smart_service_model.dart';
import '../../business_properties/model/business_property_request_model.dart';
  
part 'business_home_event.dart';
part 'business_home_state.dart';

class BusinessHomeBloc extends Bloc<BusinessHomeEvent, BusinessHomeState> {
  BusinessHomeBloc() : super(const BusinessHomeState()) {
    on<BusinessHomeItemsEvent>(_loadItems);
  }
  void _loadItems(
    BusinessHomeItemsEvent event,
    Emitter<BusinessHomeState> emit,
  ) {
        final List<PropertyModel> properties = [
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

    final List<BusinessPropertyRequestModel> mockRequests = [
      const BusinessPropertyRequestModel(
        id: '1',
        title: 'شقة فاخرة في الملقا',
        location: 'الرياض - حي الملقا',
        individualName: 'محمد العتيبي',
        requestDate: '01-02-2026',
        imageUrl: 'assets/images/property.png',
        status: 'بانتظار الرد',
      ),
      const BusinessPropertyRequestModel(
        id: '2',
        title: 'شقة فاخرة في الملقا',
        location: 'الرياض - حي الملقا',
        individualName: 'محمد العتيبي',
        requestDate: '01-02-2026',
        imageUrl: 'assets/images/property.png',
        status: 'بانتظار الرد',
      ),
      const BusinessPropertyRequestModel(
        id: '3',
        title: 'شقة فاخرة في الملقا',
        location: 'الرياض - حي الملقا',
        individualName: 'محمد العتيبي',
        requestDate: '01-02-2026',
        imageUrl: 'assets/images/property.png',
        status: 'بانتظار الرد',
      ),
    ];
    final portfolio = [
      const PortfolioPropertyModel(
        id: '1',
        title: 'شقة فاخرة في الملقا',
        location: 'الرياض - حي الملقا',
        imageUrl: AppImages.propertyImage,
  bed: 3, bath: 3, area: '3',
        
        status: 'مؤجر',
      ),
      const PortfolioPropertyModel(
        id: '2',
        title: 'فيلا حديثة في النرجس',
        location: 'الرياض - حي النرجس',
        imageUrl: AppImages.propertyImage,
        
        status: 'مؤجر', bed: 3, bath: 3, area: '3',
      ),
      const PortfolioPropertyModel(
        id: '3',
        title: 'شقة في حي العليا',
        location: 'الرياض - حي العليا',
        imageUrl: AppImages.propertyImage,
       
        status: 'مؤجر', bed: 3, bath: 3, area: '3',
      ),
    ];
    emit(
      state.copyWith(
        portfolio: portfolio,
        requests: mockRequests,
        properties:properties,
        location: 'الرياض , المملكة العربية السعودية',
      ),
    );
  }

  static List<SmartServiceModel> get mockPerformanceSummary => [
    SmartServiceModel(
      id: '1',
      title: AppStrings.propertyCount,
      description: '1000',
      icon: AppImages.propertyCountIcon,
      route: '',
    ),
    SmartServiceModel(
      id: '2',
      title: AppStrings.occupancyRate,
      description: '50%',
      icon: AppImages.occupancyRateIcon,
      route: '',
    ),
    SmartServiceModel(
      id: '3',
      title: AppStrings.monthlyIncome,
      description: '150,000 ${AppStrings.currency}',
      icon: AppImages.monthlyIncomeIcon,
      route: '',
    ),
  ];
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
