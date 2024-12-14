import 'package:atw_signin_task/constants.dart';
import 'package:atw_signin_task/features/auth/presentation/view/widgets/custom_button.dart';
import 'package:atw_signin_task/features/auth/presentation/view/widgets/custom_text_form_field.dart';
import 'package:atw_signin_task/features/auth/presentation/view/widgets/dont_have_account_widget.dart';
import 'package:atw_signin_task/features/auth/presentation/view/widgets/password_field.dart';
import 'package:atw_signin_task/features/auth/presentation/view_model/signin_cubit/signin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninBody extends StatefulWidget {
  const SigninBody({super.key});

  @override
  State<SigninBody> createState() => _SigninBodyState();
}

class _SigninBodyState extends State<SigninBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizintalPadding,
      ),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Let's Sign you in.",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
                const Text("Welcome back.",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w400)),
                const Text("You've been missed!",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w400)),
                const SizedBox(
                  height: 40,
                ),
                CustomTextFormField(
                  onSaved: (value) {
                    email = value!;
                  },
                  hintText: 'Your email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 30,
                ),
                PasswordField(
                  onSaved: (value) {
                    password = value!;
                  },
                ),
              ],
            ),
            const Spacer(
              flex: 3,
            ),
            Column(
              children: [
                CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.read<SigninCubit>().signin(email, password);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  text: 'Sign in',
                ),
                const SizedBox(
                  height: 16,
                ),
                const DontHaveAnAccountWidget(),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
