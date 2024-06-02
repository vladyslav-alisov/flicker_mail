import 'package:flicker_mail/api/local/database/temp_mail_api/entities/message_details_entity.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_message_entity.dart';
import 'package:flicker_mail/api/local/database/temp_mail_api/entities/email_entity.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flicker_mail/api/local/database/app_config_api/app_config_db_entity.dart';
import 'package:flicker_mail/api/local/database/app_info_api/app_info_db_entity.dart';

class DatabaseClient {
  static DatabaseClient? _instance;

  final Isar _isar;
  Isar get db => _isar;

  static DatabaseClient get instance => _instance != null ? _instance! : throw Exception("Initialize database first!");

  DatabaseClient(this._isar);

  static Future<DatabaseClient> initLocalDatabase() async {
    if (_instance == null) {
      final dir = await getApplicationDocumentsDirectory();
      Isar isar = await Isar.open(
        [
          AppConfigDBEntitySchema,
          AppInfoDBEntitySchema,
          EmailEntitySchema,
          EmailMessageEntitySchema,
          MessageDetailsEntitySchema
        ],
        directory: dir.path,
      );
      _instance = DatabaseClient(isar);
    }
    return _instance!;
  }
}
