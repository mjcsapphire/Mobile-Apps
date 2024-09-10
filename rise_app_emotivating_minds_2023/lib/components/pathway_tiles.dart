import 'package:flutter/material.dart';
import 'package:rise_app_emotivating_minds_2023/models/pathway_model.dart';

import '../pages/pathway_page.dart';
import '../theme/colors.dart';

class PathwayTile extends StatelessWidget {
  final PathwayModel pathway;
  const PathwayTile({Key? key, required this.pathway}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var theColour = int.tryParse(pathway.colour);
    Color theParsedColour = Color(theColour!);

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PathwayPage(pathway: pathway))),
      child: Container(
        margin: EdgeInsets.only(left: 25),
        width: 280,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              theParsedColour,
              Colors.white
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter), borderRadius: BorderRadius.circular(12)),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    pathway.title.toString(),
                    style: const TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
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
                      Text('My Score is', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      Text(
                        pathway.user_score.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.orangeAccent, Colors.grey],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    child: Icon(
                      Icons.show_chart,
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
