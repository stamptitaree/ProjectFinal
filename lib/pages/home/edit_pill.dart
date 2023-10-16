import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mytest/services/local_notification.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:mytest/widget/navbar_main.dart';

// ignore: must_be_immutable
class Editpill extends StatefulWidget {
  String idEdit;
  Editpill({super.key, required this.idEdit});

  @override
  State<Editpill> createState() => _EditpillState();
}

class _EditpillState extends State<Editpill> {
  final TextEditingController namepillController = TextEditingController();
  final TextEditingController rangepillController = TextEditingController();
  final TextEditingController notepillController = TextEditingController();
  final TextEditingController daypillController = TextEditingController();
  final TextEditingController pertimepillController = TextEditingController();
  final TextEditingController _timeEditingController = TextEditingController();
  final TextEditingController _dateEditingController = TextEditingController();

  String _uid = '';
  late String _time;
  late String _date;
  var idNoti;
  final isLoading = StreamController<bool>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  List<String> listPeriod = <String>['เช้า', 'กลางวัน', 'เย็น', 'ก่อนนอน'];
  String? dropdownValuePeriod;

  List<String> listDay = <String>['1', '3', '5', '7'];
  String? dropdownValueDay;

  List<String> listNote = <String>['ก่อนอาหาร', 'หลังอาหาร'];
  String? dropdownValueNote;

  Future<void> findUid() async {
    isLoading.add(true);
    _auth.authStateChanges().listen((event) async {
      if (event != null) {
        setState(() {
          _uid = event.uid;
        });

        if (_uid.isNotEmpty) {
          DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
              .collection("noti")
              .doc(FirebaseAuth.instance.currentUser?.email)
              .collection('add_drug')
              .doc(widget.idEdit)
              .get();

          namepillController.text = userSnapshot.get('drug_name');

          rangepillController.text = userSnapshot.get('drug_range');

          notepillController.text = userSnapshot.get('drug_note');

          daypillController.text = userSnapshot.get('drug_day');

          pertimepillController.text = userSnapshot.get('drug_pertime');

          // _timeEditingController.text = userSnapshot.get('drug_time');

          _time = userSnapshot.get('drug_time');
          _timeEditingController.text = _time;

          // _dateEditingController.text = userSnapshot.get('drug_date');

          _date = userSnapshot.get('drug_date');
          _dateEditingController.text = _date;

          idNoti = userSnapshot.get('notify_id');

          isLoading.add(false);
        }
      }
    });
  }

