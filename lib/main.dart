
import 'package:flutter/material.dart';

import 'component/login_page.dart';

void main() {
Widget app =MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/login_page',
  routes: {
      '/login_page' :(context) => const LoginPage()
  });
  runApp(app);
}