import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/utils/global.colors.dart';

// ignore: must_be_immutable
class ListpillDetail extends StatefulWidget {
  dynamic obj;
  ListpillDetail({super.key, required this.obj});

  @override
  State<ListpillDetail> createState() => _ListpillDetailState();
}

class _ListpillDetailState extends State<ListpillDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: const Center(
            child: Text('รายละเอียด', style: TextStyle(fontFamily: 'Prompt'))),
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
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 156, 80, 80),
                      // borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                     'ยา : ${widget.obj['drug_list']}',
                      style: const TextStyle(fontSize: 16, fontFamily: 'Prompt'),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color:  Color.fromARGB(255, 185, 148, 148),
                      // borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                     'ปฏิกิริยาระหว่างยา : ${widget.obj['drug_inter_list']}',
                      style: const TextStyle(fontSize: 16, fontFamily: 'Prompt'),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      // borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                     'รายละเอียด : ${widget.obj['detail']}',
                      style: const TextStyle(fontSize: 16, fontFamily: 'Prompt'),
                    ),
                  ),
                ],
              );
            },
          ),
        ]),
      ),
    );
  }
}
