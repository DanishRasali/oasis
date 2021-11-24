import 'package:flutter/material.dart';
import 'package:oasis/screens/teacherApp/home/subject_widget.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import '../../shared/my_toast.dart';
import 'package:oasis/screens/shared/appBar.dart';

import 'teacher_home_viewmodel.dart';

class TeacherHomeView extends StatefulWidget {
  TeacherHomeView();

  @override
  _TeacherHomeViewState createState() => _TeacherHomeViewState();
}

class _TeacherHomeViewState extends State<TeacherHomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TeacherHomeViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => TeacherHomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(context, 'Classes'),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : model.empty
                ? Column(
                    children: [
                      Expanded(child: Center(child: Text('No Data'))),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: model.teachersubjectclassroomList == null
                              ? 1
                              : model.teachersubjectclassroomList.length,
                          itemBuilder: (context, index) {
                            final tsc =
                                model.teachersubjectclassroomList[index];
                            return SubjectWidget(
                                subject: model.getSubject(tsc.subjectID),
                                classroom: model.getClassroom(tsc.classroomID),
                                teachersubjectclassroom: tsc);
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
