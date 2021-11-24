import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Classroom {
  String _id;
  String _name;

  get id => _id;
  set id(value) => _id = value;

  get name => _name;
  set name(value) => _name = value;

  Classroom({
    String id,
    String name = '',
  })  : _id = id,
        _name = name;

  factory Classroom.createNew({String id, String name}) =>
      Classroom(id: id, name: name);

  factory Classroom.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return Classroom.fromJson(json);
  }

  Classroom.copy(Classroom from) : this(id: from.id, name: from.name);

  factory Classroom.fromRawJson(String str) =>
      Classroom.fromJson(jsonDecode(str));

  Classroom.fromJson(Map<String, dynamic> json)
      : this(id: json['id'], name: json['name']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {'name': name};
}
