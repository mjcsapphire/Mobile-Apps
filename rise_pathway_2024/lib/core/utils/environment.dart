import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      debugPrint("Running on Production");
      return '.env';
      // return 'production.env';
    } else {
      debugPrint("Running on Development");
      return 'lib/.env';
      // return 'production.env';
    }
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
}
