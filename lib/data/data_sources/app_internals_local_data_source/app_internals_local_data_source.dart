import 'package:flicker_mail/core/error/exceptions.dart';
import 'package:flicker_mail/data/data_sources/app_internals_local_data_source/entities/app_config_db_entity.dart';
import 'package:flicker_mail/data/data_sources/app_internals_local_data_source/entities/app_info_db_entity.dart';
import 'package:isar/isar.dart';

abstract interface class AppInternalsLocalDataSource {
  Future<AppInfoEntity?> getAppInfo();

  Future<void> saveAppInfo(AppInfoEntity appInfoDBEntity);

  Future<void> deleteAllConfigEntity();

  Future<AppConfigEntity?> getAppConfig();

  Future<void> saveAppConfig(AppConfigEntity appConfigDBEntity);

  Future<void> deleteAllInfoEntity();

  Future<void> clearDatabase();
}

class AppInternalsIsarDataSourceImpl implements AppInternalsLocalDataSource {
  final Isar _isar;

  AppInternalsIsarDataSourceImpl({required Isar isar}) : _isar = isar;

  @override
  Future<AppConfigEntity?> getAppConfig() async {
    try {
      AppConfigEntity? appConfigDBEntity = await _isar.appConfigEntitys.where().findFirst();
      return appConfigDBEntity;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<void> saveAppConfig(AppConfigEntity appConfigDBEntity) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.appConfigEntitys.put(appConfigDBEntity);
      });
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<void> deleteAllConfigEntity() async {
    try {
      await _isar.writeTxn(_isar.appConfigEntitys.clear);
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<AppInfoEntity?> getAppInfo() async {
    try {
      AppInfoEntity? appInfoDBEntity = await _isar.appInfoEntitys.where().findFirst();
      return appInfoDBEntity;
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<void> saveAppInfo(AppInfoEntity appInfoDBEntity) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.appInfoEntitys.put(appInfoDBEntity);
      });
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<void> deleteAllInfoEntity() async {
    try {
      await _isar.writeTxn(_isar.appInfoEntitys.clear);
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }

  @override
  Future<void> clearDatabase() async {
    try {
      await _isar.writeTxn(_isar.clear);
    } on IsarError catch (e) {
      throw DatabaseException(e.message);
    }
  }
}
