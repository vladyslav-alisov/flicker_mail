import 'package:package_info_plus/package_info_plus.dart';
import 'package:flicker_mail/api/local/database/app_info_api/app_info_db_entity.dart';
import 'package:flicker_mail/models/app_info/app_info.dart';

class AppInfoMapper {
  static AppInfo fromPackageInfoToAppInfo(PackageInfo packageInfo, DateTime lastUpdated) {
    return AppInfo(
      packageInfo.appName,
      packageInfo.packageName,
      packageInfo.version,
      packageInfo.buildNumber,
      packageInfo.buildSignature,
      lastUpdated,
    );
  }

  static AppInfoDBEntity fromAppInfoToAppInfoDBEntity(AppInfo appInfo) {
    return AppInfoDBEntity(
      appInfo.appName,
      appInfo.packageName,
      appInfo.version,
      appInfo.buildNumber,
      appInfo.buildSignature,
      appInfo.lastUpdated,
    );
  }

  static AppInfo fromAppInfoDBEntityToAppInfo(AppInfoDBEntity appInfoDBEntity) {
    return AppInfo(
      appInfoDBEntity.appName,
      appInfoDBEntity.packageName,
      appInfoDBEntity.version,
      appInfoDBEntity.buildNumber,
      appInfoDBEntity.buildSignature,
      appInfoDBEntity.lastUpdated,
    );
  }
}
