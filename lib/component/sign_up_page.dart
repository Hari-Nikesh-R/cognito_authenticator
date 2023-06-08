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

  String? passwordError;
  String? emailError;
  String? phoneError;
  String? roleError;
  String? value;
  late DlTextFormFieldImpl emailField;
  late DlTextFormFieldImpl passWordField;
  late DlTextFormFieldImpl phoneField;
  late DlTextFormFieldImpl roleField;

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

  void removeErrorText(){
    emailError = null;
    passwordError = null;
    phoneError = null;
    roleError = null;
  }

  @override
  void initState() {
    // TODO: implement initState
    emailField = DlTextFormFieldImpl(TextEditingController(), (value) {
      setState(() {
        removeErrorText();
      });
    }, emailError, "Email");
    passWordField = DlTextFormFieldImpl(TextEditingController(), (value) {
      setState(() {
        removeErrorText();
      });
    }, passwordError, "Password");
    phoneField = DlTextFormFieldImpl(TextEditingController(), (value) {
      setState(() {
        removeErrorText();
      });
    }, phoneError, "Phone");
    roleField = DlTextFormFieldImpl(TextEditingController(), (value) {
      setState(() {
        removeErrorText();
      });
    }, roleError, "Role");
    super.initState();

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
                        input: emailField,
                        trailingIcon: const Icon(Icons.email),
                ),
                      DlTextFormField(
                       input: passWordField,
                        isPassword: true,
                      ),
                      DlTextFormField(
                        input: phoneField,
                        trailingIcon: const Icon(Icons.phone),
                      ),
                      DlTextFormField(
                        input: roleField,
                        trailingIcon: const Icon(Icons.admin_panel_settings),
                      ),
                    ]
            ))),
            DlButton(buttonName: "Sign Up", size: ButtonSize.small, onPressed: (){
              //todo: sign up call
              setState(() {
                  if(emailField.textFieldController.text.isEmpty){
                    emailError = "Email must not be empty";
                  }
                  if(passWordField.textFieldController.text.isEmpty){
                    passwordError = "Password must not be empty";
                  }
                  if(phoneField.textFieldController.text.isEmpty){
                    phoneError = "Mobile number must not be empty";
                  }
                  if(roleField.textFieldController.text.isEmpty){
                    roleError = "Role must not be empty";
                  }

              });
              RegisterationModel registerModel = RegisterationModel(
                password: passWordField.textFieldController.text,
                  username: emailField.textFieldController.text,
                  userAttributes: [
                    UserAttribute(name: "phone_number", value:"+91${phoneField.textFieldController.text}"),
                    UserAttribute(name: "custom:role", value: roleField.textFieldController.text)
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
