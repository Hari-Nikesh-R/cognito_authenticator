import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';

import '../utlis/constants.dart';

class AwsService{


  final userPool = CognitoUserPool(
    USER_POOL_ID, // userPool ID
      CLIENT_ID, // client ID
  );

  Future<String?> createInitialRecord(email, password) async {
    debugPrint('Authenticating User...');
    final cognitoUser = CognitoUser(email, userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );
    debugPrint("Email: $email Pass: $password");
    CognitoUserSession? session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
      debugPrint('Login Success...');
      debugPrint("JWT token: ${session?.getAccessToken().jwtToken}");
      return session?.getAccessToken().jwtToken;

    } on CognitoUserNewPasswordRequiredException catch (exception) {
      debugPrint('CognitoUserNewPasswordRequiredException $exception');
    } on CognitoUserMfaRequiredException catch (exception) {
      debugPrint('CognitoUserMfaRequiredException $exception');
    } on CognitoUserSelectMfaTypeException catch (exception) {
      debugPrint('CognitoUserMfaRequiredException $exception');
    } on CognitoUserMfaSetupException catch (exception) {
      debugPrint('CognitoUserMfaSetupException $exception');
    } on CognitoUserTotpRequiredException catch (exception) {
      debugPrint('CognitoUserTotpRequiredException $exception');
    } on CognitoUserCustomChallengeException catch (exception) {
      debugPrint('CognitoUserCustomChallengeException $exception');
    } on CognitoUserConfirmationNecessaryException catch (exception) {
      debugPrint('CognitoUserConfirmationNecessaryException $exception');
    } on CognitoClientException catch (exception) {
      debugPrint('CognitoClientException $exception');
    } catch (exception) {
      debugPrint(exception.toString());
    }
    return null;
  }
}