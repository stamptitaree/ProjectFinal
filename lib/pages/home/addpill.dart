import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:mytest/utils/text_input.dart';
import 'package:mytest/widget/adppbar_back.dart';
import 'package:mytest/widget/appbar_main.dart';

class Addpill extends StatefulWidget {
  const Addpill({super.key});

  @override
  State<Addpill> createState() => _AddpillState();
}

class _AddpillState extends State<Addpill> {
  final TextEditingController namepillController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Center(child: Text('เพิ่มยา')),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                // Get.back();
              },
              icon: const Icon(Icons.logout_outlined))
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actionsIconTheme: const IconThemeData(
          color:
              Colors.transparent, // Set the color of the action icons to white
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            const Text('ชื่อยา'),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black38))),
            ),
            SizedBox(height: 10),
            const Text('หมายเหตุ'),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black38))),
            ),
            SizedBox(height: 10),
            const Text('จำนวนยาที่ได้รับต่อครั้ง'),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black38))),
            ),
            SizedBox(height: 10),
            const Text('วันที่'),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black38))),
            ),
            SizedBox(height: 10),
            const Text('เวลา'),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black38))),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {},
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
                child: const Text('ยืนยัน',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            )
          ],
        ),
      )),
    );
  }
}
