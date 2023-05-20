import 'package:authenticator/service/aws_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _State();
}

class _State extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordField = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordField.dispose();
    super.dispose();
  }

 void login(String email, String password) {
     AwsService().createInitialRecord(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(alignment: Alignment.center ,children: [SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.all(24), child:
          TextFormField(
            controller: emailController,
           maxLines: 1,
           autofocus: true,
           decoration : InputDecoration(
             hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24)
              ),
            ),
          )),
      Padding(padding: const EdgeInsets.all(24), child: TextFormField(
            controller: passwordField,
            maxLines: 1,
            obscureText: true,
            autocorrect: false,
            decoration : InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24)
              ),
            ),
          )),
          ElevatedButton(onPressed: () {
            login(emailController.text, passwordField.text);
          }, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), child: const Text("Login", style: TextStyle(fontSize: 18, color: Colors.black),))
        ],
      ))],
    ),);
  }
}
