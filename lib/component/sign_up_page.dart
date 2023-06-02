import 'package:authenticator/component/pin_verification_page.dart';
import 'package:authenticator/model/registeration_model.dart';
import 'package:authenticator/service/api_interface.dart';
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
  TextEditingController mobileController = TextEditingController();

  String? passwordError;
  String? emailError;
  String? phoneError;
  String? value;

  signUp(RegisterationModel registerationModel) async{
    value =  await ApiInterface().register(registerationModel);
    setState(() {
      if(value == "User Registered Successfully"){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("User Registered Successfully")
        ));
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyPage(detail: registerationModel.username)));
    });
  }


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
                        errorText: emailError,
                        onChanged: (value){
                          setState(() {
                            emailError = null;
                            passwordError = null;
                            phoneError = null;
                          });
                        },
                ),
                      DlTextFormField(
                        textFieldController: passwordController,
                        labelText: "Password",
                        isPassword: true,
                        errorText: passwordError,
                        onChanged: (value){ setState(() {
                          emailError = null;
                          passwordError = null;
                          phoneError = null;
                        });

                        },
                      ),
                      DlTextFormField(
                        textFieldController: mobileController,
                        labelText: "Mobile",
                        trailingIcon: const Icon(Icons.phone),
                        errorText: phoneError,
                        onChanged: (value){ setState(() {
                          emailError = null;
                          passwordError = null;
                          phoneError = null;
                        });
                        },
                      ),
                    ]
            ))),
            DlButton(buttonName: "Sign Up", size: ButtonSize.small, onPressed: (){
              //todo: sign up call
              setState(() {
                  if(emailController.text.isEmpty){
                    emailError = "Email must not be empty";
                  }
                  if(passwordController.text.isEmpty){
                    passwordError = "Password must not be empty";
                  }
                  if(mobileController.text.isEmpty){
                    phoneError = "Mobile number must not be empty";
                  }
              });
              RegisterationModel registerModel = RegisterationModel(
                password: passwordController.text, 
                  username: emailController.text,
                  userAttributes: [
                    UserAttribute(name: "phone_number", value:"+91${mobileController.text}")
                  ]
              );
              signUp(registerModel);

            }, buttonColor:  Colors.blue),
          ]),
        ),
      )
    );
  }
}
