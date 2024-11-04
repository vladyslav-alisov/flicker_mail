class AppInfo {
  String appName;
  String packageName;
  String version;
  String buildNumber;
  String buildSignature;
  DateTime lastUpdated;

  AppInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
    required this.buildSignature,
    required this.lastUpdated,
  });

  @override
  String toString() {
    return 'AppInfo{appName: $appName, packageName: $packageName, version: $version, buildNumber: $buildNumber, buildSignature: $buildSignature, lastUpdated: $lastUpdated}';
  }
}
