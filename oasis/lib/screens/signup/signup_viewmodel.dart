import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oasis/app/locator.dart';
import 'package:oasis/screens/signin/signin_view.dart';
import 'package:oasis/screens/viewmodel.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/screens/shared/toastAndDialog.dart';
import 'package:oasis/screens/teacherApp/teacherMain/teacher_main_screen.dart';
import 'package:oasis/screens/studentApp/studentMain/student_main_screen.dart';

class SignUpViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future signUp({
    @required String displayName,
    @required String email,
    @required String password,
    @required String phoneNumber,
    @required String type,
    @required context,
  }) async {
    setBusy(true);

    var result = await _authenticationService.registerWithEmailAndPassword(
      displayName: displayName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      type: type,
    );

    setBusy(false);

    if (result is String) {
      awesomeSingleDialog(context, 'Sign-Up Error', result,
          () => Navigator.of(context, rootNavigator: true).pop());
    } else {
      if (result != null) {
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
            'Sign-Up Error',
            'General sign-up failure. Please try again later',
            () => Navigator.of(context, rootNavigator: true).pop());
      }
    }
  }

  void navigateToSignIn(context) {
    Navigator.of(context, rootNavigator: true)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignInView()));
  }
}
