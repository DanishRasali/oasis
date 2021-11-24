import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Submission {
  String _id;
  String _studentID;
  String _assignmentID;
  String _submitDate;
  String _file;
  String _tp;

  get id => _id;
  set id(value) => _id = value;

  get studentID => _studentID;
  set studentID(value) => _studentID = value;

  get assignmentID => _assignmentID;
  set assignmentID(value) => _assignmentID = value;

  get submitDate => _submitDate;
  set submitDate(value) => _submitDate = value;

  get file => _file;
  set file(value) => _file = value;

  get tp => _tp;
  set tp(value) => _tp = value;

  Submission({
    String id,
    String studentID = '',
    String assignmentID = '',
    String submitDate = '',
    String file = '',
    String tp = '',
  })  : _id = id,
        _studentID = studentID,
        _assignmentID = assignmentID,
        _submitDate = submitDate,
        _file = file,
        _tp = tp;

  factory Submission.createNew(
          {String id,
          String studentID,
          String assignmentID,
          String submitDate,
          String file,
          String tp}) =>
      Submission(
          id: id,
          studentID: studentID,
          assignmentID: assignmentID,
          submitDate: submitDate,
          file: file,
          tp: tp);

  factory Submission.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Submission.fromJson(json);
  }

  Submission.copy(Submission from)
      : this(
            id: from.id,
            studentID: from.studentID,
            assignmentID: from.assignmentID,
            submitDate: from.submitDate,
            file: from.file,
            tp: from.tp);

  factory Submission.fromRawJson(String str) =>
      Submission.fromJson(jsonDecode(str));

  Submission.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            studentID: json['studentID'],
            assignmentID: json['assignmentID'],
            submitDate: json['submitDate'],
            file: json['file'],
            tp: json['tp']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'studentID': studentID,
        'assignmentID': assignmentID,
        'submitDate': submitDate,
        'file': file,
        'tp': tp,
      };
}
