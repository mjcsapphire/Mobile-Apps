import 'package:fcfs_banking_app/core/utils/environment.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:logger/logger.dart';

class AdminFCMService {
  static String? bearerToken;

  static Future<String?> get getToken async =>
      bearerToken ?? await _getBearerToken();

  static Future<String?> _getBearerToken() async {
    try {
      const fMessagingScope =
          'https://www.googleapis.com/auth/firebase.messaging';

      final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": Environment.projectid,
          "private_key_id": Environment.privatekeyid,
          "private_key":
              '-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCCDCp+R1RY6S5w\nj/uQBwWFwcNOIFlyEFnRfqjyX6441YwMODUaSUmVq5aPsU2JE32Ao522xn/mxBq7\nGTOHCp/ZvoUYielagpZ+Dc6QOiVsLT+vnVYS5VsVVNcKOOL/VrccSrQ9u7W6ZhM1\nJSUeZz9vdxuOpJ1a1ayrWZfxBVfGmJc3QAcr012YE8ZG/NP/NjEb+WtZPEE6OLdG\nLDfUArp1FTUMjsmMLXJ0qMym88pxu1xbo1JaVDsTD+paPgonvZniFeE2XRPnYI++\njV/tGmnmMQOnFtGS/V4FtClKWQcui821qAekf9AorJSc7P3usFqVZEDr5paD0XCC\nlOiCe6Z3AgMBAAECggEAOSCJBiHlXo1IVjAZrOI4vdIpLketoxqlqg5+vsHjMZo1\nRCToxtxM08+lewfC7KVAK2M0Y9b81m1s5KWkafzzzV4Q73+dn6Hf5A3CoL66M7QI\n1udBqVlRUqSLNjVZGhuIoof6d2fe47v1UhI4JQvr5NYop9eOPBnDGR5pTXowXc+H\nx4DX7V8N/vhhogZbeX3v+B38lEblaY7IzzSDxuCk1fpPumxsqnqTo10h4kJ5E/hZ\nQmK05uP1e6NUulL7hqkZbNurC2yJcY8ov4kY+r8VLVWHl06QmjKZCCvfGJsHjfOa\nyZnyauSwk/pSYGI5dianpZcJGCrujpnDa16XXoszgQKBgQC24z0Xv8BFPAUoyrLR\ndVHGDu0fQyPQ9trdZOz2s9QrOqysvYtwMoBWm6/crmbAcKJa79zszadE5dgl5d0w\n+OKOnCKo49W2Z76J2SsTaEB7K4gFrE6yGOdeyGuVZ7AjT2eriC0BjJ+j/pD8A7Rr\nzYgRhG1Nl5m7XUKFPjbLDkvEtwKBgQC2CUHjiAFjKUmlTFeMZacMZGEq+l12lN8d\nb0WTtHK2Zuv7F7XqCZugITTcPEV61+wvt3LZ4cjxPHFuPPJGLc9HXiCbasyuiHmx\nm9iddToct2GoqyHUQljo0KpEFO+C3/CmRU4rwyz62c+0x+HhnUQVoZCe8tctkYeV\nK7fXLUrsQQKBgAdlJOFC9alXBfZiS9zAW7AghmIPOvGGKc9t9076cofU9Yp+l5bP\n0/Ssku3fd3QsmcQHku1YW30jthvCMbF7Pt35XkVqAQhBJak5SM6eFo1kczmXgA8f\nhquEeyUtbiffXBfJh9haMVJWRtKJ68+4Hdpnemv6x1KWMMxmeZy4VUP9AoGAcRtl\nbkwmmIeh8+xwhZLv7do9KegwxKqRy4dFExbPJBjlTboY1Ves9B1N6/4jKcYaQjfZ\nTBpnscTdsiJ6YzK5lV2eIxOEJHo2Ky5rtMKPHiKvso7K0Ul8VwS4lt7vR0GAFMAB\nZ125iBBoZ6q+5mHCWTJvWuQG4ZCITx6/9xp0cEECgYBlg8GZQjBnRsVSbpUATBkh\nqb0BGyubPQiW8cSfo7RWxDjrejh7I8aIR9rUq2LRUXB2Kp3a7f+nkT6gwSAJdCxy\nxA5z74Dwog8uiVGxIxktKENSst1JlsCfgJrLpwOhh984TnMJiMRKu3CT+42bn7vQ\nQXHBS+owklHhVu9e8d0h1w==\n-----END PRIVATE KEY-----\n',
          "client_email": Environment.clientEmail,
          "client_id": Environment.clientId,
          "auth_uri": Environment.authUri,
          "token_uri": Environment.tokenUri,
          "auth_provider_x509_cert_url": Environment.authproviderx509certurl,
          "client_x509_cert_url": Environment.clientx509certurl,
          "universe_domain": Environment.universeDomain,
        }),
        [fMessagingScope],
      );

      bearerToken = client.credentials.accessToken.data;
      return bearerToken;
    } catch (e) {
      print('Error getting bearer token: $e');
      Logger().e('Error getting bearer token: $e');
      return null;
    }
  }
}
