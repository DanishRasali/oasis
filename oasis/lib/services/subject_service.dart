import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/subject.dart';

class SubjectService {
  static final SubjectService _instance = SubjectService._constructor();
  factory SubjectService() {
    return _instance;
  }

  SubjectService._constructor();

  final CollectionReference _subjectsRef =
      FirebaseFirestore.instance.collection('subjects');

  Future<Subject> getSubject({String id}) async {
    final json = await Rest.get('subjects/$id');
    return Subject.fromJson(json);
  }

  Future<List<Subject>> getSubjects() async {
    final jsonList = await Rest.get('subjects');
    final subjectList = <Subject>[];

    if (jsonList != null) {
      for (int i = 0; i < jsonList.length; i++) {
        final json = jsonList[i];
        Subject subject = Subject.fromJson(json);
        subjectList.add(subject);
      }
    }

    return subjectList;
  }

  Future createSubject(Subject subject) async {
    await Rest.post(
      'subjects/',
      data: {
        'id': subject.id,
        'title': subject.title,
        'desc': subject.desc,
      },
    );
  }

  Future<Subject> updateSubject({String id, String title, String desc}) async {
    final json =
        await Rest.patch('subjects/$id', data: {'title': title, 'desc': desc});

    return Subject.fromJson(json);
  }

  Future deleteSubject(String id) async {
    await _subjectsRef.doc(id).delete();
  }
}
