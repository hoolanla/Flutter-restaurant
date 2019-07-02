import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



void main() => runApp(Login2());

class Login2 extends StatelessWidget {
  /// This is an example app which make use of
  /// `SignInButtonBuilder` and `SignInButton` class
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: SignInPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignInPage extends StatelessWidget {
  /// Normally the signin buttons should be contained in the SignInPage
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    //   Scaffold.of(context).showSnackBar(new SnackBar(
    //   content: new Text('Sign in'),
    //  ));
    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    debugPrint(googleUser.photoUrl);
    debugPrint(googleUser.email);



    /*   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    debugPrint(googleAuth.idToken);
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseUser userDetails = await _firebaseAuth.signInWithCredential(credential);
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);
    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

   UserDetails details = new UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );*/

    // return userDetails;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*    SignInButtonBuilder(
              text: 'Get going with Email',
              icon: Icons.email,
              onPressed: () {},
              backgroundColor: Colors.blueGrey[700],
              width: 200.0,
            ),
            Divider(),*/
            SignInButton(
              Buttons.Google,
              onPressed: () => _signIn(context)
                  .then((FirebaseUser user) => print(user))
                  .catchError((e) => print(e)),
            ),
            SignInButton(
              Buttons.Facebook,
              onPressed: () => initiateFacebookLogin(),
            ),
            Divider(),

          ],
        ),
      ),
    );
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logInWithReadPermissions(['email']);
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

        debugPrint('gggg' + profile.toString());

        onLoginStatusChanged(true);
        break;
    }
  }

  bool isLoggedIn = false;

  void onLoginStatusChanged(bool isLoggedIn) {

    //   setState(() {

    //debugPrint(this.userName.toString());
    this.isLoggedIn = isLoggedIn;


    //  });
  }


}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails,this.userName, this.photoUrl,this.userEmail, this.providerData);
}


class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}