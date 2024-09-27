import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/user_model.dart';
import '../theme/colors.dart';
import '../utils/api_calls.dart';

class RiseScreen extends StatefulWidget {
  final UserModel data;
  const RiseScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<RiseScreen> createState() => _RiseScreenState();
}

class _RiseScreenState extends State<RiseScreen> {
  late VideoPlayerController _controller;
  final cache = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.data.riseImage.toString());

    _controller
      ..setLooping(true)
      ..setVolume(0)
      ..initialize()
      ..play();

    cache.play(AssetSource(widget.data.riseSound.toString()));

    var userEmail = FirebaseAuth.instance.currentUser?.email;
    registerRise(userEmail!);
  }

  @override
  void dispose() {
    _controller.dispose();
    cache.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   leading: IconButton(
      //     onPressed: () {Navigator.pushNamed(context, '/home');},
      //     icon: Icon(Icons.chevron_left),
      //   ),
      //   elevation: 0.0,
      //   titleSpacing: 0.0,
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   title: Text(
      //     'Rise Toolkit Images',
      //     maxLines: 2,
      //     style: TextStyle(
      //         color: Colors.white, fontWeight: FontWeight.bold),
      //   ),
      //
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [primaryColor, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 2),
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
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
            ),
          ],
        ),
      ),
    );
  }
}
