import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:veegil/controller/login_controller.dart';
import 'package:veegil/screens/register_screen.dart';
import 'package:veegil/widget/input_field.dart';
import 'package:veegil/widget/submit_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
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
                child: InputTextFieldWidget(loginController.phoneController,
                    TextInputType.phone,false, 'Enter Phone Number'),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InputTextFieldWidget(loginController.passwordController,
                    TextInputType.visiblePassword,true, 'Enter Password'),
              ),
              const SizedBox(
                height: 20,
              ),
              SubmitButton(
                onPressed: () => loginController.loginPhone(),
                title: 'Login',
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Yet to register?',style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                  TextButton(
                      onPressed: () async {
                        Get.offAll(const RegisterScreen());
                      },
                      child: const Text('SignUp',
                        style: TextStyle(color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      )),
                ],
              )
            ],
          ),
        ),


    );
  }
}
