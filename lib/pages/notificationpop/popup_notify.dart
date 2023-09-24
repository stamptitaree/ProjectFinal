import 'package:flutter/material.dart';
import 'package:mytest/services/local_notification.dart';
import 'package:mytest/utils/global.colors.dart';

// ignore: must_be_immutable
class PopupNotify extends StatefulWidget {
  int id;
  PopupNotify({super.key, required this.id});

  @override
  State<PopupNotify> createState() => _PopupNotifyState();
}

class _PopupNotifyState extends State<PopupNotify> {
  @override
  void initState() {
    super.initState();
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '12.00 PM',
              style: TextStyle(
                  fontSize: 28,
                  color: GlobalColors.mainColor,
                  fontFamily: 'Prompt'),
            ),
            const SizedBox(
              height: 40,
            ),
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/pillspop.png'),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Atorvastatin',
              style: TextStyle(
                  fontSize: 28,
                  color: GlobalColors.mainColor,
                  fontFamily: 'Prompt'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'จำนวนยาที่ได้รับ  1 ครั้ง',
              style: TextStyle(
                  fontSize: 20,
                  color: GlobalColors.mainColor,
                  fontFamily: 'Prompt'),
            ),
            const SizedBox(
              height: 150,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Image(
                      width: 80,
                      image: AssetImage('assets/images/no.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      LocalNotification().cancelNoti(id: widget.id);
                    },
                    child: const Image(
                      width: 80,
                      image: AssetImage('assets/images/yes.png'),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     print('d');
                  //   },
                  //   child: const Image(
                  //     width: 80,
                  //     image: AssetImage('assets/images/slip.png'),
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
