import 'package:get_it/get_it.dart';
import 'package:oasis/services/assignment_service.dart';
import 'package:oasis/services/authentication_service.dart';
import 'package:oasis/services/submission_service.dart';
import 'package:oasis/services/user_service.dart';
import 'package:oasis/services/subject_service.dart';
import 'package:oasis/services/classroom_service.dart';
import 'package:oasis/services/teachersubjectclassroom_service.dart';

import 'package:oasis/screens/signin/signin_viewmodel.dart';
import 'package:oasis/screens/signup/signup_viewmodel.dart';
import 'package:oasis/screens/studentApp/home/student_home_viewmodel.dart';
import 'package:oasis/screens/studentApp/profile/student_profile_viewmodel.dart';
import 'package:oasis/screens/teacherApp/home/teacher_home_viewmodel.dart';
import 'package:oasis/screens/teacherApp/profile/teacher_profile_viewmodel.dart';

final GetIt locator = GetIt.instance;

void initializeLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => SubjectService());
  locator.registerLazySingleton(() => ClassroomService());
  locator.registerLazySingleton(() => TeacherSubjectClassroomService());
  locator.registerLazySingleton(() => AssignmentService());
  locator.registerLazySingleton(() => SubmissionService());

  locator.registerLazySingleton(() => SignInViewModel());
  locator.registerLazySingleton(() => SignUpViewModel());
  locator.registerLazySingleton(() => TeacherHomeViewModel());
  locator.registerLazySingleton(() => TeacherProfileViewModel());
  locator.registerLazySingleton(() => StudentHomeViewModel());
  locator.registerLazySingleton(() => StudentProfileViewModel());
}
