import 'package:flutter/material.dart';
import 'package:oasis/screens/teacherApp/home/assignment_widget.dart';
import 'package:oasis/screens/teacherApp/home/addAssignment_view.dart';
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

import 'teacher_home_viewmodel.dart';

class SubjectView extends StatefulWidget {
  SubjectView({this.subject, this.classroom, this.teachersubjectclassroom});
  final Subject subject;
  final Classroom classroom;
  final TeacherSubjectClassroom teachersubjectclassroom;

  @override
  _SubjectViewState createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TeacherHomeViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => TeacherHomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(
            context, widget.subject.title + ' ' + widget.classroom.name),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.empty2
                ? Column(
                    children: [
                      Expanded(child: Center(child: Text('No Data'))),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: model.assignmentList == null
                              ? 1
                              : model.assignmentList.length,
                          itemBuilder: (context, index) {
                            final assignment = model.assignmentList[index];

                            if (assignment.teachersubjectclassroomID ==
                                widget.teachersubjectclassroom.id) {
                              return AssignmentWidget(
                                  subject: widget.subject,
                                  classroom: widget.classroom,
                                  teachersubjectclassroom:
                                      widget.teachersubjectclassroom,
                                  assignment: assignment);
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: accentColor,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddAssignmentView(
                    subject: widget.subject,
                    classroom: widget.classroom,
                    teachersubjectclassroom: widget.teachersubjectclassroom)));
          },
        ),
      ),
    );
  }
}
