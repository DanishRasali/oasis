import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oasis/app/locator.dart';
import 'package:oasis/screens/studentApp/profile/student_updateProfile_view.dart';
import 'package:oasis/screens/signin/signin_view.dart';
import 'package:oasis/screens/viewmodel.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/user_service.dart';
// import 'package:oasis/services/cloud_storage_service.dart';

class StudentProfileViewModel extends ViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final UserService _userService = locator<UserService>();

  void updateProfile({
    @required String displayName,
    @required String phoneNumber,
    File imageFile,
  }) async {
    setBusy(true);

    if (imageFile == null) {
      await _userService.updateUser(
          id: currentUser.id,
          displayName: displayName,
          phoneNumber: phoneNumber);

      currentUser.displayName = displayName;
      currentUser.phoneNumber = phoneNumber;
    } else {
      // await cloudStorageService
      //     .updateProfile(
      //       imageToUpload: imageFile,
      //       title: displayName,
      //       displayName: displayName,
      //       phoneNumber: phoneNumber,
      //     )
      //     .whenComplete(() {});
    }

    setBusy(false);
  }

  void navigateToUpdateProfile(context, user) {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => StudentUpdateProfileView(user: user)));
  }

  void signOut(context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInView()),
        (route) => false);
  }
}
