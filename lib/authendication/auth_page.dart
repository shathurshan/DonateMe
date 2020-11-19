import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'file:///C:/Users/Acer/AndroidStudioProjects/flutter_new/lib/authendication/auth_form_wid.dart';

class AuthPage extends StatefulWidget {

  static const routName = '/auth';

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitForm(
    String username,
    String email,
    String password,
    String type,
    String number,
    bool isLogin,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await Firestore.instance
            .collection('user')
            .document(authResult.user.uid)
            .setData(
          {
            'username': username,
            'email id': email,
            'type of user': type,
            'contact number': number,
            'uid' : authResult.user.uid,
          },
        );
      }
    } on PlatformException catch (err) {
      var message =
          'An error Occurred, Please check your information is Correct';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: AuthForm(
        _submitForm,
        _isLoading,
      ),
    );
  }
}
