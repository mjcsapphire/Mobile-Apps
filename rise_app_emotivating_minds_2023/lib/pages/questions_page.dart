import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rise_app_emotivating_minds_2023/models/questions_model.dart';
import 'package:rise_app_emotivating_minds_2023/pages/test_result_page.dart';

import '../utils/api_calls.dart';

dynamic questionsController = "";
var questionsList = [].obs;

class QuestionsPage extends StatefulWidget {
  final String? pathway;
  const QuestionsPage({Key? key, required this.pathway}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  _fetchQuestions() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var Questions = await HttpService.fetchQuestions(widget.pathway);
        if (Questions != null) {
          questionsList.value = Questions;
        } else {
          return 'No questions found';
        }
      }
    } on SocketException catch (_) {
      print('No Internet');
      return 'No questions found';
    }

    return questionsList;
  }

  int questionNumber = 1;
  int question1 = 0;
  int question2 = 0;
  int question3 = 0;
  int question4 = 0;
  int question5 = 0;
  int question6 = 0;
  int question7 = 0;
  int question8 = 0;
  int question9 = 0;
  int question10 = 0;

  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Pathway Test',
          maxLines: 2,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            FutureBuilder(
                future: _fetchQuestions(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Expanded(
                      child: PageView.builder(
                        itemCount: questionsList.length,
                        controller: _controller,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final question = questionsList[index];
                          return buildQuestion(question);
                        },
                      ),
                    );
                  }
                }),
            // Expanded(child: PageView.builder(
            //   itemCount: questionsList.length,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index){
            //     final question = questionsList[index];
            //     return buildQuestion(question);
            //   },
            //
            // ),),
          ],
        ),
      ),
    );
  }

  Container buildQuestion(QuestionsModel question) {
    return Container(
      width: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.blue,
            width: 3.0,
          ),
        ),
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              'Question ${question.question_number}',
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              question.question,
              style: const TextStyle(fontSize: 25),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.extended(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    onPressed: () async {
                      if (questionNumber == 1) {
                        question1 = 1;
                      } else if (questionNumber == 2) {
                        question2 = 1;
                      } else if (questionNumber == 3) {
                        question3 = 1;
                      } else if (questionNumber == 4) {
                        question4 = 1;
                      } else if (questionNumber == 5) {
                        question5 = 1;
                      } else if (questionNumber == 6) {
                        question6 = 1;
                      } else if (questionNumber == 7) {
                        question7 = 1;
                      } else if (questionNumber == 8) {
                        question8 = 1;
                      } else if (questionNumber == 9) {
                        question9 = 1;
                      } else if (questionNumber == 10) {
                        question10 = 1;
                      }

                      if (questionNumber < questionsList.length) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.easeIn,
                        );

                        setState(() {
                          if (questionNumber > 0) {
                            questionNumber++;
                          }
                        });
                      } else {
                        //Process scores

                        //User ID, Pathway ID, Answers
                        var userEmail =
                            FirebaseAuth.instance.currentUser?.email;
                        toasty(context, "Calculating Answers");

                        await submitPathwayTest(
                                userEmail!,
                                question.pathway_id as String,
                                question1,
                                question2,
                                question3,
                                question4,
                                question5,
                                question6,
                                question7,
                                question8,
                                question9,
                                question10)
                            .then((value) async {
                          String score = value['score'].toString();
                          String feedback = value['feedback'].toString();

                          toasty(context, "You scored $score out of 10");
                          if (value['message'] == 'Success') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TestResultPage(
                                    score: score, feedback: feedback),
                              ),
                            );
                          }
                          // finish(context);
                          // controller!.dispose();
                        }).catchError((e) {
                          toasty(context, e.toString());
                        });
                      }
                    },
                    heroTag: 'save',
                    elevation: 0,
                    label: const Text("Yes"),
                    icon: const Icon(Icons.check),
                  ),
                  FloatingActionButton.extended(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    onPressed: () async {
                      if (questionNumber == 1) {
                        question1 = 0;
                      } else if (questionNumber == 2) {
                        question2 = 0;
                      } else if (questionNumber == 3) {
                        question3 = 0;
                      } else if (questionNumber == 4) {
                        question4 = 0;
                      } else if (questionNumber == 5) {
                        question5 = 0;
                      } else if (questionNumber == 6) {
                        question6 = 0;
                      } else if (questionNumber == 7) {
                        question7 = 0;
                      } else if (questionNumber == 8) {
                        question8 = 0;
                      } else if (questionNumber == 9) {
                        question9 = 0;
                      } else if (questionNumber == 10) {
                        question10 = 0;
                      }

                      if (questionNumber < questionsList.length) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.easeIn,
                        );

                        setState(() {
                          if (questionNumber > 0) {
                            questionNumber++;
                          }
                        });
                      } else {
                        //Process scores

                        //User ID, Pathway ID, Answers
                        var userEmail =
                            FirebaseAuth.instance.currentUser?.email;
                        toasty(context, "Calculating Answers");

                        await submitPathwayTest(
                                userEmail!,
                                question.pathway_id as String,
                                question1,
                                question2,
                                question3,
                                question4,
                                question5,
                                question6,
                                question7,
                                question8,
                                question9,
                                question10)
                            .then((value) async {
                          String score = value['score'].toString();
                          String feedback = value['feedback'].toString();

                          toasty(context, "You scored $score out of 10");
                          if (value['message'] == 'Success') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TestResultPage(
                                    score: score, feedback: feedback),
                              ),
                            );
                          }
                          // finish(context);
                          // controller!.dispose();
                        }).catchError((e) {
                          toasty(context, e.toString());
                        });
                      }
                    },
                    heroTag: 'save',
                    elevation: 0,
                    label: const Text("No"),
                    icon: const Icon(Icons.cancel_outlined),
                  ),
                ],
              ),
            ),
            questionNumber > 1
                ? FloatingActionButton.extended(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    onPressed: () async {
                      if (questionNumber > 0) {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.easeInOut,
                        );

                        setState(() {
                          if (questionNumber > 1) {
                            questionNumber--;
                          }
                        });
                      }
                    },
                    heroTag: 'save',
                    elevation: 0,
                    label: const Text("Back"),
                    icon: const Icon(Icons.arrow_back),
                  )
                : const Text(" "),
          ],
        ),
      ),
    );
  }
}
