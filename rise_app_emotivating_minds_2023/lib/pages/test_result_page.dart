import 'package:flutter/material.dart';

import '../models/user_model.dart';

class TestResultPage extends StatelessWidget {
  final String score;
  final String feedback;
  const TestResultPage({Key? key, required this.score, required this.feedback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: IconButton(
          onPressed: () {Navigator.pushNamed(context, '/home');},
          icon: Icon(Icons.chevron_left),
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child:

                //Message
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('You scored $score out of 10', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
                        SizedBox(height: 5,),
                        Divider(height: 10,),
                        SizedBox(height: 5,),
                        Text('$feedback', style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                ),






          ),
        ),
      ),
    );
  }
}
