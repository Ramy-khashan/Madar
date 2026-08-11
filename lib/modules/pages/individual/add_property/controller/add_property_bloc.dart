import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../model/add_property_model.dart';

part 'add_property_event.dart';
part 'add_property_state.dart';

class AddPropertyBloc extends Bloc<AddPropertyEvent, AddPropertyState> {
  AddPropertyBloc() : super(const AddPropertyState()) {
    on<NextStepEvent>(_onNext);
    on<PreviousStepEvent>(_onPrevious);
    on<SelectOperationTypeEvent>(_onSelectOperationType);
    on<SelectPropertyTypeEvent>(_onSelectPropertyType);
    on<SelectRentalPeriodEvent>(_onSelectRentalPeriod);
    on<UpdateLocationEvent>(_onUpdateLocation);
    on<SelectDeedTypeEvent>(_onSelectDeedType);
    on<SelectDateTypeEvent>(_onSelectDateType);
    on<AddImageEvent>(_onAddImage);
    on<RemoveImageEvent>(_onRemoveImage);
    on<ToggleAiEnhancementEvent>(_onToggleAiEnhancement);
    on<ToggleVideoEvent>(_onToggleVideo);
    on<Toggle360TourEvent>(_onToggle360Tour);
    on<SelectFacadeEvent>(_onSelectFacade);
    on<IncrementStreetCountEvent>(_onIncrementStreetCount);
    on<DecrementStreetCountEvent>(_onDecrementStreetCount);
    on<SelectStreetWidthEvent>(_onSelectStreetWidth);
    on<SelectPropertyAgeEvent>(_onSelectPropertyAge);
    on<IncrementCounterEvent>(_onIncrementCounter);
    on<DecrementCounterEvent>(_onDecrementCounter);
    on<SelectDropdownEvent>(_onSelectDropdown);
    on<ToggleAmenityEvent>(_onToggleAmenity);
    on<ToggleRentInstallmentEvent>(_onToggleRentInstallment);
    on<ToggleInsuranceEvent>(_onToggleInsurance);
    on<ShowPortfolioSheetEvent>(_onShowPortfolioSheet);
    on<HidePortfolioSheetEvent>(_onHidePortfolioSheet);
    on<SelectPortfolioModeEvent>(_onSelectPortfolioMode);
    on<ConfirmSaveEvent>(_onConfirmSave);
    on<SendToBrokerEvent>(_onSendToBroker);
  }

  // ── TextEditingControllers ───────────────────────────────────────────────

  final TextEditingController buildingNumberController =
      TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController deedNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController apartmentNumberController =
      TextEditingController();
  final TextEditingController developerNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController portfolioNameController = TextEditingController();
  final TextEditingController locationSearchController =
      TextEditingController();

  // ── Static data ──────────────────────────────────────────────────────────

  static AddPropertyBloc get(BuildContext context) =>
      context.read<AddPropertyBloc>();