  Future<void> editvalue() async {
    try {
      if (_time != _timeEditingController.text ||
          _date != _dateEditingController.text) {
        bool decide = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("ต้องการแก้ไขเวลาแจ้งเตือนใช่หรือไม่?" ,style: TextStyle(fontFamily: 'Prompt')),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('ใช่' ,style: TextStyle(fontFamily: 'Prompt'))),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('ไม่ใช่',style: TextStyle(fontFamily: 'Prompt'))),
                  ],
                ),
              );
            });
        if (decide) {
          LocalNotification().cancelNoti(id: int.parse(idNoti));
          // ignore: non_constant_identifier_names
          var create_date = DateTime.parse(
              "${_dateEditingController.text} ${_timeEditingController.text}:00");
          String id =
              "${create_date.month.toString().padLeft(2, '9')}${(create_date.day).toString().padLeft(2, '0')}${create_date.hour}${create_date.minute.toString().padLeft(2, '0')}0";
          await FirebaseFirestore.instance
              .collection("noti")
              .doc(FirebaseAuth.instance.currentUser?.email)
              .collection('add_drug')
              .doc(widget.idEdit)
              .update({
            'drug_name': (namepillController.text).trim(),
            'drug_range': rangepillController.text,
            'drug_note': notepillController.text,
            'drug_day': daypillController.text,
            'drug_pertime': pertimepillController.text,
            'drug_time': _timeEditingController.text,
            'drug_date': _dateEditingController.text,
            'notify_id': id
          });

          LocalNotification().simpleNotificationShow(
              create_date, int.parse(daypillController.text));
        }
      } else {
        await FirebaseFirestore.instance
            .collection("noti")
            .doc(FirebaseAuth.instance.currentUser?.email)
            .collection('add_drug')
            .doc(widget.idEdit)
            .update({
          'drug_name': namepillController.text,
          'drug_range': rangepillController.text,
          'drug_note': notepillController.text,
          'drug_day': daypillController.text,
          'drug_pertime': _dateEditingController.text,
        });
      }
      findUid();
      Fluttertoast.showToast(
        msg: "บันทึกเสร็จสมบูรณ์",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Get.to(() => const BottomNavigationBarExample(selectedIndex: 1));
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    findUid();
  }

  @override
  void dispose() {
    _dateEditingController.dispose();
    _timeEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: const Center(
            child:
                Text('แก้ไขรายการยา', style: TextStyle(fontFamily: 'Prompt'))),
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
      body: StreamBuilder<bool>(
          initialData: true,
          stream: isLoading.stream,
          builder: (context, snapshot) {
            if (snapshot.data!) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                  child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('ชื่อยา',
                              style: TextStyle(fontFamily: 'Prompt')),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: namepillController,
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
                              style: const TextStyle(
                                fontFamily: 'Prompt',
                              ),
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{3,}$');
                                if (value!.isEmpty) {
                                  return ("กรุณาใส่ชื่อ");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("กรุณาใส่ชื่อ ให้ถูกต้อง(Min. 3 Character)");
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('ช่วงเวลา',
                              style: TextStyle(fontFamily: 'Prompt')),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 56,
                              padding: const EdgeInsets.only(top: 3, left: 15),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border:
                                    Border.all(color: GlobalColors.borderInput),
                              ),
                              child: DropdownButton<String>(
                                hint: const Text('เลือกช่วงเวลา',
                                    style: TextStyle(fontFamily: 'Prompt')),
                                isExpanded: true,
                                value: dropdownValuePeriod ??
                                    rangepillController.text,
                                elevation: 16,
                                style: TextStyle(
                                    color: GlobalColors.textColor,
                                    fontFamily: 'Prompt'),
                                underline: Container(),
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValuePeriod = value!;
                                  });
                                },
                                items: listPeriod.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('หมายเหตุ',
                              style: TextStyle(fontFamily: 'Prompt')),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 56,
                              padding: const EdgeInsets.only(top: 3, left: 15),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border:
                                    Border.all(color: GlobalColors.borderInput),
                              ),
                              child: DropdownButton<String>(
                                hint: const Text('เลือกหมายเหตุ',
                                    style: TextStyle(fontFamily: 'Prompt')),
                                isExpanded: true,
                                value: dropdownValueNote ??
                                    notepillController.text,
                                elevation: 16,
                                style: TextStyle(
                                    color: GlobalColors.textColor,
                                    fontFamily: 'Prompt'),
                                underline: Container(),
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValueNote = value!;
                                  });
                                },
                                items: listNote.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Row(
                      //   children: [
                      //     const Text('จำนวนวัน',
                      //         style: TextStyle(fontFamily: 'Prompt')),
                      //     const SizedBox(width: 10),
                      //     Expanded(
                      //       child: Container(
                      //         height: 56,
                      //         padding: const EdgeInsets.only(top: 3, left: 15),
                      //         decoration: BoxDecoration(
                      //           borderRadius:
                      //               const BorderRadius.all(Radius.circular(10)),
                      //           border:
                      //               Border.all(color: GlobalColors.borderInput),
                      //         ),
                      //         child: DropdownButton<String>(
                      //           hint: const Text('เลือกจำนวนวัน',
                      //               style: TextStyle(fontFamily: 'Prompt')),
                      //           isExpanded: true,
                      //           value: dropdownValueDay,
                      //           // icon: const Icon(Icons.arrow_downward),
                      //           elevation: 16,
                      //           style: TextStyle(
                      //               color: GlobalColors.textColor,
                      //               fontFamily: 'Prompt'),
                      //           underline: Container(),
                      //           onChanged: (String? value) {
                      //             // This is called when the user selects an item.
                      //             setState(() {
                      //               dropdownValueDay = value!;
                      //             });
                      //             // if (value != null && value.isNotEmpty) {
                      //             //   daypillController.text = value;
                      //             // } else {
                      //             //   daypillController.text = '';
                      //             // }
                      //           },
                      //           items: listDay.map<DropdownMenuItem<String>>(
                      //               (String value) {
                      //             return DropdownMenuItem<String>(
                      //               value: value,
                      //               child: Text(value),
                      //             );
                      //           }).toList(),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        children: [
                          const Text('จำนวนวัน',
                              style: TextStyle(fontFamily: 'Prompt')),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: daypillController,
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
                              style: const TextStyle(
                                fontFamily: 'Prompt',
                              ),
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{3,}$');
                                if (value!.isEmpty) {
                                  return ("กรุณาใส่ชื่อ");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("กรุณาใส่ชื่อ ให้ถูกต้อง(Min. 3 Character)");
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('จำนวนยาที่ได้รับต่อครั้ง',
                              style: TextStyle(fontFamily: 'Prompt')),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: pertimepillController,
                              keyboardType: TextInputType.number,
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
                              style: const TextStyle(
                                fontFamily: 'Prompt',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('เวลารับประทานยา',
                              style: TextStyle(fontFamily: 'Prompt')),
                          const SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (context, child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: child ?? Container(),
                                    );
                                  },
                                );

                                if (pickedTime != null) {
                                  // ignore: use_build_context_synchronously

                                  final formattedTime =
                                      // "${pickedTime.hour}:${pickedTime.minute}";
                                      "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";

                                  setState(() {
                                    _timeEditingController.text = formattedTime;
                                  });
                                }
                              },
                              child: IgnorePointer(
                                child: TextFormField(
                                  controller: _timeEditingController,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Prompt'),
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
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('วันที่',
                              style: TextStyle(fontFamily: 'Prompt')),
                          const SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030),
                                );

                                if (pickedDate != null) {
                                  final formattedDate = DateFormat('yyyy-MM-dd')
                                      .format(pickedDate);
                                  setState(() {
                                    _dateEditingController.text = formattedDate;
                                  });
                                }
                              },
                              child: IgnorePointer(
                                child: TextFormField(
                                  controller: _dateEditingController,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Prompt'),
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
                      const SizedBox(height: 50),
                      InkWell(
                        onTap: () {
                          editvalue();
                        },
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
                                  fontFamily: 'Prompt')),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
            }
          }),
    );
  }
}
