class AppEnv {
  static AppEnv? _instance;

  static AppEnv get instance =>
      _instance != null ? _instance! : throw Exception("AppConfig must be initialized first!");

  AppEnv._({required this.tempEmailBaseUrl});

  final String tempEmailBaseUrl;

  static AppEnv init({required String tempEmailBaseUrl}) {
    _instance ??= AppEnv._(tempEmailBaseUrl: tempEmailBaseUrl);
    return _instance!;
  }
}
