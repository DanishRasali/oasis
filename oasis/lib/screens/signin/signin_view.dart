import 'package:flutter/material.dart';
import 'package:oasis/screens/shared/colors.dart';
import 'package:oasis/screens/shared/styles.dart';
import 'package:stacked/stacked.dart';
import 'signin_viewmodel.dart';
import 'package:oasis/screens/shared/buttons.dart';

class SignInView extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => SignInView());

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _showPassword = false;

  get email => _email;
  set email(value) => setState(() => _email = value);

  get password => _password;
  set password(value) => setState(() => _password = value);

  get showPassword => _showPassword;
  set showPassword(value) => setState(() => _showPassword = value);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => SignInViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 150.0),
                    Center(
                      child: Image.asset(
                        'assets/images/oasis_logo.png',
                        height: 125,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _builtMyText(),
                    Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            autocorrect: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                labelText: 'EMAIL',
                                labelStyle: greyBoldText,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(3, 161, 164, 1)))),
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty ||
                                  !value.contains('@') ||
                                  !value.contains('.')) {
                                return ('Please enter a valid email address');
                              }
                            },
                            onChanged: (value) => email = value,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            obscureText: !showPassword,
                            decoration: InputDecoration(
                                labelText: 'PASSWORD',
                                labelStyle: greyBoldText,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off_outlined,
                                    color: showPassword
                                        ? Colors.black54
                                        : Colors.black38,
                                  ),
                                  onPressed: () => showPassword = !showPassword,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(3, 161, 164, 1)))),
                            validator: (value) =>
                                value.isEmpty ? 'Password is empty' : null,
                            onChanged: (value) => password = value,
                          ),
                          SizedBox(height: 40.0),
                          BusyButton(
                            height: 40.0,
                            busy: model.isBusy,
                            title: 'SIGN-IN',
                            onPressed: () async {
                              if (_formKey.currentState.validate())
                                model.signIn(
                                    email: email,
                                    password: password,
                                    context: context);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Haven\'t signed up?',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                            ),
                          ),
                          SizedBox(width: 5.0),
                          InkWell(
                            onTap: () {
                              model.navigateToSignUp(context);
                            },
                            child: Text(
                              'Sign-Up',
                              style: TextStyle(
                                  color: accentColor,
                                  fontFamily: 'Segoe UI',
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _builtMyText() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Text('OASIS',
                style: TextStyle(
                    color: accentColor,
                    fontFamily: 'Philosopher',
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
