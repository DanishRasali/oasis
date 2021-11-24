import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String _id;
  String _email;
  String _displayName;
  String _password;
  String _phoneNumber;
  String _profilePicture;
  String _type;

  get id => _id;
  set id(value) => _id = value;

  get displayName => _displayName;
  set displayName(value) => _displayName = value;

  get email => _email;
  set email(value) => _email = value;

  get password => _password;
  set password(value) => _password = value;

  get phoneNumber => _phoneNumber;
  set phoneNumber(value) => _phoneNumber = value;

  get profilePicture => _profilePicture;
  set profilePicture(value) => _profilePicture = value;

  get type => _type;
  set type(value) => _type = value;

  User(
      {String id,
      String displayName = '',
      String email = '',
      String password = '',
      String phoneNumber = '',
      String profilePicture = '',
      String type = ''})
      : _id = id,
        _displayName = displayName,
        _email = email,
        _password = password,
        _phoneNumber = phoneNumber,
        _profilePicture = profilePicture,
        _type = type;

  factory User.createNew(
          {String id,
          String displayName,
          String email,
          String password,
          String phoneNumber,
          String profilePicture,
          String type}) =>
      User(
          id: id,
          displayName: displayName,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          profilePicture: profilePicture,
          type: type);

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data();
    json['id'] = snapshot.id;
    return User.fromJson(json);
  }

  User.copy(User from)
      : this(
            id: from.id,
            displayName: from.displayName,
            email: from.email,
            password: from.password,
            phoneNumber: from.phoneNumber,
            profilePicture: from.profilePicture,
            type: from.type);

  factory User.fromRawJson(String str) => User.fromJson(jsonDecode(str));

  User.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            displayName: json['displayName'],
            email: json['email'],
            password: json['password'],
            phoneNumber: json['phoneNumber'],
            profilePicture: json['profilePicture'],
            type: json['type']);

  String toRawJson() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
        'type': type
      };
}
