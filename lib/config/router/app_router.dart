import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../modules/common/broker_properties/controller/broker_properties_bloc.dart';
import '../../modules/common/broker_properties/view/broker_properties_screen.dart';
import '../../modules/common/chats/smart_assistant_chat/controller/smart_assistant_chat_bloc.dart';
import '../../modules/common/chats/smart_assistant_chat/view/smart_assistant_chat_screen.dart';
import '../../modules/common/contract_details/controller/contract_details_bloc.dart';
import '../../modules/common/contract_details/view/contract_details_screen.dart';
import '../../modules/common/my_wishlist/controller/my_wishlist_bloc.dart';
import '../../modules/common/my_wishlist/view/my_wishlist_screen.dart';
import '../../modules/common/settings/view/widgets/delete_account_screen.dart';
import '../../modules/pages/business/business_properties/controller/business_properties_bloc.dart';
import '../../modules/pages/business/business_properties/view/business_properties_screen.dart';
import '../../modules/pages/business/construction_reports/controller/construction_reports_bloc.dart';
import '../../modules/pages/business/construction_reports/view/construction_reports_screen.dart';
import '../../modules/pages/business/financial_reports/controller/financial_reports_bloc.dart';
import '../../modules/pages/business/financial_reports/view/financial_reports_screen.dart';
import '../../modules/pages/business/net_profit_loss/controller/net_profit_loss_bloc.dart';
import '../../modules/pages/business/net_profit_loss/view/net_profit_loss_screen.dart';
import '../../modules/pages/business/real_estate_development/add_project/add_commercial_project/controller/add_commercial_project_bloc.dart';
import '../../modules/pages/business/real_estate_development/add_project/add_commercial_project/view/add_commercial_project_screen.dart';
import '../../modules/pages/business/real_estate_development/add_project/add_residential_project/view/add_residential_project_screen.dart';
import '../../modules/pages/business/real_estate_development/business_project_details/controller/business_project_details_bloc.dart';
import '../../modules/pages/business/real_estate_development/business_project_details/model/real_state_project_model.dart';
import '../../modules/pages/business/real_estate_development/business_project_details/view/business_project_details_screen.dart';
import '../../modules/pages/business/real_estate_development/projects_list/controller/projects_list_bloc.dart';

import '../../modules/pages/business/real_estate_development/projects_list/view/projects_list_screen.dart';

