import 'package:flutter/material.dart';
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
              Text(
                'ยังไม่มีบัญชี ?',
                style: TextStyle(
                    color: GlobalColors.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.to(Register());
                },
                child: const Text(
                  'สมัครบัญชีผู้ใช้งาน',
                  style: TextStyle(
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
