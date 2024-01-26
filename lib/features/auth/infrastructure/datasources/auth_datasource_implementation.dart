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

  CognitoUserSession? session;
  CognitoUser? cognitoUser;
  CognitoCredentials? credentials;

  @override
  Future<User> login( String userName, String password ) async{
    final cognitoUser = CognitoUser(userName, userPool);
    final authDetails = AuthenticationDetails(username: userName, password: password);

    try {
      session = await cognitoUser.authenticateUser(authDetails);
      debugPrint('Login Success...');
      final credentials = CognitoCredentials(Environment.identityPoolId, userPool);
      await credentials.getAwsCredentials(session?.getIdToken().getJwtToken());

      final attributes = await cognitoUser?.getUserAttributes();

      User user = User(
        email: 'user@example.com',
        fullName: 'John Doe',
        userName: userName,
        id: '1234567890',
        roles: ['admin', 'user'],
        token: '${session?.getIdToken().getJwtToken()}',
        userType: 'regular',
      );

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

  Future<User> checkAuthStatus( String token ) async {
    final user = await userPool.getCurrentUser();
    final session = await user?.getSession();
    throw UnimplementedError();
  }

  Future<bool?> checkAuthenticated() async {
    if (cognitoUser == null || session == null) {
      return false;
    }
    return session?.isValid();
  }

  Future<CognitoCredentials?> getCredentials() async {
    if (cognitoUser == null || session == null) {
      return null;
    }
    credentials = CognitoCredentials(Environment.identityPoolId, userPool);
    await credentials?.getAwsCredentials(session?.getIdToken().getJwtToken());
    return credentials;
  }

  Future<void> signOut() async {
    final credentials = this.credentials;
    if (credentials != null) {
      await credentials.resetAwsCredentials();
    }
    if (cognitoUser != null) {
      return cognitoUser?.signOut();
    }
  }
}