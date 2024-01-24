import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
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

class AWSServices {
  final userPool = CognitoUserPool(
    '${(dotenv.env['MEPCO_USER_POOL_ID'])}',
    '${(dotenv.env['MEPCO_CLIENT_ID'])}',
  );

  Future createInitialRecord(username, password) async {
    /*debugPrint('Authenticating User...');
    final cognitoUser = CognitoUser(username, userPool);
    final authDetails = AuthenticationDetails(username: username, password: password);

    CognitoUserSession? session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
      print(session);
      debugPrint('Login Success...');
    } on CognitoUserNewPasswordRequiredException catch (e) {
      debugPrint('CognitoUserNewPasswordRequiredException $e');
    } on CognitoUserMfaRequiredException catch (e) {
      debugPrint('CognitoUserMfaRequiredException $e');
    } on CognitoUserSelectMfaTypeException catch (e) {
      debugPrint('CognitoUserMfaRequiredException $e');
    } on CognitoUserMfaSetupException catch (e) {
      debugPrint('CognitoUserMfaSetupException $e');
    } on CognitoUserTotpRequiredException catch (e) {
      debugPrint('CognitoUserTotpRequiredException $e');
    } on CognitoUserCustomChallengeException catch (e) {
      debugPrint('CognitoUserCustomChallengeException $e');
    } on CognitoUserConfirmationNecessaryException catch (e) {
      debugPrint('CognitoUserConfirmationNecessaryException $e');
    } on CognitoClientException catch (e) {
      debugPrint('CognitoClientException $e');
    } catch (e) {
      print(e);
    }

    final credentials = CognitoCredentials('${(dotenv.env['MEPCO_IDENTITY_POOL_ID'])}', userPool);
    await credentials.getAwsCredentials(session?.getIdToken().getJwtToken());
    print(session?.getIdToken().getJwtToken());*/
  }
}