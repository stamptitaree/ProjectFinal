import 'package:flutter/material.dart';
import 'package:mytest/utils/global.colors.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            '-Or sign in with-',
            style: TextStyle(
              color: GlobalColors.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Column(
          children: [
            Text(
              'ยังไม่มีบัญชี ?',
              style: TextStyle(
                color: GlobalColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'สมัครบัญชีผู้ใช้งาน',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
