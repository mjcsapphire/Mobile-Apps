import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rise_app_emotivating_minds_2023/models/challenge_model.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:rise_app_emotivating_minds_2023/models/pathway_model.dart';
import 'package:rise_app_emotivating_minds_2023/pages/questions_page.dart';

import '../components/challenge_tile.dart';
import '../utils/api_calls.dart';

var challengeRelatedList = [].obs;
var challengeRelatedPremiumList = [].obs;

class PathwayPage extends StatefulWidget {
  final PathwayModel pathway;
  PathwayPage({Key? key, required this.pathway}) : super(key: key);

  @override
  State<PathwayPage> createState() => _PathwayPageState();
}

class _PathwayPageState extends State<PathwayPage> {
  late PageController _pageController;
  int _currentPage = 0;

  _fetchRelatedChallenges() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var user_email = FirebaseAuth.instance.currentUser?.email;
        var Challenges = await HttpService.fetchRelatedChallenges(user_email, 0, widget.pathway.id.toString());
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
        var Challenges = await HttpService.fetchRelatedPremiumChallenges(user_email, 0, widget.pathway.id.toString());
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

                //Message
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child:
                  Text(widget.pathway.title.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
                ),

                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      HtmlWidget(
                        // the first parameter (`html`) is required
                        widget.pathway.description,

                        // set the default styling for text
                        textStyle: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10,),

                FloatingActionButton.extended(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.blue,
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestionsPage(pathway: widget.pathway.id),),

                    );
                  },
                  heroTag: 'save',
                  elevation: 0,
                  label: const Text("Take Pathway Test"),
                  extendedTextStyle: TextStyle(fontSize: 18),
                ),

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


              ],
            ),
          ),
        ),
      ),
    );
  }


}
