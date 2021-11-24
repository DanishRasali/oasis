import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oasis/app/locator.dart';
import 'package:oasis/screens/viewmodel.dart';
import 'package:oasis/screens/signup/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/screens/shared/toastAndDialog.dart';
import 'package:oasis/screens/teacherApp/teacherMain/teacher_main_screen.dart';
import 'package:oasis/screens/studentApp/studentMain/student_main_screen.dart';

class SignInViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future signIn({
    @required String email,
    @required String password,
    @required context,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is String) {
      awesomeSingleDialog(context, 'Sign-In Error', result,
          () => Navigator.of(context, rootNavigator: true).pop());
    } else {
      if (result) {
        await Future.delayed(Duration(seconds: 1));
        if (currentUser.type == "Teacher") {
          await Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => TeacherMainScreen(tab: 0)));
        } else {
          await Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => StudentMainScreen(tab: 0)));
        }
      } else {
        awesomeSingleDialog(
            context,
            'Sign-In Error',
            'General sign-in failure. Please try again later',
            () => Navigator.of(context, rootNavigator: true).pop());
      }
    }
  }

  void navigateToSignUp(context) {
    Navigator.of(context, rootNavigator: true)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignUpView()));
  }
}
