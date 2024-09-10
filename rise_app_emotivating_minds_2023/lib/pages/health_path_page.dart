import 'package:flutter/material.dart';
import 'package:flutter_survey/flutter_survey.dart';
import 'package:nb_utils/nb_utils.dart';

class HealthPathwayPage extends StatefulWidget {
  const HealthPathwayPage({Key? key}) : super(key: key);

  @override
  State<HealthPathwayPage> createState() => _HealthPathwayPageState();
}

class _HealthPathwayPageState extends State<HealthPathwayPage> {
  final _formKey = GlobalKey<FormState>();
  List<QuestionResult> _questionResults = [];
  final List<Question> _initialData = [
    Question(
      isMandatory: true,
      question: 'Do you eat healthy meals?',
      answerChoices: {
        "No": [
          Question(
              singleChoice: false,
              question: "What are you favourite kinds of food?",
              answerChoices: {
                "Fast food": null,
                "Lots of sugar": null,
                "Anything!": null,
              })
        ],
        "Yes": [
          Question(
            question: "Do you get plenty of exercise?",
            answerChoices: {
              "Yes": [
                Question(
                    question: "How many times a week do you exercise?",
                    answerChoices: {
                      "Once a week": null,
                      "A few times a week": null,
                      "Every day": null,
                    })
              ],
              "No": null,
            },
          )
        ],
      },
    ),
    Question(
        question: "What age group do you fall in?",
        isMandatory: true,
        answerChoices: const {
          "11-18": null,
          "18-20": null,
          "20-30": null,
          "Over 30": null,
        })
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Survey(
                onNext: (questionResults) {
                  _questionResults = questionResults;
                  print(questionResults);
                },
                initialData: _initialData),
          ),
        ),
      ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // Background Color
                ),
                child: const Text("Submit Answers"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //do something
                    toasty(context, 'Success');
                    Navigator.pushNamed(context, '/home');

                  }
                },
              ),
            ),
          ],
        )
    );
  }



}

