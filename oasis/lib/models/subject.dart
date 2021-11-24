import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Subject {
  String _id;
  String _title;
  String _desc;

  get id => _id;
  set id(value) => _id = value;

  get title => _title;
  set title(value) => _title = value;

  get desc => _desc;
  set desc(value) => _desc = value;

  Subject({
    String id,
    String title = '',
    String desc = '',
  })  : _id = id,
        _title = title,
        _desc = desc;

  factory Subject.createNew({String id, String title, String desc}) =>
      Subject(id: id, title: title, desc: desc);

  factory Subject.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Subject.fromJson(json);
  }

  Subject.copy(Subject from)
      : this(id: from.id, title: from.title, desc: from.desc);

  factory Subject.fromRawJson(String str) => Subject.fromJson(jsonDecode(str));

  Subject.fromJson(Map<String, dynamic> json)
      : this(id: json['id'], title: json['title'], desc: json['desc']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {'title': title, 'desc': desc};
}
