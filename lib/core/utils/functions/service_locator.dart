import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../config/app_controller/app_controller_bloc.dart';
import '../../../core/repository/maps/google_map_service.dart';
import '../../../core/repository/maps/map_service.dart';
import '../../connection/implementation/dio_consumer.dart';
import '../../connection/interfaces/api_consumer.dart';
import 'handle_multi_callback.dart';
import 'notification_service.dart';
import 'preference_utils.dart';

final sl = GetIt.instance;
Future<void> intiService() async {
  await PreferenceUtils.init();
  sl.registerSingleton<HandleMultiCallLocal>(HandleMultiCallLocal());

  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
  sl.registerLazySingleton<AppControllerBloc>(() => AppControllerBloc());
  sl.registerLazySingleton<PreferenceUtils>(() => PreferenceUtils());
  sl.registerLazySingleton<MapService>(() => GoogleMapService());
  sl.registerLazySingleton<NotificationService>(
    () => NotificationService.instance,
  );
}
