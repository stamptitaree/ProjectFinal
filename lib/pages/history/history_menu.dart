import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytest/widget/appbar_main.dart';
import 'package:mytest/widget/drawer_main.dart';

class HistoryMenu extends StatefulWidget {
  const HistoryMenu({super.key});

  @override
  State<HistoryMenu> createState() => _HistoryMenuState();
}

class _HistoryMenuState extends State<HistoryMenu> {
  @override
  Widget build(BuildContext context) {
    var sizeS = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppbarMain(title: 'ประวัติยา'),
      body: Column(
        children: [
          Expanded(
              child: SizedBox(
            height: sizeS.height,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('drugs')
                    .doc(FirebaseAuth.instance.currentUser?.email)
                    .collection('history')
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
                                      fontFamily: 'Prompt'),
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
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 20),
                                  child: Container(
                                    // width: sizeS.width,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 114, 110, 110),
                                        borderRadius: BorderRadius.circular(8)),
                                    height: 140,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
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
                                                    'วันที่ : ${(pill.data() as Map<String, dynamic>)['history_date']}',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontFamily: 'Prompt')),
                                                Text(
                                                    'ชื่อยา : ${(pill.data() as Map<String, dynamic>)['history_name']}',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontFamily: 'Prompt')),
                                                Text(
                                                    'จำนวนยาที่ได้รับ : ${(pill.data() as Map<String, dynamic>)['history_pertime']}',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontFamily: 'Prompt')),
                                                Text(
                                                    'เวลาทานยา : ${(pill.data() as Map<String, dynamic>)['history_time']}',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontFamily: 'Prompt')),
                                                Text(
                                                    'หมายเหตุ : ${(pill.data() as Map<String, dynamic>)['history_note']}',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontFamily: 'Prompt')),
                                              ],
                                            ),
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
                                                String docIdToDelete = snapshot
                                                    .data!.docs[index].id;
                                                // print(id);
                                                FirebaseFirestore.instance
                                                    .collection('drugs')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser?.email)
                                                    .collection('history')
                                                    .doc(docIdToDelete)
                                                    .delete()
                                                    .then((_) {
                                                  Fluttertoast.showToast(
                                                      msg: "ลบรายการยาสำเร็จ");
                                                }).catchError((error) {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "เกิดข้อผิดพลาดในการลบข้อมูล",
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                  );
                                                });
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, top: 125),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 8,
                                            right: 10,
                                            bottom: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: const Text(
                                          'ได้รับยาแล้ว',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontFamily: 'Prompt'),
                                        ),
                                      ),
                                    ))
                              ],
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
