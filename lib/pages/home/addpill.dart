import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mytest/services/local_notification.dart';
import 'package:mytest/utils/global.colors.dart';

class Addpill extends StatefulWidget {
  const Addpill({super.key});

  @override
  State<Addpill> createState() => _AddpillState();
}

class _AddpillState extends State<Addpill> {
  final TextEditingController namepillController = TextEditingController();
  final TextEditingController rangepillController = TextEditingController();
  final TextEditingController notepillController = TextEditingController();
  final TextEditingController daypillController = TextEditingController();
  final TextEditingController pertimepillController = TextEditingController();
  late TextEditingController _dateEditingController;
  late TextEditingController _timeEditingController;

  List<String> listPeriod = <String>['เช้า', 'กลางวัน', 'เย็น', 'ก่อนนอน'];
  String? dropdownValuePeriod;

  List<String> listDay = <String>['1', '3', '5', '7'];
  String? dropdownValueDay;

  List<String> listNote = <String>['ก่อนอาหาร', 'หลังอาหาร'];
  String? dropdownValueNote;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  // final String a = 'a';
  // int notiId = 0;

  Future<void> validateValue() async {
    // print(_dateEditingController.text);
    if (namepillController.text != '' &&
        _dateEditingController.text != '' &&
        _timeEditingController.text != '') {
      _createDrug();
    } else if (namepillController.text == '' ||
        _dateEditingController.text == '' ||
        _timeEditingController.text == '') {
      Fluttertoast.showToast(
        msg: "กรุณากรอกข้อมูลทุกช่อง",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> _createDrug() async {
    try {
      // notiId = Random().nextInt(99999999);
      print(daypillController.text);
      print(_dateEditingController.text);
      var create_date = DateTime.parse(
          "${_dateEditingController.text} ${_timeEditingController.text}:00");

      // for (var i = 0; i < int.parse(daypillController.text); i++) {
      //   String id =
      //       "${create_date.month.toString().padLeft(2, '9')}${(create_date.day + i).toString().padLeft(2, '0')}${create_date.hour}${create_date.minute.toString().padLeft(2, '0')}0";
      //   var date = DateTime.parse(_dateEditingController.text)
      //       .add(Duration(days: i * 1));
      //   await FirebaseFirestore.instance
      //       .collection("drugs")
      //       .doc(_auth.currentUser?.email)
      //       .collection("add_drug")
      //       .add({
      //     'drug_name': namepillController.text,
      //     'drug_range': rangepillController.text,
      //     'drug_note': notepillController.text,
      //     'drug_day': daypillController.text,
      //     'drug_pertime': pertimepillController.text,
      //     'drug_time': _timeEditingController.text,
      //     'drug_date': DateFormat('yyyy-MM-dd').format(date),
      //     'notify_id': id,
      //   });
      // }
      print("D: $create_date");
      // LocalNotification().simpleNotificationShow(
      //     create_date, int.parse(daypillController.text));
      Fluttertoast.showToast(msg: "เพิ่มยาสำเร็จ");
    } catch (e, s) {
      print(e);
      print(s);
      Fluttertoast.showToast(
        msg: "เกิดข้อผิดพลาดในการบันทึกข้อมูล",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _dateEditingController = TextEditingController();
    _timeEditingController = TextEditingController();
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
            child: Text('เพิ่มยา', style: TextStyle(fontFamily: 'Prompt'))),
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
      body: SingleChildScrollView(
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
                  const Text('ชื่อยา', style: TextStyle(fontFamily: 'Prompt')),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: namepillController,
                      decoration: InputDecoration(
                        // labelText: "Enter Email",
                        // fillColor: Colors.white,
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
                        border: Border.all(color: GlobalColors.borderInput),
                      ),
                      child: DropdownButton<String>(
                        hint: const Text('เลือกช่วงเวลา',
                            style: TextStyle(fontFamily: 'Prompt')),
                        isExpanded: true,
                        value: dropdownValuePeriod,
                        // icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: TextStyle(
                            color: GlobalColors.textColor,
                            fontFamily: 'Prompt'),
                        underline: Container(),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValuePeriod = value!;
                          });
                          if (value != null && value.isNotEmpty) {
                            rangepillController.text = value;
                          } else {
                            rangepillController.text = '';
                          }
                        },
                        items: listPeriod
                            .map<DropdownMenuItem<String>>((String value) {
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
                        border: Border.all(color: GlobalColors.borderInput),
                      ),
                      child: DropdownButton<String>(
                        hint: const Text('เลือกหมายเหตุ',
                            style: TextStyle(fontFamily: 'Prompt')),
                        isExpanded: true,
                        value: dropdownValueNote,
                        // icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: TextStyle(
                            color: GlobalColors.textColor,
                            fontFamily: 'Prompt'),
                        underline: Container(),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValueNote = value!;
                          });
                          if (value != null && value.isNotEmpty) {
                            notepillController.text = value;
                          } else {
                            notepillController.text = '';
                          }
                        },
                        items: listNote
                            .map<DropdownMenuItem<String>>((String value) {
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
                  const Text('จำนวนวัน',
                      style: TextStyle(fontFamily: 'Prompt')),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.only(top: 3, left: 15),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: GlobalColors.borderInput),
                      ),
                      child: DropdownButton<String>(
                        hint: const Text('เลือกจำนวนวัน',
                            style: TextStyle(fontFamily: 'Prompt')),
                        isExpanded: true,
                        value: dropdownValueDay,
                        // icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: TextStyle(
                            color: GlobalColors.textColor,
                            fontFamily: 'Prompt'),
                        underline: Container(),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValueDay = value!;
                          });
                          if (value != null && value.isNotEmpty) {
                            daypillController.text = value;
                          } else {
                            daypillController.text = '';
                          }
                        },
                        items: listDay
                            .map<DropdownMenuItem<String>>((String value) {
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
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child ?? Container(),
                            );
                          },
                        );

                        if (pickedTime != null) {
                          // ignore: use_build_context_synchronously

                          final formattedTime =
                              "${pickedTime.hour}:${pickedTime.minute}";

                          setState(() {
                            _timeEditingController.text = formattedTime;
                          });
                        }
                      },
                      child: IgnorePointer(
                        child: TextFormField(
                          controller: _timeEditingController,
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
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('วันที่', style: TextStyle(fontFamily: 'Prompt')),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );

                        if (pickedDate != null) {
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
              const SizedBox(height: 50),
              InkWell(
                onTap: () {
                  validateValue();
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
              InkWell(
                onTap: () {
                  LocalNotification().pendingNotificationRequests();
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
                  child: const Text('yyyyy',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Prompt')),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
