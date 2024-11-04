import 'package:flicker_mail/data/data_sources/app_internals_local_data_source/entities/app_info_db_entity.dart';
import 'package:flicker_mail/domain/models/app_info.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoModel extends AppInfo {
  AppInfoModel({
    required super.appName,
    required super.packageName,
    required super.version,
    required super.buildNumber,
    required super.buildSignature,
    required super.lastUpdated,
  });

  factory AppInfoModel.fromAppInfo(AppInfo appInfo) {
    return AppInfoModel(
      appName: appInfo.appName,
      packageName: appInfo.packageName,
      version: appInfo.version,
      buildNumber: appInfo.buildNumber,
      buildSignature: appInfo.buildSignature,
      lastUpdated: appInfo.lastUpdated,
    );
  }

  factory AppInfoModel.fromPackageInfo(PackageInfo packageInfo) {
    return AppInfoModel(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      buildSignature: packageInfo.buildSignature,
      lastUpdated: DateTime.now(),
    );
  }

  AppInfoEntity toEntity() {
    return AppInfoEntity(
      appName,
      packageName,
      version,
      buildNumber,
      buildSignature,
      lastUpdated,
    );
  }

  factory AppInfoModel.fromEntity(AppInfoEntity appInfoDBEntity) {
    return AppInfoModel(
      appName: appInfoDBEntity.appName,
      packageName: appInfoDBEntity.packageName,
      version: appInfoDBEntity.version,
      buildNumber: appInfoDBEntity.buildNumber,
      buildSignature: appInfoDBEntity.buildSignature,
      lastUpdated: appInfoDBEntity.lastUpdated,
    );
  }
}
