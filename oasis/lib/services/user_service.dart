import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  static final UserService _instance = UserService._constructor();
  factory UserService() {
    return _instance;
  }

  UserService._constructor();

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  Future<User> getUser({String id}) async {
    final json = await Rest.get('users/$id');
    return User.fromJson(json);
  }

  Future<List<User>> getUsers() async {
    final jsonList = await Rest.get('users');
    final userList = <User>[];

    if (jsonList != null) {
      for (int i = 0; i < jsonList.length; i++) {
        final json = jsonList[i];
        User user = User.fromJson(json);
        userList.add(user);
      }
    }

    return userList;
  }

  Future createUser(User user) async {
    await Rest.post(
      'users/',
      data: {
        'id': user.id,
        'displayName': user.displayName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'type': user.type
      },
    );
  }

  Future<User> updateUser(
      {String id,
      String displayName,
      String phoneNumber,
      String profilePicture}) async {
    if (profilePicture != null) {
      final json = await Rest.patch('users/$id', data: {
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture
      });

      return User.fromJson(json);
    } else {
      final json = await Rest.patch('users/$id',
          data: {'displayName': displayName, 'phoneNumber': phoneNumber});

      return User.fromJson(json);
    }
  }

  Future deleteUser(String id) async {
    await _usersRef.doc(id).delete();
  }
}
