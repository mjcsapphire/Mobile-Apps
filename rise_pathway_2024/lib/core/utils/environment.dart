import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      log("Running on Production");
      return '.env.production';
    }
    log("Running on Development");
    return '.env.development';
  }

  static String get apiBaseUrl {
    debugPrint("Running on ${dotenv.env['API_BASE_URL']}");
    return dotenv.env['API_BASE_URL'] ??
        "API_BASE_URL not found in environment";
  }

  static String get apiImageUrl {
    debugPrint("Running on ${dotenv.env['UPLOAD_URL']}");
    return dotenv.env['UPLOAD_URL'] ?? "UPLOAD_URL not found in environment";
  }
  static String get mediaImageUrl {
    debugPrint("Running on ${dotenv.env['IMAGE_URL']}");
    return dotenv.env['IMAGE_URL'] ?? "IMAGE_URL not found in environment";
  }
}
