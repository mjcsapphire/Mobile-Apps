import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rise_pathway/config/constants/package_export.dart';
import 'package:rise_pathway/config/utils/colors.dart';

const deviceWidth = 360;
const deviceHeight = 800;

class Helpers {
  static final List<Map<String, dynamic>> challenges = [
    {
      'title': 'Introduction',
      'description': [
        'Today, the focus is on human connection. Social interaction is a key aspect of feeling supported, heard, and understood, even when it feels challenging. Your mood suggests that opening up to others might help boost your emotional state or even provide new perspectives.'
      ]
    },
    {
      'title': 'Introduction',
      'description': [
        'The goal of this challenge is to help you connect with others, which can improve your mood and give you a sense of belonging. Even if you\'re feeling low or neutral, having a conversation with someone can break isolation and help create positive energy.'
      ]
    },
    {
      'title': 'Introduction',
      'description': [
        'Engage in meaningful conversations.',
        'Build or strengthen a connection with someone.',
        'Practice active listening and empathy during the conversation.'
      ]
    },
    {
      'title': 'Introduction',
      'description': [
        'Reach out to a friend or family member you haven’t spoken to in a while and catch up.',
        'Introduce yourself to someone new or talk to a colleague/classmate about their day.',
        'Join an online group or forum where you can discuss a topic of interest with others.',
      ]
    },
    {
      'title': 'Introduction',
      'description': [
        'Your personal coach encourages you to have at least three conversations today. The challenge is to go beyond small talk. Ask people how they’re really doing, share something about your own day or mood, and actively engage in the conversation. Notice how it affects your mood and reflect on it at the end of the day.'
      ]
    },
  ];

  static final List<String> imagePaths = [
    'assets/icons/emotion.png',
    'assets/icons/happy_mood.png',
    'assets/icons/sad_mood.png',
    'assets/icons/emotion.png',
    'assets/icons/happy_mood.png',
    'assets/icons/sad_mood.png',
    'assets/icons/emotion.png',
    'assets/icons/happy_mood.png',
    'assets/icons/sad_mood.png',
    'assets/icons/emotion.png',
    'assets/icons/happy_mood.png',
    'assets/icons/sad_mood.png',
    'assets/icons/happy_mood.png',
    'assets/icons/sad_mood.png',
  ];

  static const List<Color> emojiBackground = [
    Color(0xFFFFB6C1),
    Color(0xFFF8E231),
    Color(0xFF64B5F6),
    Color(0xFFFFC642),
    Color(0xFF68CB2B),
    Color(0xFFFF4081),
    Color(0xFFF57505),
    Color(0xFFFFC642),
    Color(0xFF68CB2B),
    Color(0xFFFF6B6B),
    Color(0xFFF7DC6F),
    Color(0xFFE9F2F3),
    Color(0xFFCCE8F5),
    Color(0xFF4F5568),
  ];

  static final List<String> emojiImages = [
    'angry-face-with-horns.gif',
    'anxious-face-with-sweat.gif',
    'confused-face.gif',
    'disappointed-face.gif',
    'face-screaming-in-fear.gif',
    'face-with-steam-from-nose.gif',
    'face-with-tears-of-joy.gif',
    'grinning-face-with-sweat.gif',
    'hot-face.gif',
    'hugging-face.gif',
    'nauseated-face.gif',
    'neutral-face.gif',
    'Red-angry-face.gif',
    'smiling-face-with-halo.gif',
    'smiling-face-with-heart-eyes.gif',
    'smiling-face-with-hearts.gif',
    'smiling-face.gif',
    'star-struck.gif',
    'winking-face-with-tongue.gif',
    'woozy-face.gif',
  ];
  static Color getColorFromName(String name) {
    final hash = name.hashCode;
    final random = Random(hash);
    final r = 200 + random.nextInt(60);
    final g = 200 + random.nextInt(60);
    final b = 200 + random.nextInt(60);
    return Color.fromARGB(255, r, g, b);
  }

  static Container customDivider({
    required double thickness,
    required double secondThickness,
  }) {
    return Container(
      width: 90.w,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: thickness,
            width: 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.lighterGrey,
            ),
          ),
          Container(
            height: secondThickness,
            width: 25.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.lighterGrey,
            ),
          ),
        ],
      ),
    );
  }
}
