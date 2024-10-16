import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../utils/colors.dart';

const deviceWidth = 360;
const deviceHeight = 800;

var logger = Logger(
    printer: PrettyPrinter(
  methodCount: 2,
  errorMethodCount: 8,
  lineLength: 50,
  colors: true,
  printEmojis: true,
));

enum RequestType { get, post, delete }

enum SelectedPage { notes, journal, church, myAccount, none }

enum LoggerType { d, e, i, w }

List<String> contentDescriptions = [
  "A cozy coffee shop located in the heart of the city. ",
  "The interior is filled with warm lighting that casts a gentle glow over",
  "the wooden tables and chairs. The aroma of freshly brewed coffee fills the air, while customers",
  " enjoy quiet conversations or work on their laptops.",
  " The walls are adorned with local artwork, giving the place a creative and inviting atmosphere.",
  "A sleek, modern laptop sits on a minimalist desk in a dimly lit room. The keyboard is backlit with a soft glow, providing just enough light ",
  "to see the keys. The screen displays code in a text editor, while a cup of coffee rests nearby, adding a touch of warmth to the otherwise cool, technological setting.",
  "A breathtaking mountain landscape at sunset, where the sky is painted in vibrant shades of ",
  "orange, pink, and purple. The sun slowly dips behind the peaks, casting long shadows over the ",
  "rugged terrain. The crisp mountain air is filled with the scent of pine trees, and the only sounds are the distant calls of birds and the rustling of leaves in the breeze.",
  "A beautifully arranged plate of sushi, featuring an assortment of fresh fish, including vibrant orange salmon, pink tuna, and delicate white fish. The rolls are",
  " neatly wrapped with seaweed and filled with avocado,",
  " cucumber, and rice. A small dish of soy sauce and a dab of wasabi sit on the side,",
  " waiting to complement each bite with a burst of flavor.",
  "A pristine beach with soft, white sand stretching as far as the eye can see. The crystal-clear water sparkles under the bright sun, with gentle",
  " waves lapping against the shore. Palm trees sway in the breeze, offering shade to those",
  " who seek refuge from the heat. In the distance, you can see boats lazily floating on the horizon, while seabirds fly overhead.",
  "A well-organized bookshelf in a cozy living room, filled with rows of classic novels, history books, and quirky decor items. Each",
  " shelf is carefully arranged, with a few potted plants placed in between the books, adding a touch of greenery. A comfortable armchair ",
  "sits nearby, inviting you to grab a book and lose yourself in its pages for hours.",
  "A bustling city street at night, illuminated by the glow of neon signs and headlights from passing cars. The sidewalk is crowded ",
  "with people heading to bars, restaurants, and shops, while street performers entertain passersby. The air is filled with the sound of honking cars, lively conversations, and the occasional shout from a vendor selling snacks at a nearby stand.",
  "A serene park with lush green grass, blooming cherry blossom trees, and a calm river that runs through the center. People stroll along the winding paths, enjoying the beauty of nature, while a few ducks paddle lazily in the water. Picnic blankets are scattered around, with families and friends enjoying snacks and drinks under the shade of the blossoming trees.",
  "A colorful hot air balloon floating gently through the sky, providing a bird’s eye view of the scenic countryside below. Rolling hills, dotted",
  " with farms and small villages, stretch out in every direction. The sky is clear and blue, with a few fluffy clouds drifting by. The only sound is the occasional whoosh of the balloon’s burner as it ascends higher into the sky.",
  "A quaint little bakery on a quiet street corner, with the scent of freshly baked bread and pastries wafting through the air. Inside, an assortment of delicious treats is displayed behind a glass counter: golden croissants, flaky danishes, and perfectly frosted cupcakes. The bakery is warm and welcoming, with a few small tables where customers can sit and enjoy their sweet treats with a cup of tea or coffee."
];

class Helpers {
  static final calendarDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(8),
    shape: BoxShape.rectangle,
  );

  static Future<String?> getString({required String key}) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final str = sharedPref.getString(key);
    return str;
  }

  static setString({required String key, required String value}) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(key, value);
  }

  ///[Random Color]
  static Color getColorFromName(String name) {
    final hash = name.hashCode;
    final random = Random(hash);
    final r = 200 + random.nextInt(60);
    final g = 200 + random.nextInt(60);
    final b = 200 + random.nextInt(60);
    return Color.fromARGB(255, r, g, b);
  }

  ///[Divider's]
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
              color: AppColors.lightGrey,
            ),
          ),
          Container(
            height: secondThickness,
            width: 25.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.lightGrey,
            ),
          ),
        ],
      ),
    );
  }

  /// [Validator's]
  static String? validateEmail({required String text}) {
    RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    bool isValid = emailRegExp.hasMatch(text);

    if (text.isEmpty) {
      return 'Email is required!';
    }

    if (!isValid) {
      return 'Please enter a valid email!';
    }
    return null;
  }

  static String? validatePassword({required String text}) {
    RegExp passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    bool isValid = passwordRegExp.hasMatch(text);

    if (text.isEmpty) {
      return 'Please enter a password!';
    }

    if (text.length < 8) {
      return 'Password must be at least 8 characters!';
    }

    if (!text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>\-_=+\/]'))) {
      return 'at least one symbol!';
    }

    if (!text.contains(RegExp(r'[A-Z]'))) {
      return 'at least one uppercase letter!';
    }

    if (!text.contains(RegExp(r'[a-z]'))) {
      return 'at least one lowercase letter!';
    }
    if (!text.contains(RegExp(r'[0-9]'))) {
      return 'at least one number!';
    }

    if (!isValid) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number!';
    }

    return null;
  }
}

class GText extends StatelessWidget {
  const GText(
    this.data, {
    super.key,
    this.textAlign,
    this.style,
    this.maxLines,
    this.width,
    this.textDecoration,
    this.overflow,
    this.margin,
  });
  final String data;
  final TextAlign? textAlign;
  final TextStyle? style;
  final int? maxLines;
  final double? width;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin ?? 0),
      width: width,
      child: Text(
        data,
        textScaler: TextScaler.noScaling,
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines,
        style: style,
      ),
    );
  }
}
