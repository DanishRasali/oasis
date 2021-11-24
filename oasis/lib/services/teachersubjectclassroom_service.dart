import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/teachersubjectclassroom.dart';

class TeacherSubjectClassroomService {
  static final TeacherSubjectClassroomService _instance =
      TeacherSubjectClassroomService._constructor();
  factory TeacherSubjectClassroomService() {
    return _instance;
  }

  TeacherSubjectClassroomService._constructor();

  final CollectionReference _teachersubjectclassroomRef =
      FirebaseFirestore.instance.collection('teachersubjectclassrooms');

  Future createTeacherSubjectClassroom(
      TeacherSubjectClassroom teachersubjectclassroom) async {
    await Rest.post(
      'teachersubjectclassrooms/',
      data: {
        'teacherID': teachersubjectclassroom.teacherID,
        'subjectID': teachersubjectclassroom.subjectID,
        'classroomID': teachersubjectclassroom.classroomID
      },
    );
  }

  Future<List<TeacherSubjectClassroom>> getTeacherSubjectClassroomsByTeacherID(
      String teacherID) async {
    QuerySnapshot snapshots = await _teachersubjectclassroomRef
        .where('teacherID', isEqualTo: teacherID)
        .get();
    return snapshots.docs
        .map((snapshot) => TeacherSubjectClassroom.fromSnapshot(snapshot))
        .toList();
  }
}
