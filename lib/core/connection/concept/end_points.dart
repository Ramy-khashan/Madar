class EndPoints {
  static const String baseUrl = 'https://api.madar.support/';
  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String fcmToken = 'auth/save-fcm-token';
  static const String realEstateNews = 'news';
  static const String properties = 'properties';
  static String realEstateNewsDetails(String id) => 'news/$id';
  static const String ads = 'advertisements';
  static const String portfolio = 'properties/my-properties';
  static const String profile = 'users/profile';
  static const String notifications = 'notifications';
  static const String netProfitLoss = 'dashboard/profit-loss';
  static const String realEstateProjects = 'projects';
  static String projectUpdates(String projectId) => 'projects/updates/$projectId';
  static const String propertyEvaluations = 'evaluations/property';

  ///Wishlist Endpoints
  static const String wishlist = 'saved-properties';
  static String addToWishlist(String id) => 'saved-properties/$id/toggle';
  static String removeFromWishlist(String id) => 'saved-properties/$id/unsave';
  static String checkWishlist(String id) => 'saved-properties/$id/check';
  static const String wishlistCount = 'saved-properties/count';
  static const String getContracts = 'contracts';
  static String contractDetails(String id) => 'contracts/$id';
  static const String requests = 'requests/me';
  static const String financialReports = 'dashboard/financial-reports';
  static const String myAuctions = '/auctions/my-auctions';
  static const String brokers = 'brokers';
  static const String realStateProjectCreation = 'projects';
  static String projectStages(String projectType) =>
      'projects/stages?projectType=$projectType';
}
