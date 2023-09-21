import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytest/widget/appbar_main.dart';
import 'package:mytest/widget/drawer_main.dart';
import 'dart:math';

class ListMenu extends StatefulWidget {
  const ListMenu({super.key});

  @override
  State<ListMenu> createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
  final DateTime _selectedDate = DateTime.now();
  final Random random = Random();

  List<String> avatarImages = <String>[
    'assets/images/pills.png',
    'assets/images/pillsX.png',
    'assets/images/medicine1.png',
    'assets/images/medicine2.png',
  ];

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
                          physics: const ClampingScrollPhysics(),
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
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 114, 110, 110),
                                      borderRadius: BorderRadius.circular(8)),
                                  height: 100,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 200, 210, 218),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const CircleAvatar(
                                          radius: 36,
                                          backgroundImage: AssetImage(
                                              'assets/images/pills.png'
                                              // avatarImages[random.nextInt(avatarImages.length)],
                                              ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                              'เวลาทานยา : ${(pill.data() as Map<String, dynamic>)['drug_time']}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white)),
                                          Text(
                                              'หมายเหตุ : ${(pill.data() as Map<String, dynamic>)['drug_note']}',
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          GestureDetector(
                                            onTap: () {
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          ),
                                        ],
                                      )
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
