import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rise_app_emotivating_minds_2023/models/challenge_model.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../components/challenge_tile.dart';
import '../utils/api_calls.dart';

var challengeRelatedList = [].obs;
var challengeRelatedPremiumList = [].obs;

class ChallengeDetailsPage extends StatefulWidget {
  final ChallengeModel challenge;
  ChallengeDetailsPage({Key? key, required this.challenge}) : super(key: key);

  @override
  State<ChallengeDetailsPage> createState() => _ChallengeDetailsPageState();
}

class _ChallengeDetailsPageState extends State<ChallengeDetailsPage> {
  late PageController _pageController;
  int _currentPage = 0;

  _fetchRelatedChallenges() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var user_email = FirebaseAuth.instance.currentUser?.email;
        var Challenges = await HttpService.fetchRelatedChallenges(user_email, widget.challenge.id.toString(), widget.challenge.pathway.toString());
        if (Challenges != null) {
          challengeRelatedList.value = Challenges;
        } else {
          return 'No challenges found';
        }
      }
    } on SocketException catch (_) {
      print('No Internet');
      return 'No challenges found';
    }

    return challengeRelatedList;
  }

  _fetchRelatedPremiumChallenges() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var user_email = FirebaseAuth.instance.currentUser?.email;
        var Challenges = await HttpService.fetchRelatedPremiumChallenges(user_email, widget.challenge.id.toString(), widget.challenge.pathway.toString());
        if (Challenges != null) {
          challengeRelatedPremiumList.value = Challenges;
        } else {
          return 'No challenges found';
        }
      }
    } on SocketException catch (_) {
      print('No Internet');
      return 'No challenges found';
    }

    return challengeRelatedPremiumList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List challengeDetails = [
      {'title': 'Introduction', 'value': widget.challenge.introduction.toString()},
      {'title': 'Purpose', 'value': widget.challenge.purpose.toString()},
      {'title': 'Goals', 'value': widget.challenge.goals.toString()},
      {'title': 'Activity', 'value': widget.challenge.activity.toString()},
      {'title': 'Challenge', 'value': widget.challenge.challenge.toString()},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              children: [
                //Search bar
                Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        widget.challenge.image.toString(),
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),

                //Message
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child:
                  Text(widget.challenge.name.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
                ),

                SizedBox(height: 10,),

                AspectRatio(
                  aspectRatio: 0.85,
                  child: PageView.builder(
                      itemCount: challengeDetails.length,
                      physics: const ClampingScrollPhysics(),
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double value = 0.0;
                            if (_pageController.position.haveDimensions) {
                              value = index.toDouble()- (_pageController.page ?? 0);
                              value = (value * 0.038).clamp(-1, 1);
                            }
                            return Transform.rotate(
                              angle: pi * value,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Hero(
                                        tag: challengeDetails[index]['title'],
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(30),
                                              boxShadow: const [
                                                BoxShadow(
                                                    offset: Offset(0, 4),
                                                    blurRadius: 4,
                                                    color: Colors.black26)
                                              ]),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(child: Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    Text(challengeDetails[index]['title'],
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                                    SizedBox(height: 10,),
                                                    HtmlWidget(
                                                      // the first parameter (`html`) is required
                                                      challengeDetails[index]['value'],

                                                      // set the default styling for text
                                                      textStyle: TextStyle(fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ), width: 400,),
                                            ],
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },
                        );


                      }),
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: const [
                //       Text('Benefits of this challenge',
                //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                //       // Text('See more',
                //       //     style: TextStyle(
                //       //         fontWeight: FontWeight.bold, color: Colors.blue)),
                //     ],
                //   ),
                // ),

                SizedBox(height: 10,),

                widget.challenge.assigned.toString() == 'Assigned'
                    ?
                Column(
                  children: [
                    const Padding(
                      padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
                      child: Divider(color: Colors.white,),
                    ),

                    SizedBox(height: 10,),

                    widget.challenge.status.toString() != 'Completed'
                        ?
                    FloatingActionButton.extended(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                          var user_email = FirebaseAuth.instance.currentUser?.email;

                          await completeChallenge(user_email!, widget.challenge.id.toString())
                              .then((value) async {
                            toasty(context, value['message']);
                            if(value['message'] == 'Success'){
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/home');

                            }
                            // finish(context);
                            // controller!.dispose();
                          }).catchError((e) {
                            toasty(context, e.toString());
                          });
                      },
                      heroTag: 'save',
                      elevation: 0,
                      label: const Text("I've Completed This!"),
                      icon: const Icon(Icons.check),
                    ):
                    FloatingActionButton.extended(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.blue,
                      onPressed: () async {

                      },
                      heroTag: 'save',
                      elevation: 0,
                      label: const Text("Challenge Already Done!"),
                    ),
                  ],
                ): const Text(" "),


                SizedBox(height: 10,),


                const Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
                  child: Divider(color: Colors.white,),
                ),

                //Challenges
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('Related Challenges',
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
                    future: _fetchRelatedChallenges(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: CircularProgressIndicator());
                      } else {
                        return Container(
                          height: 300,
                          child: ListView.builder(
                            itemCount: challengeRelatedList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ChallengeTile(
                                challenge: challengeRelatedList[index],
                              );
                            },
                          ),
                        );
                      }
                    }),

                SizedBox(height: 25,),


                const Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
                  child: Divider(color: Colors.white,),
                ),


                SizedBox(height: 10,),

                //Challenges
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('Related Challenges (Premium)',
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
                    future: _fetchRelatedPremiumChallenges(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: CircularProgressIndicator());
                      } else {
                        return Container(
                          height: 300,
                          child: ListView.builder(
                            itemCount: challengeRelatedPremiumList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ChallengeTile(
                                challenge: challengeRelatedPremiumList[index],
                              );
                            },
                          ),
                        );
                      }
                    }),

                SizedBox(height: 25,),

                widget.challenge.assigned.toString() == 'Assigned'
                    ?
                Column(
                  children: [
                    const Padding(
                      padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
                      child: Divider(color: Colors.white,),
                    ),

                    SizedBox(height: 10,),

                    widget.challenge.autoAssigned.toString() == 'Manual'
                        ?
                    FloatingActionButton.extended(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        var user_email = FirebaseAuth.instance.currentUser?.email;

                        await removeChallenge(user_email!, widget.challenge.id.toString())
                            .then((value) async {
                          toasty(context, value['message']);
                          if(value['message'] == 'Success'){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/home');

                          }
                          // finish(context);
                          // controller!.dispose();
                        }).catchError((e) {
                          toasty(context, e.toString());
                        });
                      },
                      heroTag: 'save',
                      elevation: 0,
                      label: const Text("Remove this challenge"),
                      icon: const Icon(Icons.remove_circle_outline),
                    ):
                    Text(" "),
                  ],
                ):
                Column(
                  children: [
                    const Padding(
                      padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
                      child: Divider(color: Colors.white,),
                    ),

                    SizedBox(height: 10,),

                    widget.challenge.userPaid.toInt() >= widget.challenge.paid.toInt()
                        ?
                    FloatingActionButton.extended(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        var user_email = FirebaseAuth.instance.currentUser?.email;

                        await addChallenge(user_email!, widget.challenge.id.toString())
                            .then((value) async {
                          toasty(context, value['message']);
                          if(value['message'] == 'Success'){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/home');

                          }
                          // finish(context);
                          // controller!.dispose();
                        }).catchError((e) {
                          toasty(context, e.toString());
                        });
                      },
                      heroTag: 'save',
                      elevation: 0,
                      label: const Text("Add this challenge"),
                      icon: const Icon(Icons.add),
                    ):
                    FloatingActionButton.extended(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        var user_email = FirebaseAuth.instance.currentUser?.email;

                        // await addChallenge(user_email!, widget.challenge.id.toString())
                        //     .then((value) async {
                        //   toasty(context, value['message']);
                        //   if(value['message'] == 'Success'){
                        //     Navigator.pop(context);
                        //     Navigator.pushNamed(context, '/home');
                        //
                        //   }
                        //   // finish(context);
                        //   // controller!.dispose();
                        // }).catchError((e) {
                        //   toasty(context, e.toString());
                        // });
                      },
                      heroTag: 'save',
                      elevation: 0,
                      label: const Text("Upgrade to premium to add challenge"),
                      icon: const Icon(Icons.monetization_on),
                    ),
                  ],
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }


}
