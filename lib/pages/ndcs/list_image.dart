import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/utils/global.colors.dart';

// ignore: must_be_immutable
class Listimage extends StatefulWidget {
  dynamic obj;
  Listimage({super.key, required this.obj});

  @override
  State<Listimage> createState() => _ListimageState();
}

class _ListimageState extends State<Listimage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Center(
            child: Text(widget.obj['disease_name'],
                style: const TextStyle(fontFamily: 'Prompt'))),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout_outlined))
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actionsIconTheme: const IconThemeData(
          color: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.obj['image_all'].length,
            itemBuilder: (context, index) {
              // แสดงรูปภาพที่ index
              return Image.network(widget.obj['image_all'][index]);
            },
          ),
        ]),
      ),
    );
  }
}
