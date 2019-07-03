import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'signup.dart';
import 'package:online_store/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_store/services/authService.dart';
import 'package:online_store/screens/home/home.dart';
import 'package:validators/validators.dart';

final User _user = new User();

final String DISPLAYNAME = "displayName";
final String IMAGEPATH = "imagePath";
final String IS_LOGIN = "is_login";

void main() => runApp(Login());

class Login extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<Login> {
  AuthService authService = AuthService();

  // Widget page = Login();

  final _formKey = GlobalKey<FormState>();
  bool hidePass = true;
  bool _result = false;
  FocusNode passwordFocusNode = FocusNode();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    _user.Displayname = googleUser.displayName;
    _user.imagePath = googleUser.photoUrl;

    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(DISPLAYNAME, googleUser.displayName);
    _pref.setString(IMAGEPATH, googleUser.photoUrl);
    _pref.setBool(IS_LOGIN, true);

    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new Home()));
  }

  @override
  Widget build(BuildContext context) {


    void _showAlertDialog() async {
      showDialog(context: context,
      barrierDismissible: false,
        builder: (context){
        return AlertDialog(
          title: Text("Username or Password is in correct"),
          content: Text("Please try again."),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            )
          ],
        );
        });
    }


    void _submit() async {
      if (this._formKey.currentState.validate()) {
        _formKey.currentState.save();
        SharedPreferences _pref = await SharedPreferences.getInstance();
        debugPrint(_user.email);
        authService.LoginEmail(user: _user).then((result){
          _result = result;
          if (_result) {
            _pref.setString(DISPLAYNAME, "MR.EMAIL");
            _pref.setString(IMAGEPATH,
                'http://www.pathstoliteracy.org/sites/pathstoliteracy.perkinsdev1.org/files/styles/full_post_view/public/uploaded-images/squeaky.jpg?itok=LVyd5YPB');
            _pref.setBool(IS_LOGIN, true);
            onLoginStatusChanged(true);
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => new Home()));


          }
          else {
            _showAlertDialog();
          }
        });
      }
    }
    double height = MediaQuery
        .of(context)
        .size
        .height / 3;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 120.0,
//                height: 240.0,
                  )),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Center(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.withOpacity(0.2),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: ListTile(
                                title: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    icon: Icon(Icons.alternate_email),
                                  ),
                                  validator: _validateEmail,
                                  onSaved: (String value) {
                                    _user.email = value;
                                  },
                                  onFieldSubmitted: (String value) {
                                    FocusScope.of(context)
                                        .requestFocus(passwordFocusNode);
                                  },
                                ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.withOpacity(0.2),
                              elevation: 0.0,
                              child: Padding(

                                padding: const EdgeInsets.only(left: 12.0),
                                child: ListTile(
                                  title: TextFormField(
                                    // controller: _passwordTextController,
                                    focusNode: passwordFocusNode,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      icon: Icon(Icons.lock_outline),

                                    ),
                                    obscureText: hidePass,
                                    validator: _validatePassword,
                                    onSaved: (String value) {
                                      _user.password = value;
                                    },
                                    onFieldSubmitted: (String value) {},

                                  ),
                                  trailing: IconButton(
                                      icon: Icon(Icons.remove_red_eye),
                                      onPressed: () {
                                        setState(() {
                                          hidePass = !hidePass;
                                        });
                                      }),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.green,
                                elevation: 0.0,
                                child: MaterialButton(
                                  onPressed: _submit,

                                  minWidth: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Forgot password",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignUp(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Create an account",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black),
                                      ))),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Or",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                    child: MaterialButton(
                                        onPressed: () =>
                                            initiateFacebookLogin(context),
                                        child: Image.asset(
                                          "assets/images/fb.png",
                                          width: 60,
                                        ))),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                    child: MaterialButton(
                                        onPressed: () =>
                                            _signIn(context)
                                                .then((FirebaseUser user) =>
                                                print(user))
                                                .catchError((e) => print(e)),
                                        child: Image.asset(
                                          "assets/images/ggg.png",
                                          width: 60,
                                        ))),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ),
            /*       Visibility(
            //  visible: loading ?? true,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.9),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              ),
            )*/
          ],
        ),
      ),
    );


  }





  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "Email is empty.";
    }
    if (!isEmail(value)) {
      return "Email must must be valid email pattern.";
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 6) {
      return "Password must 6 charactors.";
    }
    return null;
  }


}


void initiateFacebookLogin(BuildContext context) async {
  var facebookLogin = FacebookLogin();
  var facebookLoginResult =
  await facebookLogin.logInWithReadPermissions(['email']);
  switch (facebookLoginResult.status) {
    case FacebookLoginStatus.error:
      print("Error");
      onLoginStatusChanged(false);
      break;
    case FacebookLoginStatus.cancelledByUser:
      print("CancelledByUser");
      onLoginStatusChanged(false);
      break;
    case FacebookLoginStatus.loggedIn:
      var graphResponse = await http.get(
          'https://graph.facebook.com/v3.3/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult
              .accessToken.token}');
      var profile = json.decode(graphResponse.body);

      Map<String, dynamic> itemJson = profile;
      print(itemJson['name']);
      print(itemJson.toString());

      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString(DISPLAYNAME, itemJson['name']);
      _pref.setString(IMAGEPATH,
          'http://www.pathstoliteracy.org/sites/pathstoliteracy.perkinsdev1.org/files/styles/full_post_view/public/uploaded-images/squeaky.jpg?itok=LVyd5YPB');
      _pref.setBool(IS_LOGIN, true);
      onLoginStatusChanged(true);
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => new Home()));
      //    Navigator.of(context).pushNamed('~/screens/home/home.dart');
      break;
  }
}

bool isLoggedIn = false;

void onLoginStatusChanged(bool isLoggedIn) {
  isLoggedIn = isLoggedIn;
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);

  final String providerDetails;
}
