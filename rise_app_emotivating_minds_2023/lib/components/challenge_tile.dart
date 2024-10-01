import 'package:flutter/material.dart';

import '../models/challenge_model.dart';
import '../pages/challange_details_page.dart';

class ChallengeTile extends StatelessWidget {
  final ChallengeModel challenge;
  const ChallengeTile({Key? key, required this.challenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChallengeDetailsPage(challenge: challenge))),
      child: Container(
        margin: const EdgeInsets.only(left: 25),
        width: 280,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Image
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  challenge.image.toString(),
                  height: 180,
                ),
              ),
            ),

            //Name
            challenge.status.toString() == 'Completed'
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      challenge.status.toString(),
                      style: TextStyle(color: Colors.green[600], fontSize: 18),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      challenge.status.toString(),
                      style: TextStyle(color: Colors.grey[600], fontSize: 18),
                    ),
                  ),

            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge.name.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        challenge.pathway_name.toString(),
                        style: const TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.orangeAccent, Colors.grey],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )

            //Short desc

            //Button to open
          ],
        ),
      ),
    );
  }
}
