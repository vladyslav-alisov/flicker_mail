enum AppRoutes {
  splashScreen("/", "/"),
  errorScreen("/launch_error", "/launch_error"),
  homeScreen("/home", "/home"),
  privacyPolicyScreen("privacy_policy", "/home/privacy_policy"),
  newEmailScreen("new_email", "/home/new_email"),
  emailMessageDetailsScreen("email_message_details", "/home/email_message_details"),
  emailArchiveScreen("email_archive", "/home/email_archive");

  const AppRoutes(this.name, this.path);

  final String name;
  final String path;
}
