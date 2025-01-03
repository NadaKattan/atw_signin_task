import 'package:atw_signin_task/core/services/get_it_service.dart';
import 'package:atw_signin_task/features/auth/data/repos/auth_repo.dart';
import 'package:atw_signin_task/features/auth/presentation/view/widgets/signup_body_bloc_consumer.dart';
import 'package:atw_signin_task/features/auth/presentation/view_model/signup_cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        getIt.get<AuthRepo>(),
      ),
      child: Scaffold(
        appBar: AppBar(),
        body: const SignupBodyBlocConsumer(),
      ),
    );
  }
}
