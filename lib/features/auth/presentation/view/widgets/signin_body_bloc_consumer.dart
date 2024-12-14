import 'package:atw_signin_task/core/Routes/routes.dart';
import 'package:atw_signin_task/core/helper_functions/build_error_bar.dart';
import 'package:atw_signin_task/core/widgets/custom_progress_hud.dart';
import 'package:atw_signin_task/features/auth/presentation/view/widgets/signin_body.dart';
import 'package:atw_signin_task/features/auth/presentation/view_model/signin_cubit/signin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SigninBodyBlocConsumer extends StatelessWidget {
  const SigninBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        }
        if (state is SigninFailure) {
          buildErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SigninLoading ? true : false,
          child: const SigninBody(),
        );
      },
    );
  }
}
