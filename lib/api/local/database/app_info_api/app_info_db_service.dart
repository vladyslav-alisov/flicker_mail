import 'package:isar/isar.dart';
import 'package:flicker_mail/api/local/database/app_info_api/app_info_db_entity.dart';
import 'package:flicker_mail/api/local/database/database_client.dart';

class AppInfoDBService {
  final DatabaseClient _dbService = DatabaseClient.instance;

  Future<AppInfoDBEntity?> getAppInfo() async {
    AppInfoDBEntity? appInfoDBEntity = await _dbService.db.appInfoDBEntitys.where().findFirst();
    return appInfoDBEntity;
  }

  Future<void> saveAppInfo(AppInfoDBEntity appInfoDBEntity) async {
    await _dbService.db.writeTxn(() async {
      await _dbService.db.appInfoDBEntitys.put(appInfoDBEntity);
    });
  }

  Future<void> deleteAllConfigEntity() async {
    await _dbService.db.writeTxn(() async {
      await _dbService.db.appInfoDBEntitys.clear();
    });
  }
}
