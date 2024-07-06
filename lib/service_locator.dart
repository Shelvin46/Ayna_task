import 'package:ayna_task/core/services/firebase_service.dart';
import 'package:ayna_task/core/services/hive_local_storage_service.dart';
import 'package:ayna_task/core/services/shared_pref_services.dart';
import 'package:ayna_task/features/authentication/data/repositories/login_repo_implementation.dart';
import 'package:ayna_task/features/authentication/data/repositories/sign_up_repo_implementaion.dart';
import 'package:ayna_task/features/authentication/domain/repositories/login_repo.dart';
import 'package:ayna_task/features/authentication/domain/repositories/sign_up_repo.dart';
import 'package:ayna_task/features/authentication/domain/usecases/login_usecase.dart';
import 'package:ayna_task/features/authentication/domain/usecases/sign_up_usecases.dart';
import 'package:ayna_task/features/authentication/presentation/utils/form_validator.dart';
import 'package:ayna_task/features/chat/data/repositories/chat_repo_implementation.dart';
import 'package:ayna_task/features/chat/domain/repositories/chat_repo.dart';
import 'package:ayna_task/features/chat/domain/usecases/chat_usecases.dart';
import 'package:ayna_task/features/dashboard/data/repositories/dashboard_info_repo_implementation.dart';
import 'package:ayna_task/features/dashboard/domain/repositories/dashboard_info_repo.dart';
import 'package:ayna_task/features/dashboard/domain/usecases/dashboard_usecases.dart';
import 'package:get_it/get_it.dart';

// This is the instance of the get_it package
// we can register the classes into this instance
final locator = GetIt.instance;

///[ServiceLocator] is the class to manage the all dependencies present in the web app.

///[setupLocator] is the method to register all the dependencies in the web app.
///It is the method to register all the dependencies in the web app.
///[locator.registerLazySingleton] is the method to register the dependencies in the web app.x
class ServiceLocator {
  static void setupLocator() {
    locator.registerSingleton<FirebaseAuthenticationService>(
        FirebaseAuthenticationService());
    locator.registerLazySingleton(() => SharedPreferencesService());
    locator.registerLazySingleton(() => HiveStorageService());
    locator.registerLazySingleton(() => FormFieldValidateClass());
    locator.registerLazySingleton<LoginRepo>(() => LoginRepoImplementation());
    locator.registerLazySingleton(() => LoginUsecases());
    locator.registerLazySingleton<SignUpRepo>(() => SignUpRepoImplementation());
    locator.registerLazySingleton(() => SignUpUseCases());
    locator.registerLazySingleton<DashboardInfoRepo>(
        () => DashboardInfoRepoImplementation());
    locator.registerLazySingleton(() => DashboardUseCases());
    locator.registerLazySingleton<ChatRepo>(() => ChatRepoImplementation());
    locator.registerLazySingleton(() => ChatUsecases());
  }
}

// Dependency injections is an software designing pattern it deals with creation and management of dependencies into a class or module from outside
// for doing this approach on flutter application we can use get_it package we can create a instance from the get_it package and register the dependencies into it
/// what are the classes we registered on this get_it instance we can use those objects in anywhere in the application
/// we can register the classes as singleton, factory, lazy singleton
/// it will essential for making the code more testable and maintainable also for loose coupling