import 'package:dio/dio.dart';
import 'package:flicker_mail/core/config_loader/config_loader.dart';
import 'package:flicker_mail/data/data_sources/app_internals_local_data_source/app_internals_local_data_source.dart';
import 'package:flicker_mail/data/data_sources/app_internals_local_data_source/entities/app_config_db_entity.dart';
import 'package:flicker_mail/data/data_sources/app_internals_local_data_source/entities/app_info_db_entity.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_local_data_source/entities/email_entity.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_local_data_source/entities/email_message_entity.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_local_data_source/temp_mail_local_data_source.dart';
import 'package:flicker_mail/data/data_sources/temp_mail_remote_data_source/temp_mail_remote_data_source.dart';
import 'package:flicker_mail/data/repositories/app_repository_impl.dart';
import 'package:flicker_mail/data/repositories/temp_mail_repository_impl.dart';
import 'package:flicker_mail/domain/models/app_config.dart';
import 'package:flicker_mail/domain/models/app_info.dart';
import 'package:flicker_mail/domain/repositories/app_repository.dart';
import 'package:flicker_mail/domain/repositories/temp_mail_repository.dart';
import 'package:flicker_mail/presentation/providers/adv_provider.dart';
import 'package:flicker_mail/presentation/providers/app_provider.dart';
import 'package:flicker_mail/presentation/providers/email_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

const Duration _connectTimeout = Duration(seconds: 25);

Future<void> initDependencies() async {
  /// APP ENV VARIABLES
  final ConfigLoader configLoader = DotenvConfigLoaderImpl(".env");
  await configLoader.load();

  final dir = await getApplicationDocumentsDirectory();

  /// LOCAL DB
  final Isar isar = await Isar.open(
    [
      AppConfigEntitySchema,
      AppInfoEntitySchema,
      EmailEntitySchema,
      EmailMessageEntitySchema,
    ],
    directory: dir.path,
  );

  /// NETWORK
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _connectTimeout,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
      },
      baseUrl: configLoader.get(EnvVariable.tempEmailBaseUrl.key) ?? "",
    ),
  );

  serviceLocator.registerSingleton<Dio>(dio);
  serviceLocator.registerSingleton<Isar>(isar);
  serviceLocator.registerSingleton<ConfigLoader>(configLoader);

  /// Data source
  serviceLocator
      .registerFactory<AppInternalsLocalDataSource>(() => AppInternalsIsarDataSourceImpl(isar: serviceLocator()));
  serviceLocator.registerFactory<TempMailRemoteDataSource>(() => TempMailDioImpl(dio: serviceLocator()));
  serviceLocator.registerFactory<TempMailLocalDataSource>(() => TempMailIsarImpl(isar: serviceLocator()));

  /// Repository
  serviceLocator.registerFactory<TempMailRepository>(() => TempMailRepositoryImpl(
        tempMailLocalDataSource: serviceLocator(),
        tempMailRemoteDataSource: serviceLocator(),
      ));
  serviceLocator.registerFactory<AppRepository>(() => AppRepositoryImpl(
        appInternalsLocalDataSource: serviceLocator(),
      ));

  /// Providers
  AppConfig initAppConfig = await serviceLocator.get<AppRepository>().getAppConfig();
  AppInfo appInfo = await serviceLocator.get<AppRepository>().getAppInfo();

  serviceLocator.registerLazySingleton<AppProvider>(
    () => AppProvider(
      appRepository: serviceLocator(),
      appConfig: initAppConfig,
      appInfo: appInfo,
    ),
  );

  serviceLocator.registerLazySingleton<EmailProvider>(
    () => EmailProvider(
      tempEmailRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<AdvProvider>(
    () => AdvProvider(
      configLoader: serviceLocator(),
    ),
  );
}
