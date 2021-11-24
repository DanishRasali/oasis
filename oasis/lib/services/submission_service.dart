import 'package:oasis/models/submission.dart';

import 'rest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/assignment.dart';

class SubmissionService {
  static final SubmissionService _instance = SubmissionService._constructor();
  factory SubmissionService() {
    return _instance;
  }

  SubmissionService._constructor();

  final CollectionReference _submissionsRef =
      FirebaseFirestore.instance.collection('submissions');

  Future<List<Submission>> getSubmissions() async {
    final jsonList = await Rest.get('submissions');
    final submissionList = <Submission>[];

    if (jsonList != null) {
      for (int i = 0; i < jsonList.length; i++) {
        final json = jsonList[i];
        Submission submission = Submission.fromJson(json);
        submissionList.add(submission);
      }
    }

    return submissionList;
  }

  Future createSubmission(Submission submission) async {
    await Rest.post(
      'submissions/',
      data: {
        'studentID': submission.studentID,
        'assignmentID': submission.assignmentID,
        'submitDate': submission.submitDate,
        'file': submission.file,
        'tp': submission.tp,
      },
    );
  }

  Future<List<Submission>> getSubmissionByAssignmentID(
      String assignmentID) async {
    QuerySnapshot snapshots = await _submissionsRef
        .where('assignmentID', isEqualTo: assignmentID)
        .get();
    return snapshots.docs
        .map((snapshot) => Submission.fromSnapshot(snapshot))
        .toList();
  }

  Future<Submission> evaluateSubmission({String id, String tp}) async {
      final json = await Rest.patch('submissions/$id',
          data: {'tp': tp,});

      return Submission.fromJson(json);
  }
}
