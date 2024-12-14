import 'package:atw_signin_task/core/Routes/routes.dart';
import 'package:atw_signin_task/core/services/custom_bloc_observer.dart';
import 'package:atw_signin_task/core/services/get_it_service.dart';
import 'package:atw_signin_task/core/services/shared_preferences_singleton.dart';
import 'package:atw_signin_task/features/auth/presentation/view/home_screen.dart';
import 'package:atw_signin_task/features/auth/presentation/view/signin_screen.dart';
import 'package:atw_signin_task/features/auth/presentation/view/signup_screen.dart';
import 'package:atw_signin_task/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Prefs.init();
  setupGetit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATW Task',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      routes: {
        Routes.signin: (_) => const SigninScreen(),
        Routes.signup: (_) => const SignupScreen(),
        Routes.home: (_) => const HomeScreen(),
      },
      initialRoute: Routes.signup,
      // home:const LoginScreen(),
    );
  }
}
