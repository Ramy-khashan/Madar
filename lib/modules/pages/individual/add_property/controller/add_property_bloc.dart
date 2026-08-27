import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/repository/apis/create_property_apis.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/guest_mode.dart';
import '../../../../../core/utils/functions/hijri_date.dart';
import '../../../../../core/utils/functions/print_state.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../../../business/business_home/model/business_portfolio_property_model.dart';
import '../model/add_property_model.dart';
import '../model/add_property_request_mapper.dart';
import '../model/add_property_validator.dart';
import '../model/property_enums.dart';

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
    on<SelectPortfolioModeEvent>(_onSelectPortfolioMode);
    on<ConfirmSaveEvent>(_onConfirmSave);
    on<SendToBrokerEvent>(_onSendToBroker);
    on<LoadParentCandidatesEvent>(_onLoadParentCandidates);
    on<SelectParentPropertyEvent>(_onSelectParentProperty);
    on<ClearParentPropertyEvent>(_onClearParentProperty);
  }

  // ── TextEditingControllers ───────────────────────────────────────────────

  final TextEditingController buildingNumberController =
      TextEditingController();
  final TextEditingController streetWidthController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController deedNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? deedPickedAt;
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

  // ── Navigation handlers ──────────────────────────────────────────────────

  void _onNext(NextStepEvent event, Emitter<AddPropertyState> emit) {
    final model = _modelWithControllerValues();
    final errors = _errorsForStep(state.step, model);
    if (errors.isNotEmpty) {
      emit(
        state.copyWith(
          model: model,
          fieldErrors: errors,
          errorMessage: errors.values.first,
        ),
      );
      return;
    }
    final next = _nextStep(state.step, model.operationType);
    if (next != null) {
      emit(
        state.copyWith(
          model: model,
          step: next,
          fieldErrors: const {},
          errorMessage: null,
        ),
      );
      if (next == AddPropertyStep.review) {
        add(const PreviewEvaluationEvent());
        if (model.propertyType == PropertyApiEnums.typeApartment) {
          add(const LoadParentCandidatesEvent());
        }
      }
    }
  }

  Map<String, String> _errorsForStep(
    AddPropertyStep step,
    AddPropertyModel model,
  ) {
    switch (step) {
      case AddPropertyStep.type:
        return AddPropertyValidator.validateType(model);
      case AddPropertyStep.period:
        return AddPropertyValidator.validatePeriod(model);
      case AddPropertyStep.location:
        return AddPropertyValidator.validateLocation(model);
      case AddPropertyStep.images:
        return AddPropertyValidator.validateImages(model);
      case AddPropertyStep.details:
        return AddPropertyValidator.validateDetails(model);
      case AddPropertyStep.review:
        return AddPropertyValidator.validateReview(model);
    }
  }

  AddPropertyStep _stepForField(String key) {
    switch (key) {
      case AddPropertyField.propertyType:
        return AddPropertyStep.type;
      case AddPropertyField.rentalPeriod:
        return AddPropertyStep.period;
      case AddPropertyField.location:
      case AddPropertyField.deedType:
      case AddPropertyField.deedNumber:
      case AddPropertyField.deedDate:
        return AddPropertyStep.location;
      case AddPropertyField.images:
        return AddPropertyStep.images;
      case AddPropertyField.price:
      case AddPropertyField.title:
        return AddPropertyStep.review;
      default:
        return AddPropertyStep.details;
    }
  }

  void _onPrevious(PreviousStepEvent event, Emitter<AddPropertyState> emit) {
    final prev = _previousStep(state.step, state.model.operationType);
    if (prev != null) {
      emit(
        state.copyWith(step: prev, fieldErrors: const {}, errorMessage: null),
      );
    }
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
      state.copyWith(
        model: state.model.copyWith(
          propertyType: event.typeId,
          clearPropertyParent: event.typeId != PropertyApiEnums.typeApartment,
        ),
        parentCandidates: event.typeId == PropertyApiEnums.typeApartment
            ? state.parentCandidates
            : const [],
      ),
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

  void _onUpdateCoordinates(
    UpdateCoordinatesEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(
          latitude: event.latitude,
          longitude: event.longitude,
          city: event.city,
          district: event.district,
        ),
      ),
    );
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
    if (deedPickedAt != null) {
      dateController.text = HijriDate.format(
        deedPickedAt!,
        hijri: event.dateType == 'hijri',
      );
    }
  }

  void _onDeedDatePicked(
    DeedDatePickedEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    deedPickedAt = event.date;
    dateController.text = HijriDate.format(
      event.date,
      hijri: state.model.dateType == 'hijri',
    );
  }

  // ── Step 4 handlers ──────────────────────────────────────────────────────

  void _onAddImage(AddImageEvent event, Emitter<AddPropertyState> emit) {
    final updated = List<String>.from(state.model.imagePaths)..add(event.path);
    emit(state.copyWith(model: state.model.copyWith(imagePaths: updated)));
  }

  void _onAddImages(AddImagesEvent event, Emitter<AddPropertyState> emit) {
    if (event.paths.isEmpty) return;
    final updated = List<String>.from(state.model.imagePaths)
      ..addAll(event.paths);
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

  void _onSetVideoPath(
    SetVideoPathEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(videoPath: event.path, hasVideo: true),
      ),
    );
  }

  void _onClearVideo(ClearVideoEvent event, Emitter<AddPropertyState> emit) {
    emit(
      state.copyWith(
        model: state.model.copyWith(hasVideo: false, clearVideoPath: true),
      ),
    );
  }

  void _onSetVirtualTourPath(
    SetVirtualTourPathEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(
          virtualTourPath: event.path,
          has360Tour: true,
        ),
      ),
    );
  }

  void _onClearVirtualTour(
    ClearVirtualTourEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(
          has360Tour: false,
          clearVirtualTourPath: true,
        ),
      ),
    );
  }

  void _onSetDeedDocument(
    SetDeedDocumentEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(ownershipDocumentPath: event.path),
      ),
    );
  }

  void _onClearDeedDocument(
    ClearDeedDocumentEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(clearOwnershipDocumentPath: true),
      ),
    );
  }

  Future<void> _onPreviewEvaluation(
    PreviewEvaluationEvent event,
    Emitter<AddPropertyState> emit,
  ) async {
    try {
      final model = _modelWithControllerValues();
      emit(
        state.copyWith(
          model: model,
          isPreviewLoading: true,
          hasMarketData: false,
        ),
      );

      final result = await CreatePropertyApis.previewEvaluation(model);

      result.fold(
        (_) => emit(
          state.copyWith(
            isPreviewLoading: false,
            hasMarketData: false,
            aiDescription: '',
          ),
        ),
        (preview) => emit(
          state.copyWith(
            isPreviewLoading: false,
            hasMarketData: preview.hasMarketData,
            suggestedMin: preview.suggestedMin,
            suggestedMax: preview.suggestedMax,
            aiDescription: preview.aiDescription,
          ),
        ),
      );
    } catch (e) {
       emit(
        state.copyWith(
          isPreviewLoading: false,
          hasMarketData: false,
          aiDescription: '',
        ),
      );
    }
  }

  void _onApplyAiDescription(
    ApplyAiDescriptionEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final text = state.aiDescription?.trim() ?? '';
    if (text.contains('404') || text.contains('error')) {
      return;
    }
    if (text.isEmpty) return;
    descriptionController.text = text;
    emit(state.copyWith(model: state.model.copyWith(description: text)));
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

  /// Per-type detail fields all funnel through one map, so these handlers stay
  /// type-agnostic.
  void _emitDetail(Emitter<AddPropertyState> emit, String key, dynamic value) {
    final updated = Map<String, dynamic>.from(state.model.typeDetails);
    if (value == null) {
      updated.remove(key);
    } else {
      updated[key] = value;
    }
    emit(state.copyWith(model: state.model.copyWith(typeDetails: updated)));
  }

  void _onSetDetailField(
    SetDetailFieldEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    _emitDetail(emit, event.key, event.value);
  }

  void _onToggleDetailListItem(
    ToggleDetailListItemEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final current = List<String>.from(state.model.detailList(event.key));
    if (current.contains(event.value)) {
      current.remove(event.value);
    } else {
      current.add(event.value);
    }
    _emitDetail(emit, event.key, current);
  }

  void _onIncrementDetailCounter(
    IncrementDetailCounterEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    _emitDetail(emit, event.key, state.model.detailCount(event.key) + 1);
  }

  void _onDecrementDetailCounter(
    DecrementDetailCounterEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    final current = state.model.detailCount(event.key);
    if (current <= 0) return;
    _emitDetail(emit, event.key, current - 1);
  }

  void _onToggleDetailFlag(
    ToggleDetailFlagEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    _emitDetail(emit, event.key, !state.model.detailFlag(event.key));
  }

  /// Lazily created controllers for free-text `details` fields, read back at
  /// submit time so typing doesn't rebuild the whole step.
  final Map<String, TextEditingController> _detailControllers = {};

  TextEditingController detailController(String key) =>
      _detailControllers.putIfAbsent(key, TextEditingController.new);

  /// Snapshot of every non-empty detail text field, keyed by API field name.
  Map<String, String> get detailControllerValues => {
    for (final entry in _detailControllers.entries)
      if (entry.value.text.trim().isNotEmpty)
        entry.key: entry.value.text.trim(),
  };

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
    final model = _modelWithControllerValues();
    final errors = _errorsForSubmit(model);
    if (errors.isNotEmpty) {
      final firstKey = errors.keys.first;
      emit(
        state.copyWith(
          model: model,
          fieldErrors: errors,
          errorMessage: errors.values.first,
          step: _stepForField(firstKey),
          showPortfolioSheet: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        model: model,
        fieldErrors: const {},
        errorMessage: null,
        showPortfolioSheet: true,
      ),
    );
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
    if (event.isNew) {
      add(const ClearParentPropertyEvent());
    } else {
      add(const LoadParentCandidatesEvent());
    }
  }

  /// Snapshots the free-text controllers into the model before submitting,
  /// since they are not mirrored into state on every keystroke.
  AddPropertyModel _modelWithControllerValues() {
    // Text values win over stale map entries from a previous edit of the field.
    final details = Map<String, dynamic>.from(state.model.typeDetails)
      ..addAll(detailControllerValues);

    return state.model.copyWith(
      typeDetails: details,
      buildingNumber: buildingNumberController.text.trim(),
      street: streetController.text.trim(),
      deedNumber: deedNumberController.text.trim(),
      date: dateController.text.trim(),
      area: areaController.text.trim(),
      streetWidth: streetWidthController.text.trim(),
      apartmentNumber: apartmentNumberController.text.trim(),
      developerName: developerNameController.text.trim(),
      price: priceController.text.trim(),
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      portfolioFolderName: portfolioNameController.text.trim(),
    );
  }

  Map<String, String> _errorsForSubmit(AddPropertyModel model) {
    return {
      ...AddPropertyValidator.validateType(model),
      if (model.operationType == 'rent')
        ...AddPropertyValidator.validatePeriod(model),
      ...AddPropertyValidator.validateLocation(model),
      ...AddPropertyValidator.validateImages(model),
      ...AddPropertyValidator.validateDetails(model),
      ...AddPropertyValidator.validateReview(model),
    };
  }

  Future<void> _onConfirmSave(
    ConfirmSaveEvent event,
    Emitter<AddPropertyState> emit,
  ) async {
    var model = _modelWithControllerValues();
    if (state.isNewFolder) {
      model = model.copyWith(clearPropertyParent: true);
    }
    final errors = _errorsForSubmit(model);

    if (errors.isNotEmpty) {
      final firstKey = errors.keys.first;
      emit(
        state.copyWith(
          model: model,
          fieldErrors: errors,
          errorMessage: errors.values.first,
          step: _stepForField(firstKey),
          showPortfolioSheet: false,
          isLoading: false,
          openChooseBrokerOnSuccess: false,
        ),
      );
      return;
    }

    final request = model.toCreateRequest(
      brokerId: event.brokerId,
      adLicenseNumber: event.adLicenseNumber,
    );

    if (request == null) {
      emit(
        state.copyWith(
          model: model,
          showPortfolioSheet: false,
          submitStatus: SubmitStatus.failure,
          errorMessage: AppStrings.somethingWentWrong,
          openChooseBrokerOnSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        model: model,
        showPortfolioSheet: false,
        submitStatus: SubmitStatus.loading,
        isLoading: true,
        fieldErrors: const {},
        errorMessage: null,
        openChooseBrokerOnSuccess: event.openChooseBrokerOnSuccess,
      ),
    );

    final result = await CreatePropertyApis.createProperty(request);

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          submitStatus: SubmitStatus.failure,
          errorMessage: failure,
          openChooseBrokerOnSuccess: false,
        ),
      ),
      (data) => emit(
        state.copyWith(
          isLoading: false,
          submitStatus: SubmitStatus.success,
          createdPropertyId: _extractCreatedPropertyId(data),
          openChooseBrokerOnSuccess: event.openChooseBrokerOnSuccess,
        ),
      ),
    );
  }

  void _onSendToBroker(
    SendToBrokerEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    add(ConfirmSaveEvent(brokerId: event.brokerId));
  }

  Future<void> _onLoadParentCandidates(
    LoadParentCandidatesEvent event,
    Emitter<AddPropertyState> emit,
  ) async {
    if (GuestMode.isGuest) {
      emit(
        state.copyWith(
          parentCandidates: const [],
          parentCandidatesStatus: RequestStatus.success,
        ),
      );
      return;
    }
    emit(state.copyWith(parentCandidatesStatus: RequestStatus.loading));
    try {
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.portfolio,
        queryParameters: const {'page': 1, 'limit': 50},
      );
      await response.fold(
        (failed) async {
          emit(
            state.copyWith(
              parentCandidates: const [],
              parentCandidatesStatus: RequestStatus.failed,
            ),
          );
        },
        (success) async {
          final items = _parentCandidatesFrom(success.response);
          emit(
            state.copyWith(
              parentCandidates: items,
              parentCandidatesStatus: RequestStatus.success,
            ),
          );
        },
      );
    } catch (e) {
      printState('load parent candidates: $e');
      emit(
        state.copyWith(
          parentCandidates: const [],
          parentCandidatesStatus: RequestStatus.failed,
        ),
      );
    }
  }

  List<MyPropertiesModel> _parentCandidatesFrom(dynamic body) {
    if (body is! Map) return const [];
    final map = Map<String, dynamic>.from(body);
    dynamic raw = map['data'] ?? map['properties'] ?? map['items'] ?? [];
    if (raw is Map) {
      raw = raw['data'] ?? raw['items'] ?? raw['list'] ?? [];
    }
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((e) => MyPropertiesModel.fromJson(Map<String, dynamic>.from(e)))
        .where((e) => e.id.isNotEmpty && e.isBuildingOrTower)
        .toList();
  }

  void _onSelectParentProperty(
    SelectParentPropertyEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(
        model: state.model.copyWith(
          propertyParentId: event.id,
          propertyParentTitle: event.title,
        ),
      ),
    );
  }

  void _onClearParentProperty(
    ClearParentPropertyEvent event,
    Emitter<AddPropertyState> emit,
  ) {
    emit(
      state.copyWith(model: state.model.copyWith(clearPropertyParent: true)),
    );
  }

  String? _extractCreatedPropertyId(dynamic data) {
    if (data is! Map) return null;
    final id =
        data['property_id'] ?? data['propertyId'] ?? data['id'] ?? data['_id'];
    if (id != null) return id.toString();
    final nested = data['property'];
    if (nested is Map) {
      final nestedId =
          nested['property_id'] ?? nested['propertyId'] ?? nested['id'];
      if (nestedId != null) return nestedId.toString();
    }
    return null;
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
    for (final controller in _detailControllers.values) {
      controller.dispose();
    }
    return super.close();
  }
}
