import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:veegil/controller/sign_up_controller.dart';
import 'package:veegil/screens/login_screen.dart';
import 'package:veegil/widget/input_field.dart';
import 'package:veegil/widget/submit_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  SignUpController signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 90),
            child: Text("   Welcome \n Dev Banker",style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InputTextFieldWidget(signUpController.phoneController,
                TextInputType.phone,false, 'Enter Phone Number'),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InputTextFieldWidget(signUpController.passwordController,
                TextInputType.visiblePassword,true, 'Enter Password'),
          ),
          const SizedBox(
            height: 20,
          ),
          SubmitButton(
            onPressed: () => signUpController.signUpPhone(),
            title: 'Sign Up',
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already Registered?',style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
              TextButton(
                  onPressed: () async {
                    Get.offAll(const LoginScreen());
                  },
                  child: const Text('Login',
                    style: TextStyle(color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  )),
            ],
          )
        ],
      ),


    );
  }
}
