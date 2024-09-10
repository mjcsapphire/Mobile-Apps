import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rise_app_emotivating_minds_2023/theme/colors.dart';

import '../utils/api_calls.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              primaryColor,
              Colors.white
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 25,),

              //Shop name
              Text("My Daily Check-in", style: GoogleFonts.dmSerifDisplay(fontSize: 34, color: Colors.white),),



              //Title
              Text("Today I am feeling...", style: GoogleFonts.dmSerifDisplay(fontSize: 28, color: Colors.white),),

              //Options
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      child: GridView.count(
                        crossAxisCount: 3,
                        padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          GridTile(
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white54,
                              child: InkWell(
                                highlightColor: Colors.white12,
                                onTap: () async {
                                  var user_email = FirebaseAuth.instance.currentUser?.email;
                                  await updateMood(user_email!, 'Very Happy')
                                      .then((value) async {
                                  //toasty(context, value['message']);
                                  if(value['message'] == 'Success'){
                                    Navigator.pushNamed(context, '/home');

                                  }
                                  }).catchError((e) {
                                  toasty(context, e.toString());
                                  });
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset('lib/images/very_happy.gif', width: 50,),
                                      Text("Very Happy",
                                          style:
                                          TextStyle(color: Colors.red))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GridTile(
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white54,
                              child: InkWell(
                                highlightColor: Colors.white12,
                                onTap: () async {
                                  var user_email = FirebaseAuth.instance.currentUser?.email;
                                  await updateMood(user_email!, 'Happy')
                                      .then((value) async {
                                    //toasty(context, value['message']);
                                    if(value['message'] == 'Success'){
                                      Navigator.pushNamed(context, '/home');

                                    }
                                  }).catchError((e) {
                                    toasty(context, e.toString());
                                  });
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset('lib/images/happy.gif', width: 50,),
                                      Text("Happy",
                                          style:
                                          TextStyle(color: Colors.red))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GridTile(
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white54,
                              child: InkWell(
                                highlightColor: Colors.white12,
                                onTap: () async {
                                  var user_email = FirebaseAuth.instance.currentUser?.email;
                                  await updateMood(user_email!, 'Excited')
                                      .then((value) async {
                                    //toasty(context, value['message']);
                                    if(value['message'] == 'Success'){
                                      Navigator.pushNamed(context, '/home');

                                    }
                                  }).catchError((e) {
                                    toasty(context, e.toString());
                                  });
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset('lib/images/excited.gif', width: 50,),
                                      Text("Excited",
                                          style:
                                          TextStyle(color: Colors.red))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GridTile(
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white54,
                              child: InkWell(
                                highlightColor: Colors.white12,
                                onTap: () async {
                                  var user_email = FirebaseAuth.instance.currentUser?.email;
                                  await updateMood(user_email!, 'Thankful')
                                      .then((value) async {
                                    //toasty(context, value['message']);
                                    if(value['message'] == 'Success'){
                                      Navigator.pushNamed(context, '/home');

                                    }
                                  }).catchError((e) {
                                    toasty(context, e.toString());
                                  });
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset('lib/images/thankful.gif', width: 50,),
                                      Text("Thankful",
                                          style:
                                          TextStyle(color: Colors.red))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GridTile(
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white54,
                              child: InkWell(
                                highlightColor: Colors.white12,
                                onTap: () async {
                                  var user_email = FirebaseAuth.instance.currentUser?.email;
                                  await updateMood(user_email!, 'Meh')
                                      .then((value) async {
                                    //toasty(context, value['message']);
                                    if(value['message'] == 'Success'){
                                      Navigator.pushNamed(context, '/home');

                                    }
                                  }).catchError((e) {
                                    toasty(context, e.toString());
                                  });
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset('lib/images/meh.gif', width: 50,),
                                      Text("Meh",
                                          style:
                                          TextStyle(color: Colors.red))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GridTile(
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white54,
                              child: InkWell(
                                highlightColor: Colors.white12,
                                onTap: () async {
                                  var user_email = FirebaseAuth.instance.currentUser?.email;
                                  await updateMood(user_email!, 'Confused')
                                      .then((value) async {
                                    //toasty(context, value['message']);
                                    if(value['message'] == 'Success'){
                                      Navigator.pushNamed(context, '/home');

                                    }
                                  }).catchError((e) {
                                    toasty(context, e.toString());
                                  });
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset('lib/images/confused.gif', width: 50,),
                                      Text("Confused",
                                          style:
                                          TextStyle(color: Colors.red))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GridTile(
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white54,
                              child: InkWell(
                                highlightColor: Colors.white12,
                                onTap: () async {
                                  var user_email = FirebaseAuth.instance.currentUser?.email;
                                  await updateMood(user_email!, 'Frustrated')
                                      .then((value) async {
                                    //toasty(context, value['message']);
                                    if(value['message'] == 'Success'){
                                      Navigator.pushNamed(context, '/home');

                                    }
                                  }).catchError((e) {
                                    toasty(context, e.toString());
                                  });
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset('lib/images/frustrated.gif', width: 50,),
                                      Text("Frustrated",
                                          style:
                                          TextStyle(color: Colors.red))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GridTile(
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white54,
                              child: InkWell(
                                highlightColor: Colors.white12,
                                onTap: () async {
                                  var user_email = FirebaseAuth.instance.currentUser?.email;
                                  await updateMood(user_email!, 'Sad')
                                      .then((value) async {
                                    // //toasty(context, value['message']);
                                    if(value['message'] == 'Success'){
                                      Navigator.pushNamed(context, '/home');

                                    }
                                  }).catchError((e) {
                                    toasty(context, e.toString());
                                  });
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [

                                      Image.asset('lib/images/sad.gif', width: 50,),
                                      Text("Sad",
                                          style:
                                          TextStyle(color: Colors.red))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GridTile(
                            child: Card(
                              elevation: 0.0,
                              color: Colors.white54,
                              child: InkWell(
                                highlightColor: Colors.white12,
                                onTap: () async {
                                  var user_email = FirebaseAuth.instance.currentUser?.email;
                                  await updateMood(user_email!, 'Angry')
                                      .then((value) async {
                                    //toasty(context, value['message']);
                                    if(value['message'] == 'Success'){
                                      Navigator.pushNamed(context, '/home');

                                    }
                                  }).catchError((e) {
                                    toasty(context, e.toString());
                                  });
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset('lib/images/angry.gif', width: 50,),
                                      Text("Angry",
                                          style:
                                          TextStyle(color: Colors.red))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                  ],
                ),
              )

              //Get started button
            ],
          ),
        ),
      ),
    );
  }
}
