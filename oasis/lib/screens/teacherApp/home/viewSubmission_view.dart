import 'dart:io';

import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oasis/models/assignment.dart';
import 'package:oasis/models/submission.dart';
import 'package:oasis/models/classroom.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:oasis/screens/teacherApp/home/subject_view.dart';
import 'package:oasis/screens/teacherApp/home/submission_view.dart';
import 'package:oasis/screens/teacherApp/home/updateAssignment_view.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
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

class ViewSubmissionView extends StatefulWidget {
  const ViewSubmissionView(
      {this.subject,
      this.classroom,
      this.teachersubjectclassroom,
      this.assignment,
      this.submission,
      this.studentName});

  final Subject subject;
  final Classroom classroom;
  final TeacherSubjectClassroom teachersubjectclassroom;
  final Assignment assignment;
  final Submission submission;
  final String studentName;

  @override
  _ViewSubmissionViewState createState() => _ViewSubmissionViewState();
}

class _ViewSubmissionViewState extends State<ViewSubmissionView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController fileController = TextEditingController();
  TextEditingController tpController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // File _imageFile;

  // Future<void> _pickImage(ImageSource source) async {
  //   PickedFile selected = await ImagePicker().getImage(source: source);

  //   setState(() {
  //     _imageFile = File(selected.path);
  //   });
  // }

  // void _clear() {
  //   setState(() {
  //     _imageFile = null;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.studentName);
    dateController = TextEditingController(text: widget.submission.submitDate);
    fileController = TextEditingController(text: widget.submission.file);
    tpController = TextEditingController(text: widget.submission.tp);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<TeacherHomeViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => TeacherHomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: buildSectionBar(context, widget.studentName + ' Submission'),
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
                            'Student name:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            nameController,
                            'Tap to enter student name...',
                            1,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'name',
                            readOnly: true,
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
                            'Submitted Date:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            dateController,
                            'Tap to enter submitted date...',
                            1,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'date',
                            readOnly: true,
                          ),
                        ],
                      ),
                    ),
                    awesomeDivider(0.8, dividerColor),
                    InkWell(
                      child: Container(
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
                          awesomeTextField(
                            fileController,
                            'No submission...',
                            1,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'file',
                            readOnly: true,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                        openFile(
                          url: widget.submission.file.toString(),
                          fileName: widget.studentName.toString(),
                        );
                      },
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
                            'Tahap Penguasaan:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          awesomeTextField(
                            tpController,
                            'Unevaluated',
                            1,
                            10,
                            screenWidth,
                            TextInputType.multiline,
                            'tp',
                            readOnly: false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: transparentButton("Evaluate Submission", () async {
                        if (_formKey.currentState.validate()) {
                          model.evaluateSubmission(
                            id: widget.submission.id,
                            tp: tpController.text.toString(),
                          );
                          await Future.delayed(Duration(seconds: 1));
                          awesomeToast('Submission Evaluated!');
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => SubmissionView(
                                          subject: widget.subject,
                                          classroom: widget.classroom,
                                          teachersubjectclassroom:
                                              widget.teachersubjectclassroom,
                                          assignment: widget.assignment)),
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

  Future openFile({String url, String fileName}) async {
    final file = await downloadFile(url, fileName);

    if (file == null) return;

    OpenFile.open(file.path);
  }

  Future<File> downloadFile(String url, String fileName) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/' + basename(url));

    try {
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }
}
