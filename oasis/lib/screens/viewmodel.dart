import 'package:stacked/stacked.dart';
import 'package:oasis/app/locator.dart';
import 'package:oasis/models/user.dart';
import 'package:oasis/services/authentication_service.dart';

class ViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;
}
