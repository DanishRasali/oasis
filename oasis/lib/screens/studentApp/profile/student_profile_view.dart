import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oasis/screens/signin/signin_view.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import 'package:oasis/screens/shared/colors.dart';

import 'student_profile_viewmodel.dart';

class StudentProfileView extends StatefulWidget {
  StudentProfileView();

  @override
  _StudentProfileViewState createState() => _StudentProfileViewState();
}

class _StudentProfileViewState extends State<StudentProfileView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentProfileViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => StudentProfileViewModel(),
        builder: (context, model, child) => Scaffold(
              body: ListView(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    model.currentUser.displayName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    model.currentUser.email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      model.navigateToUpdateProfile(context, model.currentUser);
                    },
                    child: Text(
                      'Edit Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 13.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ACCOUNT SETTINGS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      model.navigateToUpdateProfile(
                                          context, model.currentUser);
                                    },
                                    child: Text(
                                      'Personal Information',
                                      style: TextStyle(
                                        color: grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Payments and payouts',
                                    style: TextStyle(
                                      color: grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Notifications',
                                    style: TextStyle(
                                      color: grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    'PROMOTIONS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Refer a renter',
                                    style: TextStyle(
                                      color: grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    'SUPPORT',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'Safety Center',
                                    style: TextStyle(
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: grey,
                                    ),
                                  ),
                                  Text(
                                    'Get Help',
                                    style: TextStyle(
                                      color: grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Give us feedback',
                                    style: TextStyle(
                                      color: grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'LEGAL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  Text(
                                    'Terms of service',
                                    style: TextStyle(
                                      color: grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      child: Text(
                                        'Sign Out',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      onTap: () async {
                                        try {
                                          model.signOut(context);
                                          myToast('Signed Out');
                                          return await _auth.signOut();
                                        } catch (e) {
                                          print(e.toString());
                                        }
                                      }),
                                  SizedBox(
                                    height: 40.0,
                                    child: Divider(
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
