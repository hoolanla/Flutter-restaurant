import 'dart:async';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

//  UserServices _userServices = UserServices();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String gender;
  String groupValue = "male";
  bool hidePass = true;
  bool loading = false;
  FocusNode passwordFocusNode = new FocusNode();
  FocusNode emailFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.withOpacity(0.2),
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: ListTile(
                    title: TextFormField(
                      controller: _nameTextController,
                      decoration: InputDecoration(
                          hintText: "Full name",
                          icon: Icon(Icons.person_outline),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "The name field cannot be empty";
                        }
                        return null;
                      },
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(emailFocusNode);
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.withOpacity(0.2),
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: ListTile(
                    title: TextFormField(
                      controller: _emailTextController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          icon: Icon(Icons.alternate_email),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value.isEmpty) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(value))
                            return 'Please make sure your email address is valid';
                          else
                            return null;
                        }
                      },
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                      focusNode: emailFocusNode,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.withOpacity(0.2),
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: ListTile(
                    title: TextFormField(
                      controller: _passwordTextController,
                      obscureText: hidePass,
                      decoration: InputDecoration(
                          hintText: "Password",
                          icon: Icon(Icons.lock_outline),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "The password field cannot be empty";
                        } else if (value.length < 6) {
                          return "the password has to be at least 6 characters long";
                        }
                        return null;
                      },
                      focusNode: passwordFocusNode,
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          setState(() {
                            hidePass = false;
                          });
                        }),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
              child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.green,
                  elevation: 0.0,
                  child: MaterialButton(
                      onPressed: () async{
                              //  validateForm();
                              },
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      "Sign up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "I already have an account",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ))),
          ],
        ),

        /*      Visibility(
            visible: loading ?? true,
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
      ),
    );
  }

/*  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender = e;
      } else if (e == "female") {
        groupValue = e;
        gender = e;
      }
    });
  }*/

/*  Future validateForm() async {
    FormState formState = _formKey.currentState;

    if (formState.validate()) {
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text)
         .then((user) => {
   */ /*     _userServices.createUser(
              {
                "username": _nameTextController.text,
                "email": _emailTextController.text,
                "userId": user.uid,
                "gender": gender,*/ /*
              }
          )
        }).catchError((err) => {print('error is: '+ err.toString())});
*/ /*
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));*/ /*

      }
    }*/
}
