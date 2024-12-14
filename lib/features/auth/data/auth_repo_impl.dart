import 'dart:convert';
import 'dart:developer';
import 'package:atw_signin_task/constants.dart';
import 'package:atw_signin_task/core/errors/exceptions.dart';
import 'package:atw_signin_task/core/errors/failures.dart';
import 'package:atw_signin_task/core/services/data_service.dart';
import 'package:atw_signin_task/core/services/firebase_auth_service.dart';
import 'package:atw_signin_task/core/services/shared_preferences_singleton.dart';
import 'package:atw_signin_task/core/utils/backend_endpoint.dart';
import 'package:atw_signin_task/features/auth/data/auth_repo.dart';
import 'package:atw_signin_task/features/auth/data/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl(
      {required this.databaseService, required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
          email: email, password: password);
      var userEntity = UserEntity(
        name: name,
        email: email,
        uId: user.uid,
      );
      await addUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithEmailAndPassword(
      String email, String password) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);
      var userEntity = await getUserData(uid: user.uid);
      return right(
        userEntity,
      );
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.signInWithEmailAndPassword: ${e.toString()}',
      );
      return left(
        ServerFailure(
          'حدث خطأ ما. الرجاء المحاولة مرة اخرى.',
        ),
      );
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: BackendEndpoint.addUserData,
      data: UserModel.fromEntity(user).toMap(),
      documentId: user.uId,
    );
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    var userData = await databaseService.getData(
        path: BackendEndpoint.getUsersData, docuementId: uid);
    return UserModel.fromJson(userData);
  }

  // @override
  // Future saveUserData({required UserEntity user}) async {
  //   var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
  //   await Prefs.setString(kUserData, jsonData);
  // }
}
