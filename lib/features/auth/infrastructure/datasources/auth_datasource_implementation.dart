import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/domain/datasources/auth_datasource.dart';

import '../../domain/entities/user.dart';

class AuthDataSourceImplementation extends AuthDataSource{

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );

  final userPool = CognitoUserPool(
      Environment.userPoolId, Environment.clientId
  );

  @override
  Future<User> login( String userName, String password ) async{
    final cognitoUser = CognitoUser(userName, userPool);
    final authDetails = AuthenticationDetails(username: userName, password: password);

    CognitoUserSession? session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
      print(session);
      debugPrint('Login Success...');
      final credentials = CognitoCredentials(Environment.identityPoolId, userPool);
      await credentials.getAwsCredentials(session?.getIdToken().getJwtToken());
      print(session?.getIdToken().getJwtToken());
      final user = null;
      return user;
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



    throw UnimplementedError();
  }

  @override
  Future<User> register( String email, String password, String fullName ) {
    // TODO: implement register
    throw UnimplementedError();
  }

  Future<User> checkAuthStatus( String token ) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }
}