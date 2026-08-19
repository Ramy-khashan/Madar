/// API enum values for the `POST /properties` endpoint.
///
/// The UI stores localized labels, so every group exposes a `fromLabel` style
/// resolver that maps an index or label back to the wire value the backend
/// expects. Keep these in sync with the backend contract.
class PropertyApiEnums {
  PropertyApiEnums._();

  // ── Property type ──────────────────────────────────────────────────────
  static const String typeApartment = 'APARTMENT';
  static const String typeVilla = 'VILLA';
  static const String typeFloor = 'FLOOR';
  static const String typeTownhouse = 'TOWNHOUSE';
  static const String typeBuilding = 'BUILDING';
  static const String typeLand = 'LAND';
  static const String typeRestHouse = 'RESTHOUSE';
  static const String typeTower = 'TOWER';
  static const String typeShop = 'SHOP';
  static const String typeOffice = 'OFFICE';
  static const String typeFarm = 'FARM';
  static const String typeWarehouse = 'WAREHOUSE';
  static const String typeVillaFloor = 'VILLA_FLOOR';

  static const List<String> allTypes = [
    typeApartment,
    typeVilla,
    typeFloor,
    typeTownhouse,
    typeBuilding,
    typeLand,
    typeRestHouse,
    typeTower,
    typeShop,
    typeOffice,
    typeFarm,
    typeWarehouse,
  ];

  // ── Listing type ───────────────────────────────────────────────────────
  static const String listingSale = 'SALE';
  static const String listingRent = 'RENT';

  /// Maps the UI operation toggle (`sell` / `rent`) to the API listing type.
  static String listingTypeFromOperation(String operationType) =>
      operationType == 'rent' ? listingRent : listingSale;

  // ── Rent period ────────────────────────────────────────────────────────
  static const String rentMonthly = 'MONTHLY';
  static const String rentHalfYearly = 'HALF_YEARLY';
  static const String rentYearly = 'YEARLY';

  /// Maps the UI rental period (`monthly` / `semi_annual` / `annual`).
  static String rentPeriodFromUi(String rentalPeriod) {
    switch (rentalPeriod) {
      case 'monthly':
        return rentMonthly;
      case 'semi_annual':
        return rentHalfYearly;
      case 'annual':
      default:
        return rentYearly;
    }
  }

  // ── Payment type ───────────────────────────────────────────────────────
  static const String paymentCash = 'CASH';
  static const String paymentInstallment = 'INSTALLMENT';

  // ── Calendar type ──────────────────────────────────────────────────────
  static const String calendarGregorian = 'GREGORIAN';
  static const String calendarHijri = 'HIJRI';

  /// Maps the UI date toggle (`gregorian` / `hijri`).
  static String calendarTypeFromUi(String dateType) =>
      dateType == 'hijri' ? calendarHijri : calendarGregorian;

  // ── Deed type ──────────────────────────────────────────────────────────
  static const String deedElectronic = 'ELECTRONIC_DEED';
  static const String deedRealEstateDeed = 'REAL_ESTATE_DEED';
  static const String deedSaleContract = 'SALE_CONTRACT';
  static const String deedOther = 'OTHER';

  /// Maps the UI deed option ids used in `AddPropertyBloc.deedTypes`.
  static String deedTypeFromUi(String? deedTypeId) {
    switch (deedTypeId) {
      case 'electronic':
        return deedElectronic;
      case 'regular':
        return deedRealEstateDeed;
      case 'old':
        return deedSaleContract;
      case 'other':
      default:
        return deedOther;
    }
  }

  // ── Facade direction ───────────────────────────────────────────────────
  static const String facadeNorth = 'NORTH';
  static const String facadeSouth = 'SOUTH';
  static const String facadeEast = 'EAST';
  static const String facadeWest = 'WEST';
  static const String facadeNorthEast = 'NORTH_EAST';
  static const String facadeNorthWest = 'NORTH_WEST';
  static const String facadeSouthEast = 'SOUTH_EAST';
  static const String facadeSouthWest = 'SOUTH_WEST';

