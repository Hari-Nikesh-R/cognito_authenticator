import 'dart:js_interop';

import 'package:authenticator/component/sign_up_page.dart';
import 'package:authenticator/service/aws_service.dart';
import 'package:dlwidgets/dlwidgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _State();
}

class _State extends State<LoginPage> {

  String? token;
  String? emailError;
  String? passwordError;
  String? tickerMessage;
  TickerType? tickerType;

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future login(String email, String password) async {
       token =await AwsService().createInitialRecord(email, password);
       setState(() {
         if(token!=null) {
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
               content: Text("Authenticated")
           ));
           tickerMessage = "Authenticated";
           tickerType = TickerType.success;
         }
         else{
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
               content: Text("Invalid user")
           ));
           tickerMessage = "Invalid user";
           tickerType = TickerType.error;
         }
       });
  }

  TextEditingController textEditingController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late DlTextFormFieldImpl emailField;
  late DlTextFormFieldImpl passWordField;
  @override
  void initState() {
    emailField = DlTextFormFieldImpl(TextEditingController(), (value) {
      setState(() {
        emailField.errorText = null;
        passWordField.errorText = null;
      });
    }, emailError, "Email");
    passWordField = DlTextFormFieldImpl(TextEditingController(), (value) {
      setState(() {
        emailField.errorText = null;
        passWordField.errorText = null;
      });
    }, passwordError, "Password");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/5), child:
        SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3), child: DlCardView(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DlTextFormField(isCenter: false, activeColor: Colors.blue, isPassword: false, input: emailField),
                DlTextFormField(isCenter: false, activeColor: Colors.blue, isPassword: true, input: passWordField),
                tickerType.isDefinedAndNotNull? DlTicker(textInfo: tickerMessage??"", tickerType: tickerType) : Container()
              ],
            ),
          )),
          DlButton(buttonName: "Login", size: ButtonSize.small, onPressed: (){
              setState(() {
                if(textEditingController.text.isEmpty){
                  emailField.errorText = "Email must not be empty";
                  }
                if(passwordController.text.isEmpty){
                  passWordField.errorText = "Password must not be empty";
                }
              });
              login(textEditingController.text, passwordController.text);
          }, buttonColor:  Colors.blue),
          Center(
            child: Padding(padding: const EdgeInsets.all(24), child: GestureDetector(onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
            },child: const Text("Sign up", maxLines: 1, style: TextStyle(color: Colors.blue)),),
          ))
        ],
      ))))],
    ),);
  }
}
