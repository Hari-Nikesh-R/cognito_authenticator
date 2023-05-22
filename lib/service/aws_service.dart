import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AwsService{

  String calculateSecretHash(String clientSecret, String userPoolId, String clientId) {
    final message = utf8.encode(userPoolId + clientId);
    final key = utf8.encode(clientSecret);
    final hmacSha256 = Hmac(sha256, key); // Use HmacSha256 for hashing
    final signature = hmacSha256.convert(message);
    final signatureBytes = signature.bytes;
    final secretHash = base64.encode(signatureBytes);
    return secretHash;
  }

  final userPool = CognitoUserPool(
      "eu-north-1_nL5JTG6wK	",
      '32htgkd910uguj8ih9idof1pec',
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