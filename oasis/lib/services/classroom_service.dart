import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/classroom.dart';

class ClassroomService {
  static final ClassroomService _instance = ClassroomService._constructor();
  factory ClassroomService() {
    return _instance;
  }

  ClassroomService._constructor();

  final CollectionReference _classroomsRef =
      FirebaseFirestore.instance.collection('classrooms');

  Future<Classroom> getClassroom({String id}) async {
    final json = await Rest.get('classrooms/$id');
    return Classroom.fromJson(json);
  }

  Future<List<Classroom>> getClassrooms() async {
    final jsonList = await Rest.get('classrooms');
    final classroomList = <Classroom>[];

    if (jsonList != null) {
      for (int i = 0; i < jsonList.length; i++) {
        final json = jsonList[i];
        Classroom classroom = Classroom.fromJson(json);
        classroomList.add(classroom);
      }
    }

    return classroomList;
  }

  Future createClassroom(Classroom classroom) async {
    await Rest.post(
      'classrooms/',
      data: {
        'id': classroom.id,
        'name': classroom.name,
      },
    );
  }

  Future<Classroom> updateClassroom({String id, String name}) async {
    final json = await Rest.patch('classrooms/$id', data: {'name': name});

    return Classroom.fromJson(json);
  }

  Future deleteClassroom(String id) async {
    await _classroomsRef.doc(id).delete();
  }
}
