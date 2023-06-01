import 'package:dlwidgets/dlwidgets.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child:  Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/5), child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3), child: DlCardView(
                child: Column(
                    children: [
                      DlTextFormField(
                  textFieldController: emailController,
                  labelText: "Email",
                        trailingIcon: const Icon(Icons.email),
                ),
                      DlTextFormField(
                        textFieldController: passwordController,
                        labelText: "Password",
                        isPassword: true,
                      ),
                      DlTextFormField(
                        textFieldController: passwordController,
                        labelText: "Mobile",
                        trailingIcon: const Icon(Icons.phone),
                      ),
                    ]
            ))),
            DlButton(buttonName: "Sign Up", size: ButtonSize.small, onPressed: (){
              //todo: sign up call
            }, buttonColor:  Colors.blue),
          ]),
        ),
      )
    );
  }
}
