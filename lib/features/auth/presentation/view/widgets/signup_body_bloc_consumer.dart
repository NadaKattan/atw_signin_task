import 'package:atw_signin_task/core/Routes/routes.dart';
import 'package:atw_signin_task/features/auth/presentation/view/widgets/signup_body.dart';
import 'package:atw_signin_task/features/auth/presentation/view_model/signup_cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';


class SignupBodyBlocConsumer extends StatelessWidget {
  const SignupBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          Navigator.of(context).pushReplacementNamed(Routes.signin);
        }
        if (state is SignupFailure) {
          buildErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoading ? true : false,
          child: const SignupBody(),
        );
      },
    );
  }
}