  /// Facade options are rendered in this fixed order, so resolve by index.
  static const List<String> facadeByIndex = [
    facadeNorth,
    facadeSouth,
    facadeEast,
    facadeWest,
    facadeNorthEast,
    facadeNorthWest,
    facadeSouthEast,
    facadeSouthWest,
  ];

  // ── Property age ───────────────────────────────────────────────────────
  static const String ageNew = 'NEW';
  static const String ageOneToFive = 'ONE_TO_FIVE';
  static const String ageFiveToTen = 'FIVE_TO_TEN';
  static const String ageTenPlus = 'TEN_PLUS';

  // ── Furnishing ─────────────────────────────────────────────────────────
  static const String furnished = 'FURNISHED';
  static const String unfurnished = 'UNFURNISHED';

  // ── Availability (yes/no radio groups) ─────────────────────────────────
  static const String availabilityExist = 'EXIST';
  static const String availabilityNotExist = 'NOT_EXIST';

  /// Maps an availability radio selection to the boolean the API expects.
  static bool? boolFromAvailability(String? value) {
    if (value == null || value.isEmpty) return null;
    return value == availabilityExist;
  }

  static String availabilityFromBool(bool value) =>
      value ? availabilityExist : availabilityNotExist;

  // ── Condition ──────────────────────────────────────────────────────────
  static const String conditionNew = 'NEW';
  static const String conditionUsed = 'USED';

  // ── Classification (building / land) ───────────────────────────────────
  static const String classificationResidential = 'RESIDENTIAL';
  static const String classificationCommercial = 'COMMERCIAL';
  static const String classificationMixed = 'MIXED';

  // ── Classification (tower) ─────────────────────────────────────────────
  static const String towerClassificationOffice = 'OFFICE';
  static const String towerClassificationMixedUse = 'MIXED_USE';
  static const String towerClassificationHotel = 'HOTEL';

  // ── Floor type (FLOOR property) ────────────────────────────────────────
  static const String floorTypeGround = 'GROUND';
  static const String floorTypeUpper = 'UPPER';
  static const String floorTypeBasement = 'BASEMENT';
  static const String floorTypeRoof = 'ROOF';

  // ── Features (top-level `features[]`) ──────────────────────────────────
  static const String featureInternet = 'INTERNET';
  static const String featureWater = 'WATER';
  static const String featureElectricity = 'ELECTRICITY';
  static const String featureSewage = 'SEWAGE';
  static const String featureElevator = 'ELEVATOR';
  static const String featureCentralAc = 'CENTRAL_AC';
  static const String featureParking = 'PARKING';
  static const String featureSecurity = 'SECURITY';
  static const String featureCctv = 'CCTV';
  static const String featureElectronicGate = 'ELECTRONIC_GATE';
  static const String featureCarShade = 'CAR_SHADE';
  static const String featureGarden = 'GARDEN';
  static const String featurePool = 'POOL';
  static const String featureMosqueInCompound = 'MOSQUE_IN_COMPOUND';
  static const String featureDriverRoom = 'DRIVER_ROOM';
  static const String featureMaidRoom = 'MAID_ROOM';
  static const String featureBasement = 'BASEMENT';
  static const String featureRoof = 'ROOF';
  static const String featureStorage = 'STORAGE';
  static const String featureHealthClub = 'HEALTH_CLUB';
  static const String featureWaterWell = 'WATER_WELL';

  // ── Land services ──────────────────────────────────────────────────────
  static const String landServiceElectricity = 'ELECTRICITY';
  static const String landServiceWater = 'WATER';
  static const String landServiceRoad = 'ROAD';
  static const String landServiceLighting = 'LIGHTING';
  static const String landServiceSewage = 'SEWAGE';

