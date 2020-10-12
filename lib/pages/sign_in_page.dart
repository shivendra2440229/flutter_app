// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/Routes.dart';
import 'package:flutter_app/drawer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter_signin_button/flutter_signin_button.dart';

//final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  Routes route = new Routes();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print("here ${snapshot.error}");
            return Container();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(debugShowCheckedModeBanner: false,
                routes: route.routes(context),
                home:Scaffold(
                drawer:MyDrawer(),

                appBar: AppBar(
                  title: Text("Sign In"),
                ),
                body: isSignIn
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(_user.photoURL),
                      ),
                      Text(_user.displayName),
                      OutlineButton(
                        onPressed: () {
                          gooleSignout();
                        },
                        child: Text("Logout"),
                      )
                    ],
                  ),
                )
                    : Center(
                  child:
//              _PhoneSignInSection(Scaffold.of(context)),
                  OutlineButton(
                    onPressed: () {
                      handleSignIn();
                    },
                    child: Text("SignIn with Goolge"),
                  ),
                )));
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return CircularProgressIndicator();
        },
      ),
    );
  }
  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = (await _auth.signInWithCredential(credential));

    _user = result.user;

    setState(() {
      isSignIn = true;
    });
  }

  Future<void> gooleSignout() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState(() {
        isSignIn = false;
      });
    });
  }

  bool isSignIn = false;

}



/// Entrypoint example for various sign-in flows with Firebase.
//class SignInPage extends StatefulWidget {
//  /// The page title.
//  final String title = 'Sign In & Out';
//
//  @override
//  State<StatefulWidget> createState() => _SignInPageState();
//}
//
//class _SignInPageState extends State<SignInPage> {
//  GoogleSignIn _googleSignIn = new GoogleSignIn();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//        actions: <Widget>[
//          Builder(builder: (BuildContext context) {
//            return FlatButton(
//              child: const Text('Sign out'),
//              textColor: Theme.of(context).buttonColor,
//              onPressed: () async {
//                final User user = await _auth.currentUser;
//                if (user == null) {
//                  Scaffold.of(context).showSnackBar(const SnackBar(
//                    content: Text('No one has signed in.'),
//                  ));
//                  return;
//                }
//                _signOut();
//                final String uid = user.uid;
//                Scaffold.of(context).showSnackBar(SnackBar(
//                  content: Text(uid + ' has successfully signed out.'),
//                ));
//              },
//            );
//          })
//        ],
//      ),
//      body: Builder(builder: (BuildContext context) {
//        return ListView(
//          padding: EdgeInsets.all(8),
//          scrollDirection: Axis.vertical,
//          children: <Widget>[
//            _PhoneSignInSection(Scaffold.of(context)),
//          ],
//        );
//      }),
//    );
//  }
//
//
//  // Example code for sign out.
//  void _signOut() async {
//    await _auth.signOut();
//  }
//}
//
//class _PhoneSignInSection extends StatefulWidget {
//  _PhoneSignInSection(this._scaffold);
//
//  final ScaffoldState _scaffold;
//
//  @override
//  State<StatefulWidget> createState() => _PhoneSignInSectionState();
//}
//
//class _PhoneSignInSectionState extends State<_PhoneSignInSection> {
//  final TextEditingController _phoneNumberController = TextEditingController();
//  final TextEditingController _smsController = TextEditingController();
//
//  String _message = '';
//  String _verificationId;
//
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//      child: Padding(
//          padding: EdgeInsets.all(16),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Container(
//                child: const Text('Test sign in with phone number',
//                    style: TextStyle(fontWeight: FontWeight.bold)),
//                alignment: Alignment.center,
//              ),
//              TextFormField(
//                controller: _phoneNumberController,
//                decoration: const InputDecoration(
//                    labelText: 'Phone number (+x xxx-xxx-xxxx)'),
//                validator: (String value) {
//                  if (value.isEmpty) {
//                    return 'Phone number (+x xxx-xxx-xxxx)';
//                  }
//                  return null;
//                },
//              ),
//              Container(
//                padding: const EdgeInsets.symmetric(vertical: 16.0),
//                alignment: Alignment.center,
//                child: SignInButtonBuilder(
//                  icon: Icons.contact_phone,
//                  backgroundColor: Colors.deepOrangeAccent[700],
//                  text: "Verify Number",
//                  onPressed: () async {
//                    _verifyPhoneNumber();
//                  },
//                ),
//              ),
//              TextField(
//                controller: _smsController,
//                decoration:
//                const InputDecoration(labelText: 'Verification code'),
//              ),
//              Container(
//                padding: const EdgeInsets.only(top: 16.0),
//                alignment: Alignment.center,
//                child: SignInButtonBuilder(
//                    icon: Icons.phone,
//                    backgroundColor: Colors.deepOrangeAccent[400],
//                    onPressed: () async {
//                      _signInWithPhoneNumber();
//                    },
//                    text: 'Sign In'),
//              ),
//              Visibility(
//                visible: _message == null ? false : true,
//                child: Container(
//                  alignment: Alignment.center,
//                  padding: const EdgeInsets.symmetric(horizontal: 16),
//                  child: Text(
//                    _message,
//                    style: TextStyle(color: Colors.red),
//                  ),
//                ),
//              )
//            ],
//          )),
//    );
//  }
//
//  // Example code of how to verify phone number
//  void _verifyPhoneNumber() async {
//    setState(() {
//      _message = '';
//    });
//
//    PhoneVerificationCompleted verificationCompleted =
//        (PhoneAuthCredential phoneAuthCredential) async {
//      await _auth.signInWithCredential(phoneAuthCredential);
//      widget._scaffold.showSnackBar(SnackBar(
//        content: Text(
//            "Phone number automatically verified and user signed in: ${phoneAuthCredential}"),
//      ));
//    };
//
//    PhoneVerificationFailed verificationFailed =
//        (FirebaseAuthException authException) {
//      setState(() {
//        _message =
//        'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
//      });
//    };
//
//    PhoneCodeSent codeSent =
//        (String verificationId, [int forceResendingToken]) async {
//      widget._scaffold.showSnackBar(const SnackBar(
//        content: Text('Please check your phone for the verification code.'),
//      ));
//      _verificationId = verificationId;
//    };
//
//    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//        (String verificationId) {
//      _verificationId = verificationId;
//    };
//
//    try {
//      await _auth.verifyPhoneNumber(
//          phoneNumber: _phoneNumberController.text,
//          timeout: const Duration(seconds: 5),
//          verificationCompleted: verificationCompleted,
//          verificationFailed: verificationFailed,
//          codeSent: codeSent,
//          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//    } catch (e) {
//      widget._scaffold.showSnackBar(SnackBar(
//        content: Text("Failed to Verify Phone Number: ${e}"),
//      ));
//    }
//  }
//
//  // Example code of how to sign in with phone.
//  void _signInWithPhoneNumber() async {
//    try {
//      final AuthCredential credential = PhoneAuthProvider.credential(
//        verificationId: _verificationId,
//        smsCode: _smsController.text,
//      );
//      final User user = (await _auth.signInWithCredential(credential)).user;
//
//      widget._scaffold.showSnackBar(SnackBar(
//        content: Text("Successfully signed in UID: ${user.uid}"),
//      ));
//    } catch (e) {
//      print(e);
//      widget._scaffold.showSnackBar(SnackBar(
//        content: Text("Failed to sign in"),
//      ));
//    }
//  }
//}
