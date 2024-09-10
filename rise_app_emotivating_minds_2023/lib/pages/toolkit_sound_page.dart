import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/api_calls.dart';

class ToolkitSoundPage extends StatefulWidget {
  const ToolkitSoundPage({Key? key}) : super(key: key);

  @override
  State<ToolkitSoundPage> createState() => _ToolkitSoundPageState();
}

class _ToolkitSoundPageState extends State<ToolkitSoundPage> {

  showAlertDialog(BuildContext context, String sound) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed:  () async {
        var user_email = FirebaseAuth.instance.currentUser?.email;
        await updateUserRiseSound(user_email!, sound)
            .then((value) async {
          toasty(context, value['message']);
          if(value['message'] == 'Success'){
            print("Deleted");
            Navigator.pop(context);
            cache.stop();
            Navigator.pushNamed(context, '/home');

          }
          // finish(context);
          // controller!.dispose();
        }).catchError((e) {
          toasty(context, e.toString());
        });



      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation Alert"),
      content: Text("Are you sure you'd like to select this sound?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final cache = AudioPlayer();

  @override
  void dispose() {
    cache.stop();
    cache.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: Icon(Icons.chevron_left),
          ),
          elevation: 0.0,
          titleSpacing: 0.0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'Rise Toolkit Sounds',
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Material(
                elevation: 2.0,
                child: Container(
                  width: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(40.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Colors.blue,
                        width: 3.0,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                // cache.stop();
                                cache.play(AssetSource("sounds/waves.mp3"));
                              },
                              child: Icon(Icons.play_arrow)),
                          const Text(
                            'Waves',
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          GestureDetector(onTap: () {
                            showAlertDialog(context, 'sounds/waves.mp3');
                          },child: Icon(Icons.add)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        )));
  }
}
