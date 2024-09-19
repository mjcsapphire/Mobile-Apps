import 'package:flutter/material.dart';

import '../components/video_card.dart';

final videos = [
  'lib/videos/vid1.mp4',
  'lib/videos/vid2.mp4',
  'lib/videos/vid4.mp4',
  'lib/videos/vid5.mp4',
];

class ToolkitPage extends StatefulWidget {
  const ToolkitPage({Key? key}) : super(key: key);

  @override
  State<ToolkitPage> createState() => _ToolkitPageState();
}

class _ToolkitPageState extends State<ToolkitPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
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
          'Rise Toolkit Images',
          maxLines: 2,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('<- Swipe For Options ->',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: PageView.builder(
              // controller: _pageController,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return VideoCard(
                  assetPath: videos[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
