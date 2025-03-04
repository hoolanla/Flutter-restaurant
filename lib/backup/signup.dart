import 'dart:async';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:online_store/models/register.dart';
import 'package:online_store/screens/Json/foods.dart';



class SignUp extends StatefulWidget {
  final String userName;
  final String email;


  SignUp(
      {this.userName,
        this.email,
      });



  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  Register _reg;
  String username;
  String email;
  String password;

  String gender;
  String groupValue = "male";
  bool hidePass = true;
  bool loading = false;
  FocusNode passwordFocusNode = new FocusNode();
  FocusNode emailFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {


    void _showAlertDialog() async {
      showDialog(context: context,
          barrierDismissible: false,
          builder: (context){
            return AlertDialog(
              title: Text("Account is registration success."),
              content: Text("Thank you."),
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

    void ttt(String strAll) async {
      var feed = await NetworkFoods.insertRegister(strBody: strAll);
      var data = DataFeed(feed: feed);
      if (data.feed.ResultOk.toString() == "true") {

      } else {}
    }

    void SendtoJson({String email,String password,String username}) async{

      String strBody = '{"email":"${email}","password":"${password}","username":"${username}"}';
      var feed = await NetworkFoods.insertRegister(strBody: strBody);
      var data = DataFeed(feed: feed);
      if (data.feed.ResultOk.toString() == "true") {

      } else {

      }
    }

    void _submit() async {
      if (this._formKey.currentState.validate()) {
        _formKey.currentState.save();
        //todo


        SendtoJson(email:  email,password: password,username: username);

        _showAlertDialog();
      }
    }



    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 10),
        child: Form(
          key: _formKey,
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
                        decoration: InputDecoration(
                            hintText: "Full name",
                            icon: Icon(Icons.person_outline),
                            border: InputBorder.none),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "The name field cannot be empty";
                          }
                        },
                        onSaved: (String value){
                          username = value;
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
                        decoration: InputDecoration(
                            hintText: "Email",
                            icon: Icon(Icons.alternate_email),
                            border: InputBorder.none),
                        validator: _validateEmail,
                        onSaved: (String value) {
                          email = value;
                        },
                        onFieldSubmitted: (String value) {
                          FocusScope.of(context)
                              .requestFocus(passwordFocusNode);
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
                        obscureText: hidePass,
                        decoration: InputDecoration(
                            hintText: "Password",
                            icon: Icon(Icons.lock_outline),
                            border: InputBorder.none),
                        validator: _validatePassword,
                        onSaved: (String value) {
                          password = value;
                        },
                        focusNode: passwordFocusNode,
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
                padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.green,
                    elevation: 0.0,
                    child: MaterialButton(
                      onPressed: _submit,
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        'Sign up',
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

  String _validateName(String value) {
    if (value.isEmpty) {
      return "Name is empty.";
    }
    return null;
  }
}

class DataFeed {
  RetRegister feed;
  DataFeed({this.feed});
}