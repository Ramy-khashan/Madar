class EndPoints {
  static const String baseUrl =
      'https://scopey.onrender.com/';
  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String fcmToken = 'auth/save-fcm-token';
  static const String realEstateNews = 'news';
  static const String properties = 'properties';
  static String realEstateNewsDetails(String id) => 'news/$id';
 }