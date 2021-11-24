import 'package:flutter/material.dart';
import 'package:oasis/models/assignment.dart';
import 'package:oasis/models/submission.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/classroom.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import '../../shared/colors.dart';
import 'package:oasis/screens/shared/appBar.dart';
import 'package:oasis/screens/teacherApp/home/submission_widget.dart';

import 'teacher_home_viewmodel.dart';

class SubmissionView extends StatefulWidget {
  SubmissionView(
      {this.subject,
      this.classroom,
      this.teachersubjectclassroom,
      this.assignment});
  final Subject subject;
  final Classroom classroom;
  final TeacherSubjectClassroom teachersubjectclassroom;
  final Assignment assignment;

  @override
  _SubmissionViewState createState() => _SubmissionViewState();
}

class _SubmissionViewState extends State<SubmissionView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TeacherHomeViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => TeacherHomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(context, widget.assignment.title + ' Submissions'),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.empty3
                ? Column(
                    children: [
                      Expanded(child: Center(child: Text('No Data'))),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: model.submissionList == null
                              ? 1
                              : model.submissionList.length,
                          itemBuilder: (context, index) {
                            final submission = model.submissionList[index];

                            if (submission.assignmentID ==
                                widget.assignment.id) {
                              return SubmissionWidget(
                                  subject: widget.subject,
                                  classroom: widget.classroom,
                                  teachersubjectclassroom:
                                      widget.teachersubjectclassroom,
                                  assignment: widget.assignment,
                                  submission: submission,
                                  studentName: model
                                      .getCurrentUser(submission.studentID)
                                      .displayName);
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   backgroundColor: accentColor,
        //   onPressed: () {
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (context) => AddAssignmentView(
        //             subject: widget.subject,
        //             classroom: widget.classroom,
        //             teachersubjectclassroom: widget.teachersubjectclassroom)));
        //   },
        // ),
      ),
    );
  }
}
