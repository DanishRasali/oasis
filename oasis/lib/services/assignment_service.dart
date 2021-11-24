import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/assignment.dart';

class AssignmentService {
  static final AssignmentService _instance = AssignmentService._constructor();
  factory AssignmentService() {
    return _instance;
  }

  AssignmentService._constructor();

  final CollectionReference _assignmentsRef =
      FirebaseFirestore.instance.collection('assignments');

  Future<List<Assignment>> getAssignments() async {
    final jsonList = await Rest.get('assignments');
    final assignmentList = <Assignment>[];

    if (jsonList != null) {
      for (int i = 0; i < jsonList.length; i++) {
        final json = jsonList[i];
        Assignment assignment = Assignment.fromJson(json);
        assignmentList.add(assignment);
      }
    }

    return assignmentList;
  }

  Future createAssignment(Assignment assignment) async {
    await Rest.post(
      'assignments/',
      data: {
        'title': assignment.title,
        'desc': assignment.desc,
        'startDate': assignment.startDate,
        'endDate': assignment.endDate,
        'teachersubjectclassroomID': assignment.teachersubjectclassroomID,
        'file': assignment.file,
      },
    );
  }

  Future<Assignment> updateAssignment(
      {String id,
      String title,
      String desc,
      String startDate,
      String endDate,
      String file}) async {
    final json = await Rest.patch('assignments/$id', data: {
      'title': title,
      'desc': desc,
      'startDate': startDate,
      'endDate': endDate,
      'file': file
    });

    return Assignment.fromJson(json);
  }

  Future<List<Assignment>> getAssignmentByTeacherSubjectClassroomID(
      String teachersubjectclassroomID) async {
    QuerySnapshot snapshots = await _assignmentsRef
        .where('teachersubjectclassroomID',
            isEqualTo: teachersubjectclassroomID)
        .get();
    return snapshots.docs
        .map((snapshot) => Assignment.fromSnapshot(snapshot))
        .toList();
  }
}
