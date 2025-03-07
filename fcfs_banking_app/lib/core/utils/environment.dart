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

  static String get currencyUrl {
    return dotenv.env['CURRENCY_URL'] ?? 'CURRENCY_URL not found!';
  }

  static String get currencyApiKey {
    return dotenv.env['CURRENCY_API_KEY'] ?? 'CURRENCY_API_KEY not found!';
  }

  static String get projectid {
    return dotenv.env['project_id'] ?? 'project_id not found!';
  }

  static String get privatekeyid {
    return dotenv.env['private_key_id'] ?? 'project_id not found!';
  }

  // static String get privatekey {
  //   return dotenv.env['private_key'] ?? 'project_id not found!';
  // }
  static String get clientEmail {
    return dotenv.env['client_email'] ?? 'project_id not found!';
  }

  static String get clientId {
    return dotenv.env['client_id'] ?? 'project_id not found!';
  }

  static String get authUri {
    return dotenv.env['auth_uri'] ?? 'project_id not found!';
  }

  static String get tokenUri {
    return dotenv.env['token_uri'] ?? 'project_id not found!';
  }

  static String get authproviderx509certurl {
    return dotenv.env['auth_provider_x509_cert_url'] ?? 'project_id not found!';
  }

  static String get clientx509certurl {
    return dotenv.env['client_x509_cert_url'] ??
        'client_x509_cert_url not found!';
  }

  static String get universeDomain {
    return dotenv.env['universe_domain'] ?? 'universe_domain not found!';
  }
}
