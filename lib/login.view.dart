import 'package:flutter/material.dart';
import 'package:mytest/Splash.view.dart';
import 'package:mytest/utils/button.global.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:mytest/utils/social.login.dart';
import 'package:mytest/utils/text.from.global.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            // color: Colors.green,//
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
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
                      ),
                    ),
                    const SizedBox(height: 15),
                    //// Email Input
                    TextFormGlobal(
                      controller: emailController,
                      text: 'Email',
                      obscure: false,
                      textInputType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 15),

                    //// Password Input ///
                    TextFormGlobal(
                      controller: passwordController,
                      text: 'Password',
                      textInputType: TextInputType.text,
                      obscure: true,
                    ),

                    const SizedBox(height: 15),
                    const ButtonGlobal(),
                    const SizedBox(height: 80),
                    const SocialLogin()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
