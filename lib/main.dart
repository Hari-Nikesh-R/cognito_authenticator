
import 'dart:js';

import 'package:authenticator/component/sign_up_page.dart';
import 'package:flutter/material.dart';

import 'component/login_page.dart';

void main() {
Widget app =MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/login_page',
  routes: {
      '/login_page' :(context) => const LoginPage(),
    '/sign_up':(context) => const SignUpPage()
  });
  runApp(app);
}