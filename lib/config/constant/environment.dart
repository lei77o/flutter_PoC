import 'package:flutter_dotenv/flutter_dotenv.dart';


class Environment {

  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String apiUrl = dotenv.env['API_URL'] ?? 'Error';
  static String userPoolId = dotenv.env['MEPCO_USER_POOL_ID'].toString();
  static String clientId = dotenv.env['MEPCO_CLIENT_ID'].toString();
  static String identityPoolId = dotenv.env['MEPCO_IDENTITY_POOL_ID'].toString();
}

