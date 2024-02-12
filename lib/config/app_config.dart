class AppConfig {
  static const String googleMapKey = "YOU_GOOGLE_MAP_KEY";
  static const String version = '1.0.0';
  static const String domain = 'https://maps.googleapis.com/';

  //Singleton factory
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();
}