  // ── Tower amenities ────────────────────────────────────────────────────
  static const String towerAmenityPool = 'POOL';
  static const String towerAmenityGym = 'GYM';
  static const String towerAmenitySauna = 'SAUNA';
  static const String towerAmenityEventHall = 'EVENT_HALL';
  static const String towerAmenityLobby = 'LOBBY';
  static const String towerAmenitySecurity247 = 'SECURITY_24_7';
  static const String towerAmenityHeliport = 'HELIPORT';

  // ── Tower views ────────────────────────────────────────────────────────
  static const String viewPanoramic = 'PANORAMIC';
  static const String viewSea = 'SEA';
  static const String viewCity = 'CITY';
  static const String viewMountain = 'MOUNTAIN';
  static const String viewGarden = 'GARDEN';

  // ── Townhouse community facilities ─────────────────────────────────────
  static const String communityPool = 'POOL';
  static const String communityGym = 'GYM';
  static const String communityGarden = 'GARDEN';
  static const String communitySecurity = 'SECURITY';
  static const String communityPlayground = 'PLAYGROUND';

  // ── Office / shop facilities ───────────────────────────────────────────
  static const String facilityAc = 'AC';
  static const String facilityStorage = 'STORAGE';
  static const String facilityBathroom = 'BATHROOM';
  static const String facilityPrivateParking = 'PRIVATE_PARKING';
  static const String facilityElevator = 'ELEVATOR';

  // ── Shop location type ─────────────────────────────────────────────────
  static const String shopLocationMainStreet = 'MAIN_STREET';
  static const String shopLocationSideStreet = 'SIDE_STREET';
  static const String shopLocationMall = 'MALL';
  static const String shopLocationCommercialComplex = 'COMMERCIAL_COMPLEX';

  // ── Shop activities ────────────────────────────────────────────────────
  static const String activityElectronics = 'ELECTRONICS';
  static const String activityClothing = 'CLOTHING';
  static const String activityCafe = 'CAFE';
  static const String activityRestaurant = 'RESTAURANT';
  static const String activitySalon = 'SALON';
  static const String activitySupermarket = 'SUPERMARKET';

  // ── Warehouse door type ────────────────────────────────────────────────
  static const String doorTypeNormal = 'NORMAL';
  static const String doorTypeRoller = 'ROLLER';
  static const String doorTypeLoadingDock = 'LOADING_DOCK';

  // ── Warehouse cooling type ─────────────────────────────────────────────
  static const String coolingNone = 'NONE';
  static const String coolingChilled = 'CHILLED';
  static const String coolingFrozen = 'FROZEN';
  static const String coolingAirConditioned = 'AIR_CONDITIONED';

  // ── Warehouse floor type ───────────────────────────────────────────────
  static const String flooringConcrete = 'CONCRETE';
  static const String flooringEpoxy = 'EPOXY';
  static const String flooringIndustrialTiles = 'INDUSTRIAL_TILES';

  // ── Farm soil type ─────────────────────────────────────────────────────
  static const String soilClay = 'CLAY';
  static const String soilSandy = 'SANDY';
  static const String soilMixed = 'MIXED';

  // ── Commission payer (send-to-broker, individual) ──────────────────────
  static const String commissionPayerOwner = 'OWNER';
  static const String commissionPayerIndividual = 'INDIVIDUAL';

  // ── Farm water sources ─────────────────────────────────────────────────
  static const String waterSourceWell = 'WELL';
  static const String waterSourceNetwork = 'WATER_NETWORK';

  // ── Farm facilities ────────────────────────────────────────────────────
  static const String farmFacilityRestHouse = 'REST_HOUSE';
  static const String farmFacilityFence = 'FENCE';
  static const String farmFacilityLivestockSheds = 'LIVESTOCK_SHEDS';
  static const String farmFacilityElectricity = 'ELECTRICITY';
}
