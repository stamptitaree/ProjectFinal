import 'package:flutter/material.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:mytest/utils/text.from.global.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController drugallergy = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/moreX.png',
                  // width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'N C D s',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: GlobalColors.mainColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/moreX.png',
                  // width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Create your Account',
                    style: TextStyle(
                      color: GlobalColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormGlobal(
                    controller: emailController,
                    text: 'Email',
                    obscure: false,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  TextFormGlobal(
                    controller: passwordController,
                    text: 'Password',
                    obscure: false,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  TextFormGlobal(
                    controller: nameController,
                    text: 'ชื่อ-นามสกุล',
                    obscure: false,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  TextFormGlobal(
                    controller: drugallergy,
                    text: 'ประวัติการแพ้ยา',
                    obscure: false,
                    textInputType: TextInputType.text,
                  ),
                  // TextFormGlobal(
                  //   controller: drugallergy,
                  //   text: 'ประวัติการแพ้ยา',
                  //   obscure: false,
                  //   textInputType: TextInputType.text,
                  // ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
