import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mytest/services/local_notification.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:mytest/widget/navbar_main.dart';

// ignore: must_be_immutable
class Popupnotify extends StatefulWidget {
  int id;
  Popupnotify({super.key, required this.id});

  @override
  State<Popupnotify> createState() => _PopupnotifyState();
}

class _PopupnotifyState extends State<Popupnotify> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final isLoading = StreamController<bool>();
  String drugname = '';
  String drugrange = '';
  String drugnote = '';
  String drugpertime = '';
  String drugtime = '';
  String drugdate = '';

  Future<void> queryData() async {
    isLoading.add(true);
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection("noti")
            .doc(_auth.currentUser?.email)
            .collection("add_drug")
            .where('notify_id', isEqualTo: widget.id.toString())
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      final data = querySnapshot.docs.first.data();
      drugname = data['drug_name'] as String;
      drugrange = data['drug_range'] as String;
      drugnote = data['drug_note'] as String;
      drugpertime = data['drug_pertime'] as String;
      drugtime = data['drug_time'] as String;
      drugdate = data['drug_date'] as String;
    }
    isLoading.add(false);
  }

  @override
  void initState() {
    super.initState();
    queryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
          initialData: true,
          stream: isLoading.stream,
          builder: (context, snapshot) {
            if (snapshot.data!) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      drugdate,
                      style: TextStyle(
                          fontSize: 28,
                          color: GlobalColors.mainColor,
                          fontFamily: 'Prompt'),
                    ),
                    Text(
                      drugtime,
                      style: TextStyle(
                          fontSize: 28,
                          color: GlobalColors.mainColor,
                          fontFamily: 'Prompt'),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, 
                        border: Border.all(
                          color: Colors.black, 
                          width: 3, 
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            AssetImage('assets/images/pillsgif.gif'),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      drugname,
                      style: TextStyle(
                          fontSize: 28,
                          color: GlobalColors.mainColor,
                          fontFamily: 'Prompt'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'จำนวนยาที่ได้รับ $drugpertime ครั้ง',
                      style: TextStyle(
                          fontSize: 16,
                          color: GlobalColors.mainColor,
                          fontFamily: 'Prompt'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'ช่วงเวลา $drugrange ',
                      style: TextStyle(
                          fontSize: 16,
                          color: GlobalColors.mainColor,
                          fontFamily: 'Prompt'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'หมายเหตุ $drugnote ',
                      style: TextStyle(
                          fontSize: 16,
                          color: GlobalColors.mainColor,
                          fontFamily: 'Prompt'),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              LocalNotification().cancelNoti(id: widget.id);
                              Get.to(() => const BottomNavigationBarExample(
                                  selectedIndex: 1));
                            },
                            child: const Image(
                              width: 80,
                              image: AssetImage('assets/images/no.png'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection("noti")
                                  .doc(_auth.currentUser?.email)
                                  .collection("history")
                                  .add({
                                'history_name': drugname,
                                'history_range': drugrange,
                                'history_note': drugnote,
                                'history_pertime': drugpertime,
                                'history_time': drugtime,
                                'history_date': drugdate,
                              });

                              FirebaseFirestore.instance
                                  .collection("noti")
                                  .doc(_auth.currentUser?.email)
                                  .collection("add_drug")
                                  .where('notify_id',
                                      isEqualTo: widget.id.toString())
                                  .get()
                                  .then((querySnapshot) {
                                if (querySnapshot.docs.isNotEmpty) {
                                  querySnapshot.docs.first.reference.delete();
                                }
                              });
                              LocalNotification().cancelNoti(id: widget.id);
                              Get.to(() => const BottomNavigationBarExample(
                                  selectedIndex: 2));
                            },
                            child: const Image(
                              width: 80,
                              image: AssetImage('assets/images/yes.png'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
