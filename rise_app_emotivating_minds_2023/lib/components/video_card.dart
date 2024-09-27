// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:video_player/video_player.dart';

import '../utils/api_calls.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({
    super.key,
    required this.assetPath,
  });

  final String assetPath;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  showAlertDialog(BuildContext context, String path) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () async {
        var userEmail = FirebaseAuth.instance.currentUser?.email;
        await updateUserRiseImage(userEmail!, path).then((value) async {
          toasty(context, value['message']);
          if (value['message'] == 'Success') {
            print("Deleted");
            Navigator.pop(context);
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
      title: const Text("Confirmation Alert"),
      content: const Text("Are you sure you'd like to select this video?"),
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

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath);

    _controller
      ..setLooping(true)
      ..setVolume(0)
      ..initialize()
      ..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAlertDialog(context, widget.assetPath);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 2),
        margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 6),
              blurRadius: 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ),
      ),
    );
  }
}
