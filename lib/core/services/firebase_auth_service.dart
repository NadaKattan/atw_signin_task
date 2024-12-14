import 'dart:developer';
import 'package:atw_signin_task/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()} and code is ${e.code}");
      if (e.code == 'weak-password') {
        throw CustomException(message: 'The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'You have already registered. Please log in.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'Make sure you are connected to the internet.');
      } else {
        throw CustomException(
            message: 'Something went wrong! Please try again.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}");

      throw CustomException(
          message: 'Something went wrong! Please try again');
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()} and code is ${e.code}");
      if (e.code == 'user-not-found'||e.code == 'wrong-password'||e.code == 'invalid-credential') {
        throw CustomException(
            message: 'The password or email is incorrect.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'Make sure you are connected to the internet.');
      } else {
        throw CustomException(
            message: 'Something went wrong! Please try again');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}");

      throw CustomException(
          message: 'Something went wrong! Please try again');
    }
  }
}
