import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Assignment {
  String _id;
  String _title;
  String _desc;
  String _startDate;
  String _endDate;
  String _teachersubjectclassroomID;
  String _file;

  get id => _id;
  set id(value) => _id = value;

  get desc => _desc;
  set desc(value) => _desc = value;

  get title => _title;
  set title(value) => _title = value;

  get startDate => _startDate;
  set startDate(value) => _startDate = value;

  get endDate => _endDate;
  set endDate(value) => _endDate = value;

  get teachersubjectclassroomID => _teachersubjectclassroomID;
  set teachersubjectclassroomID(value) => _teachersubjectclassroomID = value;

  get file => _file;
  set file(value) => _file = value;

  Assignment({
    String id,
    String title = '',
    String desc = '',
    String startDate = '',
    String endDate = '',
    String teachersubjectclassroomID = '',
    String file = '',
  })  : _id = id,
        _title = title,
        _desc = desc,
        _startDate = startDate,
        _endDate = endDate,
        _teachersubjectclassroomID = teachersubjectclassroomID,
        _file = file;

  factory Assignment.createNew(
          {String id,
          String title,
          String desc,
          String startDate,
          String endDate,
          String teachersubjectclassroomID,
          String file}) =>
      Assignment(
          id: id,
          title: title,
          desc: desc,
          startDate: startDate,
          endDate: endDate,
          teachersubjectclassroomID: teachersubjectclassroomID,
          file: file);

  factory Assignment.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Assignment.fromJson(json);
  }

  Assignment.copy(Assignment from)
      : this(
            id: from.id,
            title: from.title,
            desc: from.desc,
            startDate: from.startDate,
            endDate: from.endDate,
            teachersubjectclassroomID: from.teachersubjectclassroomID,
            file: from.file);

  factory Assignment.fromRawJson(String str) =>
      Assignment.fromJson(jsonDecode(str));

  Assignment.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            title: json['title'],
            desc: json['desc'],
            startDate: json['startDate'],
            endDate: json['endDate'],
            teachersubjectclassroomID: json['teachersubjectclassroomID'],
            file: json['file']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'title': title,
        'desc': desc,
        'startDate': startDate,
        'endDate': endDate,
        'teachersubjectclassroomID': teachersubjectclassroomID,
        'file': file
      };
}