  static List<Map<String, dynamic>> get propertyTypeItems => [
    {'id': 'apartment', 'label': AppStrings.propertyTypeApartment, 'icon': AppImages.apartment},
    {'id': 'villa', 'label': AppStrings.propertyTypeVilla, 'icon': AppImages.villa},
    {'id': 'floor', 'label': AppStrings.propertyTypeFloor, 'icon': AppImages.floor},
    {'id': 'townhouse', 'label': AppStrings.propertyTypeTownhouse, 'icon': AppImages.townhouse},
    {'id': 'building', 'label': AppStrings.propertyTypeBuilding, 'icon': AppImages.building},
    {'id': 'land', 'label': AppStrings.propertyTypeLand, 'icon': AppImages.land},
    {'id': 'rest_house', 'label': AppStrings.propertyTypeRestHouse, 'icon': AppImages.restHouse},
    {'id': 'tower', 'label': AppStrings.propertyTypeTower, 'icon': AppImages.tower},
    {'id': 'shop', 'label': AppStrings.propertyTypeShop, 'icon': AppImages.shop},
    {'id': 'office', 'label': AppStrings.propertyTypeOffice, 'icon': AppImages.office},
    {'id': 'farm', 'label': AppStrings.propertyTypeFarm, 'icon': AppImages.farm},
    {'id': 'warehouse', 'label': AppStrings.propertyTypeWarehouse, 'icon': AppImages.warehouse},
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
          "وثيقة تملك عقار صادرة من السجل العقاري لإثبات بيانات العقار تتضمن نوعه وحالته وبيانات مالكه.",
      'icon': AppImages.commerical,
    },
    {
      'id': 'old',
      'label': AppStrings.deedOld,
      'hint':
          "في حال شراء العقار من البنك، يتم إبرام عقد البيع ويتم تسليمه للمستفيد.",
      'icon': AppImages.sell,
    },
    {
      'id': 'other',
      'label': AppStrings.deedOther,
      'hint':
          "خيار يتيح لك إضافة أي وثيقة ملكية أخرى مثل صك ورقي، عقد إيجار (تاجر من الباطن).",
      'icon': AppImages.other,
    },
  ];
  static List<String> get facadeOptions => [
    AppStrings.facadeNorth,
    AppStrings.facadeSouth,
    AppStrings.facadeEast,
    AppStrings.facadeWest,
    AppStrings.facadeNortheast,
    AppStrings.facadeNorthwest,
    AppStrings.facadeSoutheast,
    AppStrings.facadeSouthwest,
  ];
  static List<String> get landClassificationOptions => [
    AppStrings.landClassificationResidential,
    AppStrings.landClassificationCommercial,
    AppStrings.landClassificationIndustrial,
    AppStrings.landClassificationAgricultural,
  ];
  static List<String> get viewOptions => [
    AppStrings.viewPanoramic,
    AppStrings.viewRegular,
    AppStrings.viewDouble,
    AppStrings.viewDoublePanoramic,
  ];
  static const List<String> streetWidthOptions = [
    '10 م',
    '12 م',
    '15 م',
    '20 م',
    '25 م',
  ];

  static List<String> get propertyAgeOptions => [
    AppStrings.propertyAgeNew,
    AppStrings.propertyAgeLess5,
    AppStrings.propertyAge5To10,
    AppStrings.propertyAgeMore10,
  ];
  static List<String> get amenityOptions => [
    AppStrings.amenitySharedPool,
    AppStrings.amenityClub,
    AppStrings.amenityGarden,
    AppStrings.amenitySecurity,
  ];
  static List<String> get communityAmenityOptions => [
    AppStrings.communityAmenityEventHall,
    AppStrings.communityAmenitySauna,
    AppStrings.communityAmenityGym,
    AppStrings.communityAmenityPool,
    AppStrings.communityAmenityHeliport,
    AppStrings.communityAmenityGuard,
    AppStrings.communityAmenityLobby,
  ];
  static List<String> get interiorAmenityOptions => [
    AppStrings.interiorAmenityMeetingRoom,
    AppStrings.interiorAmenityReception,
    AppStrings.interiorAmenityKitchen,
    AppStrings.interiorAmenityAc,
    AppStrings.interiorAmenityElevator,
    AppStrings.interiorAmenityParking,
  ];
  static List<String> get floorOptions => [
    AppStrings.floorGround,
    AppStrings.floorFirst,
    AppStrings.floorSecond,
    AppStrings.floorThird,
    AppStrings.floorFourth,
    AppStrings.floorFifth,
    AppStrings.floorSixth,
    AppStrings.floorSeventh,
    AppStrings.floorEighth,
    AppStrings.floorNinth,
    AppStrings.floorTenth,
  ];

  static List<String> get furnishingOptions => [AppStrings.furnishingFurnished, AppStrings.furnishingUnfurnished];
  static List<String> get locationOptions => [
    AppStrings.locationMainStreet,
    AppStrings.locationSecondaryStreet,
    AppStrings.locationResidentialComplex,
    AppStrings.locationCommercialComplex
  ];
  static List<String> get coolingOptions => [AppStrings.coolingTypeCooling, AppStrings.coolingTypeFreezing, AppStrings.coolingTypeBoth];
  static List<String> get floorTypeOptions => [AppStrings.flooringConcrete, AppStrings.flooringWooden, AppStrings.flooringMarble, AppStrings.flooringCeramic, AppStrings.flooringCement];
  static List<String> get doorTypeOptions => [AppStrings.doorTypeRegular, AppStrings.doorTypeSecondary, AppStrings.doorTypeDouble];
  static List<String> get conditionOptions => [
    AppStrings.conditionExcellent,
    AppStrings.conditionVeryGood,
    AppStrings.conditionGood,
    AppStrings.conditionFair,
    AppStrings.conditionNeedsRenovation,
  ];
  static List<String> get soilTypeOptions => [AppStrings.soilTypeClay, AppStrings.soilTypeSandy, AppStrings.soilTypeRocky, AppStrings.soilTypeGravelly, AppStrings.soilTypeClaysSandy, AppStrings.soilTypeClayRocky];
  static const List<String> availabilityOptions = ['يوجد', 'لا يوجد'];
  static const List<String> apartmentFloorOptions = [
    '10-1',
    '20-11',
    '30-21',
    '40-31',
    '50-41',
    '60-51',
    '70-61',
  ];
  static const List<String> parkingFloorOptions = ["0-5", "6-10", "11-15"];

  static List<Map<String, dynamic>> get amenityCategories => [
    {
      'title': AppStrings.featureCategoryBasicServices,
      'items': [
        {'id': 'internet', 'label': AppStrings.featureInternet},
        {'id': 'sewage', 'label': AppStrings.featureSewage},
        {'id': 'water', 'label': AppStrings.featureWater},
        {'id': 'electricity', 'label': AppStrings.featureElectricity},
      ],
    },
    {
      'title': AppStrings.featureCategoryInterior,
      'items': [
        {'id': 'driver_room', 'label': AppStrings.featureDriverRoom},
        {'id': 'maid_room', 'label': AppStrings.featureMaidRoom},
        {'id': 'elevator', 'label': AppStrings.featureElevator},
        {'id': 'central_ac', 'label': AppStrings.featureCentralAc},
        {'id': 'basement', 'label': AppStrings.featureBasement},
        {'id': 'roof', 'label': AppStrings.featureRoof},
        {'id': 'storage', 'label': AppStrings.featureWarehouse},
      ],
    },

    {
      'title': AppStrings.featureCategoryExteriorSecurity,
      'items': [
        {'id': 'car_shelter', 'label': AppStrings.exteriorFeatureCarShelter},
        {'id': 'garden', 'label': AppStrings.featureGarden},
        {'id': 'swimming_pool', 'label': AppStrings.featurePool},
        {'id': 'security_guard', 'label': AppStrings.featureGuard},
        {'id': 'security_and_complexes', 'label': AppStrings.exteriorFeatureSecurityComplexes},
        {'id': 'water_well', 'label': AppStrings.featureWaterWell},
        {'id': 'health_club', 'label': AppStrings.featureHealthClub},
        {'id': 'electronic_gate', 'label': AppStrings.featureElectronicGate},
        {'id': 'surveillance_cameras', 'label': AppStrings.featureCctv},
      ],
    },
  ];

  // ── Navigation handlers ──────────────────────────────────────────────────

  void _onNext(NextStepEvent event, Emitter<AddPropertyState> emit) {
    final next = _nextStep(state.step, state.model.operationType);
    if (next != null) emit(state.copyWith(step: next));
  }

  void _onPrevious(PreviousStepEvent event, Emitter<AddPropertyState> emit) {
    final prev = _previousStep(state.step, state.model.operationType);
    if (prev != null) emit(state.copyWith(step: prev));
  }

  AddPropertyStep? _nextStep(AddPropertyStep current, String operationType) {
    switch (current) {
      case AddPropertyStep.type:
        return operationType == 'rent'
            ? AddPropertyStep.period
            : AddPropertyStep.location;
      case AddPropertyStep.period:
        return AddPropertyStep.location;
      case AddPropertyStep.location:
        return AddPropertyStep.images;
      case AddPropertyStep.images:
        return AddPropertyStep.details;
      case AddPropertyStep.details:
        return AddPropertyStep.review;
      case AddPropertyStep.review:
        return null;
    }
  }

  AddPropertyStep? _previousStep(
    AddPropertyStep current,
    String operationType,
  ) {
    switch (current) {
      case AddPropertyStep.type:
        return null;
      case AddPropertyStep.period:
        return AddPropertyStep.type;
      case AddPropertyStep.location:
        return operationType == 'rent'
            ? AddPropertyStep.period
            : AddPropertyStep.type;
      case AddPropertyStep.images:
        return AddPropertyStep.location;
      case AddPropertyStep.details:
        return AddPropertyStep.images;
      case AddPropertyStep.review:
        return AddPropertyStep.details;
    }
  }

  // ── Step 1 handlers ──────────────────────────────────────────────────────

  void _onSelectOperationType(
    SelectOperationTypeEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(model: state.model.copyWith(operationType: event.type)),
    );
  }

  void _onSelectPropertyType(
    SelectPropertyTypeEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(model: state.model.copyWith(propertyType: event.typeId)),
    );
  }

  // ── Step 2 handlers ──────────────────────────────────────────────────────

  void _onSelectRentalPeriod(
    SelectRentalPeriodEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(model: state.model.copyWith(rentalPeriod: event.period)),
    );
  }

  // ── Step 3 handlers ──────────────────────────────────────────────────────

  void _onUpdateLocation(
    UpdateLocationEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(model: state.model.copyWith(location: event.location)));
  }

  void _onSelectDeedType(
    SelectDeedTypeEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(model: state.model.copyWith(deedType: event.deedType)));
  }

  void _onSelectDateType(
    SelectDateTypeEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(model: state.model.copyWith(dateType: event.dateType)));
  }

  // ── Step 4 handlers ──────────────────────────────────────────────────────

  void _onAddImage(AddImageEvent event, Emitter<AddPropertyState> emit) {
    final updated = List<String>.from(state.model.imagePaths)..add(event.path);
    emit(state.copyWith(model: state.model.copyWith(imagePaths: updated)));
  }

  void _onRemoveImage(RemoveImageEvent event, Emitter<AddPropertyState> emit) {
    final updated = List<String>.from(state.model.imagePaths)
      ..removeAt(event.index);
    emit(state.copyWith(model: state.model.copyWith(imagePaths: updated)));
  }

  void _onToggleAiEnhancement(
    ToggleAiEnhancementEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(aiEnhancement: !state.model.aiEnhancement),
      ),
    );
  }

  void _onToggleVideo(ToggleVideoEvent event, Emitter<AddPropertyState> emit) {
    emit(
      state.copyWith(
        model: state.model.copyWith(hasVideo: !state.model.hasVideo),
      ),
    );
  }

  void _onToggle360Tour(
    Toggle360TourEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(has360Tour: !state.model.has360Tour),
      ),
    );
  }

  // ── Step 5 handlers ──────────────────────────────────────────────────────

  void _onSelectFacade(
    SelectFacadeEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(model: state.model.copyWith(facade: event.facade)));
  }

  void _onIncrementStreetCount(
    IncrementStreetCountEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(streetCount: state.model.streetCount + 1),
      ),
    );
  }

  void _onDecrementStreetCount(
    DecrementStreetCountEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    if (state.model.streetCount <= 1) return;
    emit(
      state.copyWith(
        model: state.model.copyWith(streetCount: state.model.streetCount - 1),
      ),
    );
  }

  void _onSelectStreetWidth(
    SelectStreetWidthEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(model: state.model.copyWith(streetWidth: event.width)));
  }

  void _onSelectPropertyAge(
    SelectPropertyAgeEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(model: state.model.copyWith(propertyAge: event.age)));
  }

  void _onIncrementCounter(
    IncrementCounterEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final m = state.model;
    emit(
      state.copyWith(
        model: switch (event.field) {
          'beds' => m.copyWith(beds: m.beds + 1),
          'baths' => m.copyWith(baths: m.baths + 1),
          'lounges' => m.copyWith(lounges: m.lounges + 1),
          'majlis' => m.copyWith(majlis: m.majlis + 1),
          _ => m,
        },
      ),
    );
  }

  void _onDecrementCounter(
    DecrementCounterEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final m = state.model;
    emit(
      state.copyWith(
        model: switch (event.field) {
          'beds' => m.beds > 0 ? m.copyWith(beds: m.beds - 1) : m,
          'baths' => m.baths > 0 ? m.copyWith(baths: m.baths - 1) : m,
          'lounges' => m.lounges > 0 ? m.copyWith(lounges: m.lounges - 1) : m,
          'majlis' => m.majlis > 0 ? m.copyWith(majlis: m.majlis - 1) : m,
          _ => m,
        },
      ),
    );
  }

  void _onSelectDropdown(
    SelectDropdownEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final m = state.model;
    emit(
      state.copyWith(
        model: switch (event.field) {
          'totalFloors' => m.copyWith(totalFloors: event.value),
          'apartmentsPerFloor' => m.copyWith(apartmentsPerFloor: event.value),
          'floorLevel' => m.copyWith(floorLevel: event.value),
          'furnishing' => m.copyWith(furnishing: event.value),
          'condition' => m.copyWith(condition: event.value),
          _ => m,
        },
      ),
    );
  }

  void _onToggleAmenity(
    ToggleAmenityEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final updated = Set<String>.from(state.model.amenities);
    if (updated.contains(event.amenityId)) {
      updated.remove(event.amenityId);
    } else {
      updated.add(event.amenityId);
    }
    emit(state.copyWith(model: state.model.copyWith(amenities: updated)));
  }

  // ── Step 6 handlers ──────────────────────────────────────────────────────

  void _onToggleRentInstallment(
    ToggleRentInstallmentEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(
          hasRentInstallment: !state.model.hasRentInstallment,
        ),
      ),
    );
  }

  void _onToggleInsurance(
    ToggleInsuranceEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(hasInsurance: !state.model.hasInsurance),
      ),
    );
  }

  void _onShowPortfolioSheet(
    ShowPortfolioSheetEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(showPortfolioSheet: true));
  }

  void _onHidePortfolioSheet(
    HidePortfolioSheetEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(showPortfolioSheet: false));
  }

  void _onSelectPortfolioMode(
    SelectPortfolioModeEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(state.copyWith(isNewFolder: event.isNew));
  }

  void _onConfirmSave(ConfirmSaveEvent event, Emitter<AddPropertyState> emit) {
    // TODO: integrate with API
    emit(state.copyWith(showPortfolioSheet: false));
  }

  void _onSendToBroker(
    SendToBrokerEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    // TODO: integrate with API
  }

  @override
  Future<void> close() {
    buildingNumberController.dispose();
    streetController.dispose();
    deedNumberController.dispose();
    dateController.dispose();
    areaController.dispose();
    apartmentNumberController.dispose();
    developerNameController.dispose();
    priceController.dispose();
    titleController.dispose();
    portfolioNameController.dispose();
    locationSearchController.dispose();
    return super.close();
  }
}
