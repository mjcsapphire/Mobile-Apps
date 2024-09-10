import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/resuable_widgets.dart';
import '../theme/colors.dart';
import '../utils/api_calls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _password2TextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                primaryColor,
                Colors.white
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outlined, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Re-Enter Password", Icons.lock_outlined, true,
                        _password2TextController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Sign Up", () {
                      if (_emailTextController.text.trim() == '') {
                        _showMyDialog('Please enter an email');
                      } else if (_passwordTextController.text.trim() == '') {
                        _showMyDialog('Please enter a password');
                      } else if (_passwordTextController.text.trim() != _password2TextController.text.trim()) {
                        _showMyDialog('Password fields must match');
                      }
                      else {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                            .then((value) async {


                          await addDancer(_emailTextController.text)
                              .then((value) async {
                          toasty(context, value['message']);
                          if(value['message'] == 'Success'){
                          Navigator.pushNamed(context, '/checkin');

                          }
                          // finish(context);
                          // controller!.dispose();
                          }).catchError((e) {
                          toasty(context, e.toString());
                          });





                        }).onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                          _showMyDialog("Error ${error.toString()}");
                        });
                      }
                    })
                  ],
                ),
              ))),
    );
  }

  Future<void> _showMyDialog(String alert) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(alert),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}