import 'package:atw_signin_task/constants.dart';
import 'package:atw_signin_task/core/services/get_it_service.dart';
import 'package:atw_signin_task/features/auth/data/auth_repo.dart';
import 'package:atw_signin_task/features/auth/presentation/view/widgets/signin_body_bloc_consumer.dart';
import 'package:atw_signin_task/features/auth/presentation/view_model/signin_cubit/signin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(
        getIt.get<AuthRepo>(),
      ),
      child: Scaffold(
        appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: kHorizintalPadding),
          child: Icon(
            Icons.undo,
            size: 32,
            color: Colors.black54,
          ),
        ),
      ),
        body: const SigninBodyBlocConsumer(),
      ),
    );
  }
}