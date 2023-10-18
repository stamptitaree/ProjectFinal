import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:mytest/widget/appbar_main.dart';
import 'package:mytest/widget/drawer_main.dart';

class HistoryMenu extends StatefulWidget {
  const HistoryMenu({super.key});

  @override
  State<HistoryMenu> createState() => _HistoryMenuState();
}

class _HistoryMenuState extends State<HistoryMenu> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _dateEditingController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    var sizeS = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppbarMain(title: 'ประวัติยา'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 5),
            child: Row(
              children: [
                const Text('วันที่',
                    style: TextStyle(fontFamily: 'Prompt', fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2030),
                      );

                      if (pickedDate != null) {
                        _selectedDate = pickedDate;
                        final formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          _dateEditingController.text = formattedDate;
                        });
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: _dateEditingController,
                        style: const TextStyle(
                            color: Colors.black, fontFamily: 'Prompt'),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: GlobalColors.borderInput,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: GlobalColors.borderInput,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: SizedBox(
            height: sizeS.height,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('noti')
                    .doc(FirebaseAuth.instance.currentUser?.email)
                    .collection('history')
                    .where('history_date',
                        isEqualTo:
                            DateFormat('yyyy-MM-dd').format(_selectedDate))
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // Convert the snapshot data to a list of DocumentSnapshot
                  List<DocumentSnapshot> historyData = snapshot.data!.docs;

                  // Sort the data based on 'history_date' and then 'history_time'
                  historyData.sort((a, b) {
                    String dateA =
                        (a.data() as Map<String, dynamic>)['history_date'];
                    String timeA =
                        (a.data() as Map<String, dynamic>)['history_time'];
                    String dateB =
                        (b.data() as Map<String, dynamic>)['history_date'];
                    String timeB =
                        (b.data() as Map<String, dynamic>)['history_time'];

                    // First, compare by 'history_date'
                    int dateComparison = dateA.compareTo(dateB);

                    // If 'history_date' is the same, compare by 'history_time'
                    if (dateComparison == 0) {
                      return timeA.compareTo(timeB);
                    } else {
                      return dateComparison;
                    }
                  });

                  return snapshot.data!.docs.isEmpty
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
                                                        fontSize: 14,
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
                                              onTap: () async {
                                                try {
                                                  String docIdToDelete =
                                                      snapshot
                                                          .data!.docs[index].id;
                                                  // print(id);
                                                  bool decide =
                                                      await showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title:  Text(
                                                                  "ต้องการลบประวัติยา \n${(pill.data() as Map<String, dynamic>)['history_name']} ใช่หรือไม่?",
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Prompt',fontSize: 18)),
                                                              content: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context,
                                                                            true);
                                                                      },
                                                                      child: const Text(
                                                                          'ใช่',
                                                                          style:
                                                                              TextStyle(fontFamily: 'Prompt'))),
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context,
                                                                            false);
                                                                      },
                                                                      child: const Text(
                                                                          'ไม่ใช่',
                                                                          style:
                                                                              TextStyle(fontFamily: 'Prompt'))),
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                  if (decide) {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('noti')
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.email)
                                                        .collection('history')
                                                        .doc(docIdToDelete)
                                                        .delete();
                                                    Fluttertoast.showToast(
                                                      msg: "ลบรายการยาสำเร็จ",
                                                    );
                                                  }
                                                } catch (e) {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "เกิดข้อผิดพลาดในการลบข้อมูล",
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                  );
                                                }
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
