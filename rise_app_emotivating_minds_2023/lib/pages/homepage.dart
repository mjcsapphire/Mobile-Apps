import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rise_app_emotivating_minds_2023/components/button.dart';
import 'package:rise_app_emotivating_minds_2023/components/pathway_tiles.dart';
import 'package:rise_app_emotivating_minds_2023/models/challenge_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/bottom_navbar.dart';
import '../components/challenge_tile.dart';
import '../models/user_model.dart';
import '../theme/colors.dart';
import '../utils/api_calls.dart';

var theuser = [].obs;
var username = '';
dynamic challengeController = "";
var challengeList = [].obs;
dynamic pathwayController = "";
var pathwayList = [].obs;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

_fetchUser() async {
  var user_email = FirebaseAuth.instance.currentUser?.email;
  var user = await HttpService.fetchUser(user_email);
  if (user != null) {
    theuser.value = user;
    username = theuser[0].firstname.toString();
    return 'Found user';
  } else {
    return 'No user found';
  }
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  navigateBottomBar(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {

    } else if (index == 2) {
      Navigator.pushNamed(context, '/journal');
    } else {
      Navigator.pushNamed(context, '/profile');
    }
  }

  //double = availablescreenwidth = 0;

  // var _pages = <Widget>[
  //   HomeScreen(),
  //   HomeScreen(),
  //   HomeScreen(),
  //   ProfilePage1(),
  // ];

  _fetchChallenges() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var user_email = FirebaseAuth.instance.currentUser?.email;
        var Challenges = await HttpService.fetchChallenges(user_email);
        if (Challenges != null) {
          challengeList.value = Challenges;
        } else {
          return 'No challenges found';
        }
      }
    } on SocketException catch (_) {
      print('No Internet');
      return 'No challenges found';
    }

    return challengeList;
  }

  _fetchPathways() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var user_email = FirebaseAuth.instance.currentUser?.email;
        var Pathways = await HttpService.fetchPathways(user_email);
        if (Pathways != null) {
          pathwayList.value = Pathways;
          // print('HIIIII');
        } else {
          return 'No pathways found';
        }
      }
    } on SocketException catch (_) {
      print('No Internet');
      return 'No pathways found';
    }

    return pathwayList;
  }

  @override
  Widget build(BuildContext context) {
    //availablescreenwidth = MediaQuery.of(context).size.width - ;

    return FutureBuilder(
        future: _fetchUser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data == 'No user found') {
              return MyButton(
                text: "No user found",
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              );
            } else {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.grey[250],
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Icon(
                    Icons.menu,
                    color: Colors.grey[900],
                  ),
                ),
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.white,
                      Colors.blueAccent,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Top Row
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Center(
                              child: Image.asset(
                                'lib/images/logo2.png',
                                height: 100,
                              ),
                            ),
                          ),

                          //Message
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text("Today I am feeling...",
                                        style: TextStyle(color: Colors.grey)),
                                    Text('${theuser[0].mood}',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 20)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    FloatingActionButton.extended(
                                      backgroundColor: Colors.grey[200],
                                      foregroundColor: Colors.grey[700],
                                      onPressed: () async {
                                        Navigator.pushNamed(
                                            context, '/checkin');
                                      },
                                      heroTag: 'save',
                                      elevation: 0,
                                      label: const Text("Change my mood"),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const Padding(
                            padding: const EdgeInsets.only(
                                top: 25.0, left: 25.0, right: 25.0),
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          //Challenges
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text('My Daily Challenges',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                // Text('See more',
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.bold, color: Colors.blue)),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          FutureBuilder(
                              future: _fetchChallenges(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Container(
                                    height: 300,
                                    child: ListView.builder(
                                      itemCount: challengeList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return ChallengeTile(
                                          challenge: challengeList[index],
                                        );
                                      },
                                    ),
                                  );
                                }
                              }),

                          const Padding(
                            padding: const EdgeInsets.only(
                                top: 25.0, left: 25.0, right: 25.0),
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          //Challenges
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text('My Rise Pathway',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                // Text('See more',
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.bold, color: Colors.blue)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          FutureBuilder(
                              future: _fetchPathways(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      itemCount: pathwayList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return PathwayTile(
                                          pathway: pathwayList[index]
                                        );
                                      },
                                    ),
                                  );
                                }
                              }),

                          const Padding(
                            padding: const EdgeInsets.only(
                                top: 25.0, left: 25.0, right: 25.0),
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'My Coach: \nStephen Allen',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          MyButton(
                                            text: "Message",
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/contact');
                                            },
                                            icon: Icon(
                                              Icons.email,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'This week I\'ve had: \n${theuser[0].rises_day} rises',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        MyButton(
                                          text: "Reflections",
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/reflections');
                                          },
                                          icon: Icon(
                                            Icons.bar_chart,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.miniCenterDocked,
                floatingActionButton: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.lightBlue,
                    child: Icon(Icons.crisis_alert, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, '/rise');
                    },
                  ),
                ),
                bottomNavigationBar: MyBottomNavBar(
                  onTabChange: (index) => navigateBottomBar(index),
                ),
              );
            }
          }
        });
  }
}
