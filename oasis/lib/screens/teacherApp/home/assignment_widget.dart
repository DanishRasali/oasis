import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oasis/models/classroom.dart';
import 'package:oasis/models/teachersubjectclassroom.dart';
import 'package:oasis/models/user.dart';
import 'package:oasis/models/subject.dart';
import 'package:oasis/models/assignment.dart';
import 'package:oasis/screens/shared/colors.dart';
import 'package:oasis/screens/teacherApp/home/updateAssignment_view.dart';
import 'package:oasis/screens/teacherApp/home/viewAssignment_view.dart';

class AssignmentWidget extends StatelessWidget {
  AssignmentWidget(
      {this.subject,
      this.classroom,
      this.teachersubjectclassroom,
      this.assignment});

  final Subject subject;
  final Classroom classroom;
  final TeacherSubjectClassroom teachersubjectclassroom;
  final Assignment assignment;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, bottom: 3.0, top: 15.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
            border: Border.symmetric(
              horizontal: BorderSide(
                width: 0.5,
                color: dividerColor,
              ),
              vertical: BorderSide(
                width: 0.5,
                color: dividerColor,
              ),
            ),
          ),
          padding: EdgeInsets.only(bottom: 10.5),
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewAssignmentView(
                            subject: subject,
                            classroom: classroom,
                            teachersubjectclassroom: teachersubjectclassroom,
                            assignment: assignment)));
              },
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Image.asset('assets/images/assignment.png', width: 45),
                  ),
                  Expanded(
                    child: ListTile(
                      dense: true,
                      title: Text(
                        assignment.startDate + ' - ' + assignment.endDate,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w900),
                      ),
                      subtitle: Container(
                        padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              assignment.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
