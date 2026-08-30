class EndPoints {
  static const String baseUrl = 'https://api.madar.support/';
  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String loginBroker = 'auth/login/broker';
  static const String loginOwner = 'auth/login';
  static const String fcmToken = 'auth/save-fcm-token';
  static const String logout = 'auth/logout';
  static const String refreshToken = 'auth/refresh-token';
  static const String otpSend = 'otp/send';
  static const String otpVerify = 'otp/verify';
  static const String otpResetPassword = 'otp/reset-password';
  static const String realEstateNews = 'news';
  static const String getProfile = 'users/profile';
  static const String properties = 'properties';
  static const String propertiesMap = 'properties/map';
  static String realEstateNewsDetails(String id) => 'news/$id';
  static const String ads = 'advertisements';
  static const String saveEvaluations = 'evaluations/smart-suggestion/save';
  static const String portfolio = 'properties/my-properties';
  static const String profile = 'users/profile';
  static const String notifications = 'notifications';
  static String notificationRead(String id) => 'notifications/$id/read';
  static const String notificationsReadAll = 'notifications/read';
  static const String netProfitLoss = 'dashboard/profit-loss';
  static const String realEstateProjects = 'projects';
  static String projectUpdates(String projectId) =>
      'projects/updates/$projectId';
  static const String evaluations = 'evaluations/smart-suggestion';
  static String brokerProperties(String brokerId) =>
      'broker/$brokerId/properties';

  ///Wishlist Endpoints
  static const String wishlist = 'saved-properties';
  static String addToWishlist(String id) => 'saved-properties/$id/toggle';
  static String removeFromWishlist(String id) => 'saved-properties/$id/unsave';
  static String checkWishlist(String id) => 'saved-properties/$id/check';
  static const String wishlistCount = 'saved-properties/count';
  static const String getContracts = 'contracts';
  static String contractDetails(String id) => 'contracts/$id';
  static const String renewContract = 'contracts/renew';
  static String approveContract(String contractId) =>
      'contracts/$contractId/approve';
  static String rejectContract(String contractId) =>
      'contracts/$contractId/reject';
  static const String requests = 'broker/requests';
  static String brokerRequestAction(String requestId) =>
      'broker/requests/$requestId';
  static const String incomingRequests = 'requests/incoming';
  static String incomingRequestAction(String requestId) =>
      'requests/$requestId';
  static const String propertyRequests = 'requests';
  static const String myPropertyRequests = 'requests/me';
  static String propertyRequestById(String requestId) => 'requests/$requestId';
  static String propertyRequestStatus(String requestId) =>
      'requests/$requestId/status';
  static String propertyRequestsByProperty(String propertyId) =>
      'requests/property/$propertyId';
  static const String financialReports = 'dashboard/financial-reports';
  static const String financialReportsOverview =
      'dashboard/financial-reports/overview';
  static const String dashboardRevenues = 'dashboard/revenues';
  static const String dashboardExpenses = 'dashboard/expenses';
  static const String performanceReports = 'dashboard/performance-reports';
  static const String myAuctions = '/auctions/my-auctions';
  static const String brokers = 'auth/brokers';
  static const String sendToBrokers = 'properties/send-to-broker/';
  static const String evaluationPreview = 'evaluations/preview';
  static const String realStateProjectCreation = 'projects';
  static String projectStages(String projectType) =>
      'projects/stages?projectType=$projectType';

  static const String chatAi = 'chat/ai';
  static const String myChats = 'chat/my-chats';
  static const String chatPrivate = 'chat/private';
  static String chatMessage(String chatId) => 'chat/$chatId/message';
  static const String socketUrl = 'https://api.madar.support';
  static String propertyById(String id) => 'properties/$id';
  static const String ownerPropertyExpense = 'owner/property-expense';
} 