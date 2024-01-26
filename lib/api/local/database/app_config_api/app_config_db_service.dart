import 'package:isar/isar.dart';
import 'package:flicker_mail/api/local/database/app_config_api/app_config_db_entity.dart';
import 'package:flicker_mail/api/local/database/database_client.dart';

class AppConfigDBService {
  final DatabaseClient _dbService = DatabaseClient.instance;

  Future<AppConfigDBEntity?> getAppConfig() async {
    AppConfigDBEntity? appConfigDBEntity = await _dbService.db.appConfigDBEntitys.where().findFirst();
    return appConfigDBEntity;
  }

  Future<void> saveAppConfig(AppConfigDBEntity appConfigDBEntity) async {
    await _dbService.db.writeTxn(() async {
      await _dbService.db.appConfigDBEntitys.put(appConfigDBEntity);
    });
  }

  Future<void> deleteAllConfigEntity() async {
    await _dbService.db.writeTxn(() async {
      await _dbService.db.appConfigDBEntitys.clear();
    });
  }
}
