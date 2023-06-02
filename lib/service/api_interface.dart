import 'dart:convert';

import 'package:authenticator/utlis/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/registeration_model.dart';
import '../utlis/urls.dart';

class ApiInterface{
  Future<String?> register(RegisterationModel registerationModel) async{
    var client = Client();
    try{
        var response =await client.post(Uri.parse(COGNITO_SERVICE+REGISTER), headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        }, body: registerDetailToJson(registerationModel)
        );
        if(response.statusCode == 200){
          debugPrint(response.body.toString());
          return "Register successfully";
        }
        else{
          debugPrint("came in else");
        }
    }
    catch(e){
        debugPrint("Exception: ${e.toString()}");
    }
    return null;
  }

  Future<String?> verifyRegistrationCode(String userDetail, String code) async{
    var client = Client();
    try{
      var response =await client.post(Uri.parse("${COGNITO_SERVICE+REGISTER}/verify?userName=$userDetail&code=$code"), headers: {
      "Accept": "application/json",
      "content-type": "application/json"
      });
      if(response.statusCode == 200){
        debugPrint(response.body.toString());
        return response.body;
      }
      }
      catch(e){
        debugPrint("Exception: ${e.toString()}");
      }
    return null;
  }
}