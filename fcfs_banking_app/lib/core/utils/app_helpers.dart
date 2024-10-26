import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppHelpers {
  static toast(String text) {
    return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.black,
      textColor: const Color.fromARGB(255, 185, 162, 162),
      fontSize: 16.0,
    );
  }

  static showSnackBar(
      {required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  static String? validatePassword(String? value) {
    final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{8,}$');
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters and include both letters and numbers';
    }
    return null;
  }

  static Future<File?> pickImage(ImageSource source) async {
    File? image;
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      toast(e.toString());
    }
    return image;
  }

  static saveUser({required String key, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool?> getUser({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