import '../../modules/pages/individual/add_property/controller/add_property_bloc.dart';
import '../../modules/pages/individual/add_property/view/add_property_screen.dart';
import '../../modules/pages/project_manager/project_manager_home/controller/project_manager_home_bloc.dart';
import '../../modules/pages/project_manager/project_manager_home/view/project_manager_home_screen.dart';
import '../../modules/pages/project_manager/project_details/controller/project_details_bloc.dart';
import '../../modules/pages/project_manager/project_details/view/project_details_screen.dart';
import '../../modules/pages/project_manager/phase_details/controller/phase_details_bloc.dart';
import '../../modules/pages/project_manager/phase_details/view/phase_details_screen.dart';
import '../../modules/pages/properties_file_operation/property_file/controller/property_file_bloc.dart';
import '../../modules/pages/properties_file_operation/property_file/model/property_file_model.dart';
import '../../modules/pages/properties_file_operation/property_file/view/property_file_screen.dart';
import '../../modules/pages/properties_file_operation/unit_details/view/unit_details_screen.dart';
import '../../madar_app.dart';
import '../../modules/auth/business_sign_up_scenario/loading_pay/view/loading_pay_screen.dart';
import '../../modules/auth/business_sign_up_scenario/payment_type/view/payment_type_screen.dart';
import '../../modules/auth/business_sign_up_scenario/subscription_plans/controller/subscription_bloc.dart';
import '../../modules/auth/business_sign_up_scenario/subscription_plans/view/subscription_plans_screen.dart';
import '../../modules/auth/business_sign_up_scenario/summary_subscription/view/summary_subscription_screen.dart';
import '../../modules/auth/forget_password/controller/forget_password_bloc.dart';
import '../../modules/auth/forget_password/view/forget_password_screen.dart';
import '../../modules/auth/otp_verification/controller/otp_verification_bloc.dart';
import '../../modules/auth/otp_verification/view/otp_verification_screen.dart';
import '../../modules/auth/sign_in/controller/sign_in_bloc.dart';
import '../../modules/auth/sign_in/view/sign_in_screen.dart';
import '../../modules/auth/sign_up/controller/sign_up_bloc.dart';
import '../../modules/auth/sign_up/view/sign_up_screen.dart';
import '../../modules/common/chats/conversation_detail/controller/conversation_detail_bloc.dart';
import '../../modules/common/chats/conversation_detail/model/conversation_info.dart';
import '../../modules/common/chats/conversation_detail/view/conversation_detail_screen.dart';
import '../../modules/common/choose_account/controller/choose_account_bloc.dart';
import '../../modules/common/choose_account/view/choose_account_screen.dart';
import '../../modules/common/navbar/controller/navbar_bloc.dart';
import '../../modules/common/navbar/view/navbar_screen.dart';
import '../../modules/common/notification/controller/notification_bloc.dart';
import '../../modules/common/notification/view/notification_screen.dart';
import '../../modules/common/no_internet/view/no_internet_screen.dart';
import '../../modules/common/on_boarding/controller/on_boarding_bloc.dart';
import '../../modules/common/on_boarding/view/on_boarding_screen.dart';
import '../../modules/common/real_estate_news/controller/real_estate_news_bloc.dart';
import '../../modules/common/real_estate_news/view/real_estate_news_screen.dart';
import '../../modules/common/real_estate_news_details/controller/real_estate_news_details_bloc.dart';
import '../../modules/common/real_estate_news_details/view/real_estate_news_details_screen.dart';
import '../../modules/common/splash/view/splash_screen.dart';
import '../../modules/pages/auction/add_auction_property/controller/add_auction_property_bloc.dart';
import '../../modules/pages/auction/add_auction_property/view/add_auction_property_screen.dart';
import '../../modules/pages/auction/auction_bid_result/controller/auction_bid_result_bloc.dart';
import '../../modules/pages/auction/auction_bid_result/view/auction_bid_result_screen.dart';
import '../../modules/pages/auction/auction_deposit/controller/auction_deposit_bloc.dart';
import '../../modules/pages/auction/auction_deposit/view/auction_deposit_screen.dart';
import '../../modules/pages/auction/auction_details/controller/auction_details_bloc.dart';
import '../../modules/pages/auction/auction_details/view/auction_details_screen.dart';
import '../../modules/pages/auction/auction_list/controller/auction_list_bloc.dart';
import '../../modules/pages/auction/auction_list/view/auction_list_screen.dart';
import '../../modules/pages/auction/auction_navbar/controller/auction_navbar_bloc.dart';
import '../../modules/pages/auction/auction_navbar/view/auction_navbar_screen.dart';
import '../../modules/pages/auction/my_bids/controller/my_bids_bloc.dart';
import '../../modules/pages/auction/my_bids/view/my_bids_screen.dart';
import '../../modules/pages/auction/my_listings/controller/my_listings_bloc.dart';
import '../../modules/pages/auction/my_listings/view/my_listings_screen.dart';
import '../../modules/pages/individual/choose_broker/controller/choose_broker_bloc.dart';
import '../../modules/pages/individual/choose_broker/view/choose_broker_screen.dart';
import '../../modules/pages/individual/insurance_options/controller/insurance_options_bloc.dart';
import '../../modules/pages/individual/insurance_options/view/insurance_options_screen.dart';
import '../../modules/pages/individual/my_properties/controller/my_properties_bloc.dart';
import '../../modules/pages/individual/my_properties/view/my_properties_screen.dart';
import '../../modules/pages/individual/my_property_details/controller/my_property_details_bloc.dart';
import '../../modules/pages/individual/my_property_details/view/my_property_details_screen.dart';
import '../../modules/pages/individual/owner_properties/controller/owner_properties_bloc.dart';
import '../../modules/pages/individual/owner_properties/view/owner_properties_screen.dart';
import '../../modules/pages/individual/properties/controller/properties_bloc.dart';
import '../../modules/pages/individual/properties/view/properties_listing_screen.dart';
import '../../modules/pages/individual/properties_map/view/properties_map_screen.dart';
import '../../core/model/google_map_model.dart';
import '../../modules/pages/individual/property_details/controller/property_details_bloc.dart';
import '../../modules/pages/individual/property_details/view/property_details_screen.dart';
import '../../modules/pages/individual/property_insurance/controller/property_insurance_bloc.dart';
import '../../modules/pages/individual/property_insurance/view/property_insurance_screen.dart';
import '../../modules/pages/individual/rate_property_scenario/rate_property/controller/rate_property_bloc.dart';
import '../../modules/pages/individual/rate_property_scenario/rate_property/view/rate_property_screen.dart';
import '../../modules/pages/individual/rate_property_scenario/rate_property_certified/controller/rate_property_certified_bloc.dart';
import '../../modules/pages/individual/rate_property_scenario/rate_property_certified/view/rate_property_certified_form_screen.dart';
import '../../modules/pages/individual/rate_property_scenario/rate_property_certified/view/rate_property_certified_info_screen.dart';
import '../../modules/pages/individual/rate_property_scenario/rate_property_estimation/controller/rate_property_estimation_bloc.dart';
import '../../modules/pages/individual/rate_property_scenario/rate_property_estimation/view/rate_property_estimation_form_screen.dart';
import '../../modules/pages/individual/rate_property_scenario/rate_property_estimation/view/rate_property_loading_screen.dart';
import '../../modules/pages/individual/rate_property_scenario/rate_property_estimation/view/rate_property_result_screen.dart';
import '../../modules/pages/individual/rent_installment/controller/rent_installment_bloc.dart';
import '../../modules/pages/individual/rent_installment/view/rent_installment_screen.dart';
import '../../modules/pages/individual/rent_options/controller/rent_options_bloc.dart';
import '../../modules/pages/individual/rent_options/view/rent_options_screen.dart';
import 'app_router_keys.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: MadarApp.navigatorKey,
  initialLocation: AppRouterKeys.splash,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    getRouteInstance(AppRouterKeys.splash, (state) => const SplashScreen()),
    getRouteInstance(
      AppRouterKeys.noInternet,
      (state) => const NoInternetScreen(),
    ),
    getRouteInstance(
      AppRouterKeys.onBoarding,
      (state) => BlocProvider(
        create: (context) => OnBoardingBloc(),
        child: const OnBoardingScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.chooseAccount,
      (state) => BlocProvider(
        create: (context) => ChooseAccountBloc(),
        child: const ChooseAccountScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.signUp,
      (state) => BlocProvider(
        create: (context) => SignUpBloc(),
        child: const SignUpScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.forgetPassword,
      (state) => BlocProvider(
        create: (context) => ForgetPasswordBloc(),
        child: const ForgetPasswordScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.signIn,
      (state) => BlocProvider(
        create: (context) => SignInBloc(),
        child: const SignInScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.subscriptionPlans,
      (state) => BlocProvider(
        create: (_) => SubscriptionBloc()..add(const SubscriptionLoad()),
        child: const SubscriptionPlansScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.subscriptionPaymentType,
      (state) => BlocProvider.value(
        value: state.extra as SubscriptionBloc,
        child: const PaymentTypeScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.deleteAccountScreen,
      (state) => const DeleteAccountScreen(),
    ),
    getRouteInstance(
      AppRouterKeys.businessPropertiesScreen,
      (state) => BlocProvider(
        create: (_) =>
            BusinessPropertiesBloc()..add(const BusinessPropertiesLoad()),
        child: const BusinessPropertiesScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.subscriptionLoadingPay,
      (state) => BlocProvider.value(
        value: state.extra as SubscriptionBloc,
        child: const LoadingPayScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.subscriptionSummary,
      (state) => BlocProvider.value(
        value: state.extra as SubscriptionBloc,
        child: const SummarySubscriptionScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.navbar,
      (state) => BlocProvider(
        create: (context) => NavbarBloc()..add(const NavBarInitList()),
        child: const NavbarScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.addProperty,
      (state) => BlocProvider(
        create: (_) => AddPropertyBloc(),
        child: const AddPropertyScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.propertiesListing,
      (state) => BlocProvider(
        create: (_) => PropertiesBloc()..add(const PropertiesLoad()),
        child: const PropertiesListingScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.myProperties,
      (state) => BlocProvider(
        create: (context) => MyPropertiesBloc()..add(const MyPropertiesLoad()),
        child: const MyPropertiesScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.propertyFileDetails,
      (state) => BlocProvider(
        create: (_) => PropertyFileBloc()..add(const PropertyFileLoad()),
        child: const PropertyFileScreen(),
      ),
    ),

    getRouteInstance(AppRouterKeys.unitDetailsScreen, (state) {
      final extra = state.extra as Map<String, dynamic>;
      return UnitDetailsScreen(
        unit: extra['unit'] as UnitModel,
        propertyName: extra['propertyName'] as String,
      );
    }),
    getRouteInstance(
      AppRouterKeys.myPropertyDetails,
      (state) => BlocProvider(
        create: (context) =>
            MyPropertyDetailsBloc()
              ..add(MyPropertyDetailsLoad(state.extra as String? ?? '1')),
        child: const MyPropertyDetailsScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.propertyDetails,
      (state) => BlocProvider(
        create: (_) =>
            PropertyDetailsBloc()
              ..add(PropertyDetailsLoad(state.extra as String? ?? '1')),
        child: PropertyDetailsScreen(propertyId: state.extra as String? ?? '1'),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.conversationDetail,
      (state) => BlocProvider(
        create: (_) => ConversationDetailBloc()
          ..add(
            ConversationDetailLoad(
              conversationId: (state.extra as ConversationInfo).conversationId,
            ),
          ),
        child: ConversationDetailScreen(
          conversation: state.extra as ConversationInfo,
        ),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.chooseBroker,
      (state) => BlocProvider(
        create: (context) => ChooseBrokerBloc()..add(const ChooseBrokerLoad()),
        child: const ChooseBrokerScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.rentInstallment,
      (state) => BlocProvider(
        create: (_) => RentInstallmentBloc()..add(const RentInstallmentLoad()),
        child: const RentInstallmentScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.propertyInsurance,
      (state) => BlocProvider(
        create: (_) =>
            PropertyInsuranceBloc()..add(const PropertyInsuranceLoad()),
        child: const PropertyInsuranceScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.rateProperty,
      (state) => BlocProvider(
        create: (_) => RatePropertyBloc()..add(const RatePropertyLoad()),
        child: const RatePropertyScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.ratePropertyEstimationForm,
      (state) => BlocProvider(
        create: (_) => RatePropertyEstimationBloc(),

        child: const RatePropertyEstimationFormScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.ratePropertyLoading,
      (state) => BlocProvider.value(
        value: state.extra as RatePropertyEstimationBloc,
        child: const RatePropertyLoadingScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.ratePropertyResult,
      (state) => RatePropertyResultScreen(
        bloc: state.extra as RatePropertyEstimationBloc,
      ),
    ),
    getRouteInstance(
      AppRouterKeys.ratePropertyCertifiedInfo,
      (state) => const RatePropertyCertifiedInfoScreen(),
    ),
    getRouteInstance(
      AppRouterKeys.ratePropertyCertifiedForm,
      (state) =>
          RatePropertyCertifiedFormScreen(bloc: RatePropertyCertifiedBloc()),
    ),
    //Auction routes
    getRouteInstance(
      AppRouterKeys.auctionNavbar,
      (state) => BlocProvider(
        create: (context) => AuctionNavbarBloc(),
        child: const AuctionNavbarScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.auctionList,
      (state) => BlocProvider(
        create: (_) => AuctionListBloc()..add(const AuctionListLoad()),
        child: const AuctionListScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.auctionDetails,
      (state) => BlocProvider(
        create: (_) =>
            AuctionDetailsBloc()
              ..add(AuctionDetailsLoad(state.extra as String? ?? '1')),
        child: AuctionDetailsScreen(auctionId: state.extra as String? ?? '1'),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.auctionDeposit,
      (state) => BlocProvider(
        create: (_) =>
            AuctionDepositBloc()
              ..add(AuctionDepositLoad(state.extra as String? ?? '1')),

        child: AuctionDepositScreen(auctionId: state.extra as String? ?? '1'),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.auctionBidResult,
      (state) => BlocProvider(
        create: (_) =>
            AuctionBidResultBloc()
              ..add(AuctionBidResultLoad(state.extra as String? ?? '1')),
        child: AuctionBidResultScreen(auctionId: state.extra as String? ?? '1'),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.myBids,
      (state) => BlocProvider(
        create: (_) => MyBidsBloc()..add(const MyBidsLoad()),
        child: const MyBidsScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.addAuctionProperty,
      (state) => BlocProvider(
        create: (_) => AddAuctionPropertyBloc(),
        child: const AddAuctionPropertyScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.myListings,
      (state) => BlocProvider(
        create: (_) => MyListingsBloc()..add(const MyListingsLoad()),
        child: const MyListingsScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.rentOptions,
      (state) => BlocProvider(
        create: (_) =>
            RentOptionsBloc()
              ..add(RentOptionsLoad(state.extra as String? ?? '1')),
        child: RentOptionsScreen(propertyId: state.extra as String? ?? '1'),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.insuranceOptions,
      (state) => BlocProvider(
        create: (_) =>
            InsuranceOptionsBloc()
              ..add(InsuranceOptionsLoad(state.extra as String? ?? '1')),
        child: InsuranceOptionsScreen(
          propertyId: state.extra as String? ?? '1',
        ),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.realEstateNews,
      (state) => BlocProvider(
        create: (_) => RealEstateNewsBloc()..add(const RealEstateNewsLoad()),
        child: const RealEstateNewsScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.realEstateNewsDetails,
      (state) => BlocProvider(
        create: (_) =>
            RealEstateNewsDetailsBloc()
              ..add(RealEstateNewsDetailsLoad(state.extra as String? ?? '1')),
        child: RealEstateNewsDetailsScreen(
          newsId: state.extra as String? ?? '1',
        ),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.ownerProperties,
      (state) => BlocProvider(
        create: (_) => OwnerPropertiesBloc()..add(const OwnerPropertiesLoad()),
        child: const OwnerPropertiesScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.propertyLocationMap,
      (state) =>
          PropertiesMapScreen(initialPosition: state.extra as PositionModel?),
    ),
    getRouteInstance(
      AppRouterKeys.otpVerification,
      (state) => BlocProvider(
        create: (_) => OtpVerificationBloc(),
        child: OtpVerificationScreen(phoneNumber: state.extra as String? ?? ''),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.notification,
      (state) => BlocProvider(
        create: (_) => NotificationBloc()..add(const NotificationLoad()),
        child: const NotificationScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.smartAssistantChat,
      (state) => BlocProvider(
        create: (_) =>
            SmartAssistantChatBloc()..add(const SmartAssistantChatLoad()),
        child: const SmartAssistantChatScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.projectManagerHome,
      (state) => BlocProvider(
        create: (_) =>
            ProjectManagerHomeBloc()..add(const ProjectManagerHomeLoad()),
        child: const ProjectManagerHomeScreen(),
      ),
    ),

    getRouteInstance(
      AppRouterKeys.projectManagerDetails,
      (state) => BlocProvider(
        create: (_) => ProjectDetailsBloc()
          ..add(ProjectDetailsLoad(projectId: state.extra as String? ?? '1')),
        child: const ProjectDetailsScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.phaseDetails,
      (state) {
        final param = state.extra as Map<String, dynamic>;
        return BlocProvider(
        create: (_) =>
            PhaseDetailsBloc(phase: param['phase'] as ProjectStages, timeline: param['timeline'] as List<Timeline>),
        child: PhaseDetailsScreen(
          projectId: param['projectId'] as String? ?? '',
          phase: param['phase'] as ProjectStages,
          timeline: param['timeline'] as List<Timeline>,
        ),
      );
      },
    ),
    getRouteInstance(
      AppRouterKeys.contractDetails,
      (state) => BlocProvider(
        create: (_) =>
            ContractDetailsBloc()
              ..add(ContractDetailsLoad(state.extra as String? ?? '1')),
        child: ContractDetailsScreen(contractId: state.extra as String? ?? '1'),
      ),
    ),

    getRouteInstance(
      AppRouterKeys.constructionReportsScreen,
      (state) => BlocProvider(
        create: (_) =>
            ConstructionReportsBloc()..add(const ConstructionReportsLoad()),
        child: const ConstructionReportsScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.financialReportsScreen,
      (state) => BlocProvider(
        create: (_) =>
            FinancialReportsBloc()..add(const FinancialReportsLoad()),
        child: const FinancialReportsScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.netProfitLossScreen,
      (state) => BlocProvider(
        create: (_) => NetProfitLossBloc()..add(const NetProfitLossLoad()),
        child: const NetProfitLossScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.realEstateDevelopmentList,
      (state) => BlocProvider(
        create: (_) => ProjectsListBloc()..add(const ProjectsListLoad()),
        child: const ProjectsListScreen(),
      ),
    ),

    getRouteInstance(AppRouterKeys.realEstateDevelopmentDetails, (state) {
      final map = state.extra as Map<String, dynamic>;
      return BlocProvider(
        create: (_) => BusinessProjectDetailsBloc()
          ..add(
            BusinessProjectDetailsLoad(projectId: map['projectId'] as String),
          ),
        child: const BusinessProjectDetailsScreen(),
      );
    }),
    getRouteInstance(
      AppRouterKeys.realEstateDevelopmentAddProject,
      (state) => const AddResidentialProjectScreen(),
    ),
    getRouteInstance(
      AppRouterKeys.realEstateDevelopmentAddCommercial,
      (state) => BlocProvider(
        create: (_) => AddCommercialProjectBloc(),
        child: const AddCommercialProjectScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.myWishlist,
      (state) => BlocProvider(
        create: (context) => MyWishlistBloc()..add(const MyWishlistLoad()),
        child: const MyWishlistScreen(),
      ),
    ),
    getRouteInstance(
      AppRouterKeys.brokerProperties,
      (state) => BlocProvider(
        create: (_) =>
            BrokerPropertiesBloc()..add(const BrokerPropertiesLoad()),
        child: const BrokerPropertiesScreen(),
      ),
    ),
  ],
);

GoRoute getRouteInstance(
  String path,
  Widget Function(GoRouterState state) screen,
) => GoRoute(
  path: path.contains('/') ? path : '/$path',
  name: path,
  builder: (BuildContext context, GoRouterState state) {
    return screen(state);
  },
);
