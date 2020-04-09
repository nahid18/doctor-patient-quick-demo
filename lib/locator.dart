import 'package:doctor_patient/services/navigation_service.dart';
import 'package:doctor_patient/services/database_service.dart';
import 'package:doctor_patient/services/dialog_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => DatabaseService());
}
