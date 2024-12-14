
import 'package:atw_signin_task/core/services/data_service.dart';
import 'package:atw_signin_task/core/services/firebase_auth_service.dart';
import 'package:atw_signin_task/core/services/firestore_service.dart';
import 'package:atw_signin_task/features/auth/data/auth_repo.dart';
import 'package:atw_signin_task/features/auth/data/auth_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FireStoreService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );

}