import 'dart:io';

import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:oasis/models/classroom.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:oasis/screens/teacherApp/home/subject_view.dart';
import 'package:stacked/stacked.dart';
import 'package:oasis/screens/shared/appBar.dart';
import 'package:oasis/screens/shared/textField.dart';
import 'package:oasis/screens/shared/buttons.dart';
import 'package:oasis/screens/shared/colors.dart';
import 'package:oasis/screens/shared/divider.dart';
import 'package:oasis/screens/shared/toastAndDialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'teacher_home_viewmodel.dart';

class AddAssignmentView extends StatefulWidget {
  const AddAssignmentView(
      {this.subject, this.classroom, this.teachersubjectclassroom});
  final Subject subject;
  final Classroom classroom;
  final TeacherSubjectClassroom teachersubjectclassroom;

  @override
  _AddAssignmentViewState createState() => _AddAssignmentViewState();
}

class _AddAssignmentViewState extends State<AddAssignmentView> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final fileController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File file;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<TeacherHomeViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => TeacherHomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, 'Add Assignment'),
        body: Stack(
          children: [
            Container(
              height: screenHeight,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            titleController,
                            'Tap to enter assignment title...',
                            1,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'title',
                          ),
                        ],
                      ),
                    ),
                    awesomeDivider(0.8, dividerColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            descController,
                            'Tap to enter assignment description...',
                            6,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'description',
                          ),
                        ],
                      ),
                    ),
                    awesomeDivider(0.8, dividerColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            startDateController,
                            'Tap to enter assignment start date...',
                            1,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'start date',
                          ),
                        ],
                      ),
                    ),
                    awesomeDivider(0.8, dividerColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Date:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            endDateController,
                            'Tap to enter assignment end date...',
                            1,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'end date',
                          ),
                        ],
                      ),
                    ),
                    awesomeDivider(0.8, dividerColor),
                    Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'File:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              awesomeTextField(
                                fileController,
                                'No file selected...',
                                1,
                                10,
                                screenWidth / 1.5,
                                TextInputType.multiline,
                                'file',
                                readOnly: true,
                              ),
                              transparentButton("Browse", () async {
                                final result = await FilePicker.platform
                                    .pickFiles(allowMultiple: false);

                                if (result == null) return;
                                final path = result.files.single.path;

                                setState(() => file = File(path));

                                fileController.text = basename(file.path);
                              },
                                  Color.fromRGBO(2, 125, 229, 1),
                                  Color.fromRGBO(2, 125, 229, 1),
                                  screenWidth / 4,
                                  textColor: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: transparentButton("Add Assignment", () async {
                        if (_formKey.currentState.validate()) {
                          model.createAssignment(
                            title: titleController.text.toString(),
                            desc: descController.text.toString(),
                            startDate: startDateController.text.toString(),
                            endDate: endDateController.text.toString(),
                            teachersubjectclassroomID:
                                widget.teachersubjectclassroom.id.toString(),
                            file: file,
                          );
                          await Future.delayed(Duration(seconds: 1));
                          awesomeToast('Assignment Added!');
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => SubjectView(
                                          subject: widget.subject,
                                          classroom: widget.classroom,
                                          teachersubjectclassroom:
                                              widget.teachersubjectclassroom)),
                                  (route) => false);
                        }
                      }, Color.fromRGBO(2, 125, 229, 1),
                          Color.fromRGBO(2, 125, 229, 1), screenWidth - 30,
                          textColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
