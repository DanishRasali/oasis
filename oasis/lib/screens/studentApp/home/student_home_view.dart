import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';

import 'student_home_viewmodel.dart';

class StudentHomeView extends StatefulWidget {
  StudentHomeView();

  @override
  _StudentHomeViewState createState() => _StudentHomeViewState();
}

class _StudentHomeViewState extends State<StudentHomeView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentHomeViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => StudentHomeViewModel(),
        builder: (context, model, child) => Scaffold(
              body: ListView(
                children: [
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
                                      color: Colors.white,
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
