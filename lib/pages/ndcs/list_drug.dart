
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/pages/ndcs/list_image.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mytest/widget/buttom_main.dart';
// import 'package:firebase_core/firebase_core.dart';

class ListDrug extends StatefulWidget {
  const ListDrug({super.key});

  @override
  State<ListDrug> createState() => _ListDrugState();
}

class _ListDrugState extends State<ListDrug> {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  List<String> disease = <String>[
    'assets/icons/ความรู้โรค.png',
    'assets/icons/เบาหวาน.png',
    'assets/icons/หลอดเลือดสมอง.png',
    'assets/icons/ปอดอุดกั้น.png',
    'assets/icons/โรคความดันโลหิต.png',
    'assets/icons/ไขมันในเลือดสูง.png',
    'assets/icons/โรคไต.png',
    'assets/icons/มะเร็ง.png',
  ];

  @override
  Widget build(BuildContext context) {
    var sizeS = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: const Center(
            child: Text('ความรู้เรื่องโรค',
                style: TextStyle(fontFamily: 'Prompt'))),
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
          color: Colors.transparent,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: sizeS.height,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('diseasencds')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ncds = snapshot.data!.docs[index];
                      List<dynamic> dataArray =
                          ncds['data']; // เข้าถึง array 'data'

                      // ทำการเลือกข้อมูลในแต่ละ Map และแสดงผล 'drug_list'
                      List<Widget> drugListWidgets = dataArray.map((dataMap) {
                        String diseaseName = dataMap['disease_name'];
                        final diseaseImagePath = disease[index++];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 9 ,bottom: 9),
                          child: PressableContainer(
                            onPressed: () {
                              print(dataMap);
                              Get.to(() => Listimage(obj: dataMap));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 200, 210, 218),
                                      shape: BoxShape.circle,
                                    ),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          AssetImage(diseaseImagePath),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      diseaseName,
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'Prompt',
                                          color: Color(0xFF7A6C6C)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // child: Container(
                          //   width: sizeS.width,
                          //   padding: const EdgeInsets.all(10.0),
                          //   decoration: BoxDecoration(
                          //       color: const Color.fromARGB(255, 74, 103, 117),
                          //       borderRadius: BorderRadius.circular(8)),
                          //   height: 100,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         disease_name,
                          //         style: const TextStyle(
                          //             fontSize: 14, color: Colors.white),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        );
                      }).toList();

                      return Column(
                        children: drugListWidgets,
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
