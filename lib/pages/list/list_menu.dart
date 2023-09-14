import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytest/widget/appbar_main.dart';
import 'package:mytest/widget/drawer_main.dart';

class ListMenu extends StatefulWidget {
  const ListMenu({super.key});

  @override
  State<ListMenu> createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
  final DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var sizeS = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppbarMain(title: 'รายการยา'),
      body: Column(
        children: [
          Expanded(
              child: SizedBox(
            height: sizeS.height,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('drugs')
                    .doc(FirebaseAuth.instance.currentUser?.email)
                    .collection('add_drug')
                    .where('drug_date',
                        isEqualTo:
                            DateFormat('dd-MM-yyyy').format(_selectedDate))
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return snapshot.data!.size == 0
                      ? Center(
                          child: Row(
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Expanded(
                                child: Text(
                                  'ว่าง',
                                  style: TextStyle(
                                    // fontFamily: 'FC Minimal',
                                    color: Colors.grey[600],
                                    fontSize: 28,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.size,
                          itemBuilder: (context, index) {
                            DocumentSnapshot pill = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Container(
                                  // width: sizeS.width,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 74, 103, 117),
                                      borderRadius: BorderRadius.circular(8)),
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          'ชื่อยา ${(pill.data() as Map<String, dynamic>)['drug_name']}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                      Text(
                                          'จำนวนยาที่ได้รับ ${(pill.data() as Map<String, dynamic>)['drug_pertime']}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                      Text(
                                          'เวลาทานยา ${(pill.data() as Map<String, dynamic>)['drug_time']}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                      Text(
                                          'หมายเหตุ ${(pill.data() as Map<String, dynamic>)['drug_note']}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                      // Text(
                                      //   'drugList',
                                      //   style: const TextStyle(
                                      //       fontSize: 14, color: Colors.white),
                                      // ),
                                      // Text(
                                      //   'pharmaEffects',
                                      //   maxLines: 3,
                                      //   overflow: TextOverflow.ellipsis,
                                      //   style: const TextStyle(
                                      //       fontSize: 14, color: Colors.white),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                }),
          ))
        ],
      ),
      drawer: const DrawerMain(),
    );
  }
}
