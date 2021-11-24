import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeacherSubjectClassroom {
  String _id;
  String _teacherID;
  String _subjectID;
  String _classroomID;

  get id => _id;
  set id(value) => _id = value;

  get teacherID => _teacherID;
  set teacherID(value) => _teacherID = value;

  get subjectID => _subjectID;
  set subjectID(value) => _subjectID = value;

  get classroomID => _classroomID;
  set classroomID(value) => _classroomID = value;

  TeacherSubjectClassroom({
    String id,
    String teacherID = '',
    String subjectID = '',
    String classroomID = '',
  })  : _id = id,
        _teacherID = teacherID,
        _subjectID = subjectID,
        _classroomID = classroomID;

  factory TeacherSubjectClassroom.createNew(
          {String id,
          String teacherID,
          String subjectID,
          String classroomID}) =>
      TeacherSubjectClassroom(
          id: id,
          teacherID: teacherID,
          subjectID: subjectID,
          classroomID: classroomID);

  factory TeacherSubjectClassroom.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return TeacherSubjectClassroom.fromJson(json);
  }

  TeacherSubjectClassroom.copy(TeacherSubjectClassroom from)
      : this(
            id: from.id,
            teacherID: from.teacherID,
            subjectID: from.subjectID,
            classroomID: from.classroomID);

  factory TeacherSubjectClassroom.fromRawJson(String str) =>
      TeacherSubjectClassroom.fromJson(jsonDecode(str));

  TeacherSubjectClassroom.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            teacherID: json['teacherID'],
            subjectID: json['subjectID'],
            classroomID: json['classroomID']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'teacherID': teacherID,
        'subjectID': subjectID,
        'classroomID': classroomID
      };
}
