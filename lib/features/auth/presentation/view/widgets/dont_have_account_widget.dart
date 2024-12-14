import 'package:atw_signin_task/core/Routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: "Don't have an account?",
              style: TextStyle(fontSize: 18),
            ),
            const TextSpan(
              text: ' ',
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, Routes.signup);
                },
              text: "Register",
              style: const TextStyle(fontSize: 18, color: Color(0xff8360F3)),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
