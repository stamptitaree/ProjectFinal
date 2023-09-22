import 'package:flutter/material.dart';
import 'package:mytest/pages/auth/forgot_password.dart';
import 'package:mytest/pages/auth/register.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:get/get.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(Forgotpassword());
                },
                child: Text(
                  'ลืมรหัสผ่าน',
                  style: TextStyle(
                      color: GlobalColors.textColor,
                      fontFamily:'Prompt',
                      
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
              // const SizedBox(height: 10),
              // Text(
              //   'ยังไม่มีบัญชี ?',
              //   style: TextStyle(
              //       color: GlobalColors.textColor,
              //       fontWeight: FontWeight.w600,
              //       fontSize: 18),
              // ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.to(Register());
                },
                child: const Text(
                  'สมัครบัญชีผู้ใช้งาน',
                  style: TextStyle(
                    fontFamily:'Prompt',
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
