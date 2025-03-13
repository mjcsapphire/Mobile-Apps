import 'package:flutter/material.dart';

import '../models/user_model.dart';

class ReflectionsPage extends StatelessWidget {
  final UserModel data;
  const ReflectionsPage({Key? key, required this.data}) : super(key: key);

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
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text('My Rise Pathway Reflections',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                      Text(
                          'View all of your key rise information for the day, week, and month',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Today\'s Reflections',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      // Text('See more',
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold, color: Colors.blue)),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                //Message
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      children: [
                        Text('Number of rises: ${data.rises_day}.',
                            style: const TextStyle(fontSize: 14)),
                        Text(
                            'Number of challenges completed: ${data.challenges_day}',
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('This Week\'s Reflections',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      // Text('See more',
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold, color: Colors.blue)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //Message
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      children: [
                        Text('Number of rises:  ${data.rises_week}',
                            style: const TextStyle(fontSize: 14)),
                        Text(
                            'Number of challenges completed: ${data.challenges_week}',
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('This Month\'s Reflections',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      // Text('See more',
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold, color: Colors.blue)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //Message
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      children: [
                        Text('Number of rises:  ${data.rises_month}',
                            style: const TextStyle(fontSize: 14)),
                        Text(
                            'Number of challenges completed: ${data.challenges_month}',
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
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
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Rise Pathway Scores',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      // Text('See more',
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold, color: Colors.blue)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //Message
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      children: [
                        Text('Health & Wellbeing: ${data.health_pathway}/10',
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 2),
                        const Divider(
                          height: 2,
                        ),
                        const SizedBox(height: 2),
                        Text('Relationships: ${data.relationships_pathway}/10',
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 2),
                        const Divider(
                          height: 2,
                        ),
                        const SizedBox(height: 2),
                        Text(
                            'Adaptation & Transition: ${data.adaptation_pathway}/10',
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 2),
                        const Divider(
                          height: 2,
                        ),
                        const SizedBox(height: 2),
                        Text(
                            'Personal Development: ${data.personal_pathway}/10',
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 2),
                        const Divider(
                          height: 2,
                        ),
                        const SizedBox(height: 2),
                        Text(
                            'Wisdom in Communication: ${data.wisdom_pathway}/10',
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 2),
                        const Divider(
                          height: 2,
                        ),
                        const SizedBox(height: 2),
                        Text('Coping Mechanisms: ${data.coping_pathway}/10',
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 2),
                        const Divider(
                          height: 2,
                        ),
                        const SizedBox(height: 2),
                        Text(
                            'Engagement in Community: ${data.engagement_pathway}/10',
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 2),
                        const Divider(
                          height: 2,
                        ),
                        const SizedBox(height: 2),
                        Text('Emotions: ${data.emotions_pathway}/10',
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 2),
                        const Divider(
                          height: 2,
                        ),
                        const SizedBox(height: 2),
                        Text(
                            'Identity and Self Awareness: ${data.identity_pathway}/10',
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 2),
                        const Divider(
                          height: 2,
                        ),
                        const SizedBox(height: 2),
                        Text(
                            'Thoughtful Decision Making: ${data.decision_pathway}/10',
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
