

import 'package:atw_signin_task/features/auth/data/auth_repo.dart';
import 'package:atw_signin_task/features/auth/data/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    emit(SignupLoading());
    final result =
        await authRepo.createUserWithEmailAndPassword(email, password, name);
    result.fold(
      (failure) => emit(
        SignupFailure(message: failure.message),
      ),
      (userEntity) => emit(
        SignupSuccess(userEntity: userEntity),
      ),
    );
  }
}
