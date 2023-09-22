import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mytest/Splash.view.dart';

import 'package:mytest/utils/global.colors.dart';
import 'package:mytest/utils/social.login.dart';
import 'package:mytest/utils/text.from.global.dart';
import 'package:mytest/widget/navbar_main.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  void signIn(String email, String password) async {
  if (formKey.currentState != null && formKey.currentState!.validate()) {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // ignore: unused_local_variable
        String uid = userCredential.user!.uid; // นำ uid มาเก็บในตัวแปร
        Fluttertoast.showToast(msg: "Login Successful");
        // เรียกใช้ BottomNavigationBarExample ด้วยการส่ง uid ไปด้วย
        Get.offAll(() =>
        const BottomNavigationBarExample(),
        predicate: (route) {
          return route.isFirst; 
          },
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'ไม่พบผู้ใช้อีเมลหรือรหัสผ่านผิด');
      // ignore: avoid_print
      print("Error: $e");
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            // color: Colors.green,//
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Applogo(),
                  const SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Login to you accoun',
                        style: TextStyle(
                          color: GlobalColors.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily:'Prompt'
                          
                        ),
                      ),
                      const SizedBox(height: 15),
                      //// Email Input
                      TextFormGlobal(
                        controller: emailController,
                        text: 'Email',
                        obscure: false,
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("กรุณาใส่อีเมลของคุณ");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("กรุณาใส่อีเมลของคุณให้ถูกต้อง");
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      //// Password Input ///
                      TextFormGlobal(
                        controller: passwordController,
                        text: 'Password',
                        textInputType: TextInputType.text,
                        obscure: true,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("กรุณาใส่หรัสผ่านของคุณ");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("กรุณาใส่รหัสผ่านให้ถูกต้อง(Min. 6 Character)");
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: (){
                          signIn(emailController.text, passwordController.text);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: GlobalColors.mainColor,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: const Text('Sing In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily:'Prompt'
                                
                              )),
                        ),
                      ),
                      const SizedBox(height: 80),
                      const SocialLogin()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
