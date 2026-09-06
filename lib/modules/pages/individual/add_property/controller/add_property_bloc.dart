import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/functions/service_locator.dart';

import '../../../../../core/repository/apis/create_property_apis.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/hijri_date.dart';
import '../../../business/business_home/model/business_portfolio_property_model.dart';
import '../model/add_property_model.dart';
import '../model/add_property_request_mapper.dart';
import '../model/add_property_validator.dart';
import '../model/property_enums.dart';

part 'add_property_event.dart';
part 'add_property_state.dart';
part 'mixins/add_property_controllers_mixin.dart';
part 'mixins/add_property_steps_mixin.dart';
part 'mixins/add_property_media_mixin.dart';
part 'mixins/add_property_details_mixin.dart';
part 'mixins/add_property_submit_mixin.dart';

class AddPropertyBloc extends Bloc<AddPropertyEvent, AddPropertyState>
    with
        AddPropertyControllersMixin,
        AddPropertyStepsMixin,
        AddPropertyMediaMixin,
        AddPropertyDetailsMixin,
        AddPropertySubmitMixin {
  AddPropertyBloc() : super(const AddPropertyState()) {
    on<NextStepEvent>(_onNext);
    on<PreviousStepEvent>(_onPrevious);
    on<SelectOperationTypeEvent>(_onSelectOperationType);
    on<SelectPropertyTypeEvent>(_onSelectPropertyType);
    on<SelectRentalPeriodEvent>(_onSelectRentalPeriod);
    on<UpdateLocationEvent>(_onUpdateLocation);
    on<UpdateCoordinatesEvent>(_onUpdateCoordinates);
    on<SelectDeedTypeEvent>(_onSelectDeedType);
    on<SelectDateTypeEvent>(_onSelectDateType);
    on<DeedDatePickedEvent>(_onDeedDatePicked);
    on<AddImageEvent>(_onAddImage);
    on<AddImagesEvent>(_onAddImages);
    on<RemoveImageEvent>(_onRemoveImage);
    on<ToggleAiEnhancementEvent>(_onToggleAiEnhancement);
    on<SetVideoPathEvent>(_onSetVideoPath);
    on<ClearVideoEvent>(_onClearVideo);
    on<SetVirtualTourPathEvent>(_onSetVirtualTourPath);
    on<ClearVirtualTourEvent>(_onClearVirtualTour);
    on<SetDeedDocumentEvent>(_onSetDeedDocument);
    on<ClearDeedDocumentEvent>(_onClearDeedDocument);
    on<PreviewEvaluationEvent>(_onPreviewEvaluation);
    on<ApplyAiDescriptionEvent>(_onApplyAiDescription);
    on<SelectFacadeEvent>(_onSelectFacade);
    on<IncrementStreetCountEvent>(_onIncrementStreetCount);
    on<DecrementStreetCountEvent>(_onDecrementStreetCount);
    on<SelectStreetWidthEvent>(_onSelectStreetWidth);
    on<SelectPropertyAgeEvent>(_onSelectPropertyAge);
    on<IncrementCounterEvent>(_onIncrementCounter);
    on<DecrementCounterEvent>(_onDecrementCounter);
    on<SelectDropdownEvent>(_onSelectDropdown);
    on<SetDetailFieldEvent>(_onSetDetailField);
    on<ToggleDetailListItemEvent>(_onToggleDetailListItem);
    on<IncrementDetailCounterEvent>(_onIncrementDetailCounter);
    on<DecrementDetailCounterEvent>(_onDecrementDetailCounter);
    on<ToggleDetailFlagEvent>(_onToggleDetailFlag);
    on<ToggleAmenityEvent>(_onToggleAmenity);
    on<ToggleRentInstallmentEvent>(_onToggleRentInstallment);
    on<ToggleInsuranceEvent>(_onToggleInsurance);
    on<ShowPortfolioSheetEvent>(_onShowPortfolioSheet);
    on<HidePortfolioSheetEvent>(_onHidePortfolioSheet);
    on<ConfirmSaveEvent>(_onConfirmSave);
    on<SendToBrokerEvent>(_onSendToBroker);
    on<MapLocationSelectedEvent>(_onMapLocationSelected);
  }

  // ── Static data ──────────────────────────────────────────────────────────

  static AddPropertyBloc get(BuildContext context) =>
      context.read<AddPropertyBloc>();
  static List<Map<String, dynamic>> get propertyTypeItems => [
    {
      'id': 'APARTMENT',
      'label': AppStrings.propertyTypeApartment,
      'icon': AppImages.apartment,
    },
    {
      'id': 'VILLA',
      'label': AppStrings.propertyTypeVilla,
      'icon': AppImages.villa,
    },
    {
      'id': 'FLOOR',
      'label': AppStrings.propertyTypeFloor,
      'icon': AppImages.floor,
    },
    {
      'id': 'TOWNHOUSE',
      'label': AppStrings.propertyTypeTownhouse,
      'icon': AppImages.townhouse,
    },
    {
      'id': 'BUILDING',
      'label': AppStrings.propertyTypeBuilding,
      'icon': AppImages.building,
    },
    {
      'id': 'LAND',
      'label': AppStrings.propertyTypeLand,
      'icon': AppImages.land,
    },
    {
      'id': 'RESTHOUSE',
      'label': AppStrings.propertyTypeRestHouse,
      'icon': AppImages.restHouse,
    },
    {
      'id': 'TOWER',
      'label': AppStrings.propertyTypeTower,
      'icon': AppImages.tower,
    },
    {
      'id': 'SHOP',
      'label': AppStrings.propertyTypeShop,
      'icon': AppImages.shop,
    },
    {
      'id': 'OFFICE',
      'label': AppStrings.propertyTypeOffice,
      'icon': AppImages.office,
    },
    {
      'id': 'FARM',
      'label': AppStrings.propertyTypeFarm,
      'icon': AppImages.farm,
    },
    {
      'id': 'WAREHOUSE',
      'label': AppStrings.propertyTypeWarehouse,
      'icon': AppImages.warehouse,
    },
  ];

  static List<Map<String, String>> get deedTypes => [
    {
      'id': 'electronic',
      'label': AppStrings.deedElectronic,
      'hint':
          'هي وثيقة تملك عقار إلكترونية تصدرها وزارة العدل ولا تشمل الصكوك الورقية.',
      'icon': AppImages.electronic,
    },
    {
      'id': 'regular',
      'label': AppStrings.deedRegular,
      'hint':
          'وثيقة تملك عقار صادرة من السجل العقاري لإثبات بيانات العقار تتضمن نوعه وحالته وبيانات مالكه.',
      'icon': AppImages.commerical,
    },
    {
      'id': 'old',
      'label': AppStrings.deedOld,
      'hint':
          'في حال شراء العقار من البنك، يتم إبرام عقد البيع ويتم تسليمه للمستفيد.',
      'icon': AppImages.sell,
    },
    {
      'id': 'other',
      'label': AppStrings.deedOther,
      'hint':
          'خيار يتيح لك إضافة أي وثيقة ملكية أخرى مثل صك ورقي، عقد إيجار (تاجر من الباطن).',
      'icon': AppImages.other,
    },
  ];
  // Option lists hold API wire values; widgets render them through `.trans`
  // so labels stay localized while the stored value stays submittable.

  static const List<String> facadeOptions = PropertyApiEnums.facadeByIndex;

  static const List<String> classificationOptions = [
    PropertyApiEnums.classificationResidential,
    PropertyApiEnums.classificationCommercial,
    PropertyApiEnums.classificationMixed,
  ];

  static const List<String> towerClassificationOptions = [
    PropertyApiEnums.classificationResidential,
    PropertyApiEnums.classificationCommercial,
    PropertyApiEnums.towerClassificationOffice,
    PropertyApiEnums.towerClassificationMixedUse,
    PropertyApiEnums.towerClassificationHotel,
  ];

  static const List<String> viewOptions = [
    PropertyApiEnums.viewPanoramic,
    PropertyApiEnums.viewSea,
    PropertyApiEnums.viewCity,
    PropertyApiEnums.viewMountain,
    PropertyApiEnums.viewGarden,
  ];

  /// Townhouse community facilities.
  static const List<String> communityFacilityOptions = [
    PropertyApiEnums.communityPool,
    PropertyApiEnums.communityGym,
    PropertyApiEnums.communityGarden,
    PropertyApiEnums.communitySecurity,
    PropertyApiEnums.communityPlayground,
  ];

  static const List<String> towerAmenityOptions = [
    PropertyApiEnums.towerAmenityPool,
    PropertyApiEnums.towerAmenityGym,
    PropertyApiEnums.towerAmenitySauna,
    PropertyApiEnums.towerAmenityEventHall,
    PropertyApiEnums.towerAmenityLobby,
    PropertyApiEnums.towerAmenitySecurity247,
    PropertyApiEnums.towerAmenityHeliport,
  ];

  static const List<String> officeFacilityOptions = [
    PropertyApiEnums.facilityAc,
    PropertyApiEnums.facilityStorage,
    PropertyApiEnums.facilityBathroom,
    PropertyApiEnums.facilityPrivateParking,
    PropertyApiEnums.facilityElevator,
  ];

  static const List<String> shopFacilityOptions = officeFacilityOptions;

  static const List<String> shopActivityOptions = [
    PropertyApiEnums.activityElectronics,
    PropertyApiEnums.activityClothing,
    PropertyApiEnums.activityCafe,
    PropertyApiEnums.activityRestaurant,
    PropertyApiEnums.activitySalon,
    PropertyApiEnums.activitySupermarket,
  ];

  static const List<String> landServiceOptions = [
    PropertyApiEnums.landServiceElectricity,
    PropertyApiEnums.landServiceWater,
    PropertyApiEnums.landServiceRoad,
    PropertyApiEnums.landServiceLighting,
    PropertyApiEnums.landServiceSewage,
  ];

  static const List<String> waterSourceOptions = [
    PropertyApiEnums.waterSourceWell,
    PropertyApiEnums.waterSourceNetwork,
  ];

  static const List<String> farmFacilityOptions = [
    PropertyApiEnums.farmFacilityRestHouse,
    PropertyApiEnums.farmFacilityFence,
    PropertyApiEnums.farmFacilityLivestockSheds,
    PropertyApiEnums.farmFacilityElectricity,
  ];

  /// Slot of the floor within its building, used by `type: FLOOR`.
  static const List<String> floorTypeOptions = [
    PropertyApiEnums.floorTypeGround,
    PropertyApiEnums.floorTypeUpper,
  ];
  static const List<String> shopLocationOptions = [
    PropertyApiEnums.shopLocationMainStreet,
    PropertyApiEnums.shopLocationSideStreet,
    PropertyApiEnums.shopLocationMall,
    PropertyApiEnums.shopLocationCommercialComplex,
  ];

  static const List<String> coolingOptions = [
    PropertyApiEnums.coolingNone,
    PropertyApiEnums.coolingChilled,
    PropertyApiEnums.coolingFrozen,
    PropertyApiEnums.coolingAirConditioned,
  ];

  static const List<String> flooringOptions = [
    PropertyApiEnums.flooringConcrete,
    PropertyApiEnums.flooringEpoxy,
    PropertyApiEnums.flooringIndustrialTiles,
  ];

  static const List<String> doorTypeOptions = [
    PropertyApiEnums.doorTypeNormal,
    PropertyApiEnums.doorTypeRoller,
    PropertyApiEnums.doorTypeLoadingDock,
  ];

  static const List<String> conditionOptions = [
    PropertyApiEnums.conditionNew,
    PropertyApiEnums.conditionUsed,
  ];

  static const List<String> soilTypeOptions = [
    PropertyApiEnums.soilClay,
    PropertyApiEnums.soilSandy,
    PropertyApiEnums.soilMixed,
  ];

  /// Numeric pickers submit plain integers, so their label is the value itself
  /// and must not be translated.
  static List<String> numberOptions(int max, {int min = 0}) =>
      List.generate(max - min + 1, (i) => '${min + i}');

  static List<String> get floorNumberOptions => numberOptions(50);
  static List<String> get floorsCountOptions => numberOptions(100, min: 1);
  static List<String> get unitCountOptions => numberOptions(200);
  static List<String> get parkingFloorOptions => numberOptions(15);


  @override
  Future<void> close() {
    disposeControllers();
    return super.close();
  }
}
