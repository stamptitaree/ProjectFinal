import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

class ListDrug extends StatefulWidget {
  const ListDrug({super.key});

  @override
  State<ListDrug> createState() => _ListDrugState();
}

class _ListDrugState extends State<ListDrug> {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    var sizeS = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: const Center(child: Text('ข้อมูลยา')),
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
                stream:
                    FirebaseFirestore.instance.collection('ncds').snapshots(),
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
                        String drugList = dataMap['drug_list'];
                        String pharmaEffects = dataMap['pharma_effects'];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Container(
                            width: sizeS.width,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 74, 103, 117),
                                borderRadius: BorderRadius.circular(8)),
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  drugList,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  pharmaEffects,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                )
                              ],
                            ),
                          ),
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
