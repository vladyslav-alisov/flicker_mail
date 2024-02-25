enum AppRoutes {
  splashScreen("/", "/"),
  errorScreen("/launch_error", "/launch_error"),
  home("/home", "/home"),
  privacyPolicy("privacy_policy", "/home/privacy_policy"),
  mailScreen("mail", "/home/mail");

  const AppRoutes(this.name, this.path);

  final String name;
  final String path;
}
