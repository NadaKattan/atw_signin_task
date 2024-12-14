import 'package:atw_signin_task/core/errors/failures.dart';
import 'package:atw_signin_task/features/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name);

  Future<Either<Failure, UserEntity>> signinWithEmailAndPassword(
      String email, String password);
  Future addUserData({required UserEntity user});
  Future<UserEntity> getUserData({required String uid});
  Future saveUserData({required UserEntity user});
}
