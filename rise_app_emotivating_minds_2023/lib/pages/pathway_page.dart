import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:rise_app_emotivating_minds_2023/models/pathway_model.dart';
import 'package:rise_app_emotivating_minds_2023/pages/questions_page.dart';

import '../components/challenge_tile.dart';
import '../utils/api_calls.dart';

var challengeRelatedList = [].obs;
var challengeRelatedPremiumList = [].obs;

class PathwayPage extends StatefulWidget {
  final PathwayModel pathway;
  const PathwayPage({Key? key, required this.pathway}) : super(key: key);

  @override
  State<PathwayPage> createState() => _PathwayPageState();
}

class _PathwayPageState extends State<PathwayPage> {
  late PageController _pageController;
  final int _currentPage = 0;

  _fetchRelatedChallenges() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var userEmail = FirebaseAuth.instance.currentUser?.email;
        var challenges = await HttpService.fetchRelatedChallenges(
            userEmail, 0, widget.pathway.id.toString());
        if (challenges != null) {
          challengeRelatedList.value = challenges;
        } else {
          return 'No challenges found';
        }
      }
    } on SocketException catch (_) {
      return 'No challenges found';
    }

    return challengeRelatedList;
  }

  _fetchRelatedPremiumChallenges() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var userEmail = FirebaseAuth.instance.currentUser?.email;
        var challenges = await HttpService.fetchRelatedPremiumChallenges(
            userEmail, 0, widget.pathway.id.toString());
        if (challenges != null) {
          challengeRelatedPremiumList.value = challenges;
        } else {
          return 'No challenges found';
        }
      }
    } on SocketException catch (_) {
      return 'No challenges found';
    }

    return challengeRelatedPremiumList;
  }

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
  }

  @override
  void dispose() {
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
          child: Column(
            children: [
              //Message
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(widget.pathway.title.toString(),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ),

              const SizedBox(
                height: 10,
              ),

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
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              FloatingActionButton.extended(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.blue,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuestionsPage(pathway: widget.pathway.id),
                    ),
                  );
                },
                heroTag: 'save',
                elevation: 0,
                label: const Text("Take Pathway Test"),
                extendedTextStyle: const TextStyle(fontSize: 18),
              ),

              const SizedBox(
                height: 10,
              ),

              const Padding(
                padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
                child: Divider(
                  color: Colors.white,
                ),
              ),

              //Challenges
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Related Challenges',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
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
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return SizedBox(
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

              const SizedBox(
                height: 25,
              ),

              const Padding(
                padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
                child: Divider(
                  color: Colors.white,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //Challenges
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Related Challenges (Premium)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
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
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return SizedBox(
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
    );
  }
}
