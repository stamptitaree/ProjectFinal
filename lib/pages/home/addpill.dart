import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:mytest/pages/home/select_pill.dart';
import 'package:mytest/services/local_notification.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:mytest/widget/navbar_main.dart';
import 'package:audioplayers/audioplayers.dart';

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

  List<String> listDay = <String>['1', '2', '3', '4', '5', '6', '7'];
  String? dropdownValueDay;

  List<String> listNote = <String>['ก่อนอาหาร', 'หลังอาหาร'];
  String? dropdownValueNote;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  // final String a = 'a';
  // int notiId = 0;
  final player = AudioPlayer();

  Future<void> validateValue() async {
    // print(_dateEditingController.text);
    if (namepillController.text != '' &&
        _dateEditingController.text != '' &&
        _timeEditingController.text != '' &&
        daypillController.text != '') {
      _createDrug();
    } else if (namepillController.text == '' ||
        _dateEditingController.text == '' ||
        _timeEditingController.text == '' ||
        daypillController.text != '') {
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
      // print('จำนวนวัน: ${daypillController.text}');
      print(_dateEditingController.text);
      // ignore: non_constant_identifier_names
      var create_date = DateTime.parse(
          "${_dateEditingController.text} ${_timeEditingController.text}:00");

      for (var i = 0; i < int.parse(daypillController.text); i++) {
        // ignore: unused_local_variable
        String id =
            "${create_date.month.toString().padLeft(2, '9')}${(create_date.day + i).toString().padLeft(2, '0')}${create_date.hour}${create_date.minute.toString().padLeft(2, '0')}0";
        var date = DateTime.parse(_dateEditingController.text)
            .add(Duration(days: i * 1));
        final queryDrug = await FirebaseFirestore.instance
            .collection('drug_inter')
            .doc('MilncD2OQeoS5VIUBa1W')
            .get();
        List drug_list = queryDrug['data'];

        var drug_dt = drug_list
            .where((element) => element['drug_list'] == namepillController.text)
            .toList();
        print('drug old : $drug_dt');

        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('noti')
            .doc(_auth.currentUser?.email)
            .collection("add_drug")
            .where('drug_date',
                isEqualTo: DateFormat('yyyy-MM-dd').format(date))
            .get();

        for (var doc in querySnapshot.docs) {
          // print(doc.data());

          final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          final String drugName = data['drug_name'] as String;
          var qqq = drug_dt
              .where((element) => element['drug_inter_list'] == drugName)
              .toList();

          // ignore: unnecessary_null_comparison
          if (qqq != null && qqq.isNotEmpty) {
            print('AVD ${qqq[0]['drug_list']}');
            // print('drug new : ${qqq[0]['detail']}');

            if (qqq[0]['drug_list'] == 'Cisapride' || qqq[0]['drug_inter_list'] == 'Cisapride') {
              player.play(AssetSource('sound/FurosemideCisapride.mp3'));
            }else if(qqq[0]['drug_list'] == 'Dofetilide' || qqq[0]['drug_inter_list'] == 'Dofetilide'){
              player.play(AssetSource('sound/FurosemideDofetilide.mp3'));
            }else if(qqq[0]['drug_list'] == 'Ceritinib' || qqq[0]['drug_inter_list'] == 'Ceritinib'){
              player.play(AssetSource('sound/Propranolol Ceritinib.mp3'));
            }else if(qqq[0]['drug_list'] == 'Dronedarone' || qqq[0]['drug_inter_list'] == 'Dronedarone'){
              player.play(AssetSource('sound/HCTZ (Hydrochlorothiazide) Dronedarone.mp3'));
            }else if(qqq[0]['drug_list'] == 'Amprenavir'|| qqq[0]['drug_inter_list'] == 'Amprenavir'){
              player.play(AssetSource('sound/Simvastatin  Amprenavir.mp3'));
            }else if(qqq[0]['drug_list'] == 'Benazepril'|| qqq[0]['drug_inter_list'] == 'Benazepril'){
              player.play(AssetSource('sound/Spironolactone Benazepril.mp3'));
            }else if(qqq[0]['drug_list'] == 'Apixaban'|| qqq[0]['drug_inter_list'] == 'Apixaban'){
              player.play(AssetSource('sound/Warfarin Apixaban.mp3'));
            }
            
            // ignore: use_build_context_synchronously, unused_local_variable
            bool decide = await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color(0xFFBD0648).withOpacity(0.8),
                    // title: Text("Do you want to change password?"),
                    content: SizedBox(
                      height: 400,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 20,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      player.pause();
                                    },
                                    child: Image.asset(
                                      'assets/images/sound.png',
                                      width: 24, 
                                      height: 24,
                                      color: const Color(0xFF000000)),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: IconButton(
                                    color: const Color(0xFFBD0648),
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      player.pause();
                                      Navigator.pop(context, false);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/images/Vector.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Drug Interaction',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Prompt',
                                      fontSize: 20)),
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset('assets/images/Vector.png')
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.maxFinite,
                            height: 260,
                            padding: const EdgeInsets.all(16.0),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 185, 148, 148),
                              // borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                '${qqq[0]['detail']}',
                                style: const TextStyle(
                                    fontSize: 16, fontFamily: 'Prompt'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
        }

        await FirebaseFirestore.instance
            .collection("noti")
            .doc(_auth.currentUser?.email)
            .collection("add_drug")
            .add({
          'drug_name': (namepillController.text).trim(),
          'drug_range': rangepillController.text,
          'drug_note': notepillController.text,
          'drug_day': daypillController.text,
          'drug_pertime': pertimepillController.text,
          'drug_time': _timeEditingController.text,
          'drug_date': DateFormat('yyyy-MM-dd').format(date),
          'notify_id': id,
        });
      }

      LocalNotification().simpleNotificationShow(
          create_date, int.parse(daypillController.text));
      Fluttertoast.showToast(msg: "เพิ่มยาสำเร็จ");
      Get.to(() => const BottomNavigationBarExample(selectedIndex: 1));
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
          color: Colors.transparent,
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
                      // readOnly: true,
                      // onTap: () async {
                      //   var data = await Get.to(() => Selectpills());
                      //   if (data != null) {
                      //     print(data);
                      //     namepillController.text = data;
                      //   }
                      // },
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
              //           border: Border.all(color: GlobalColors.borderInput),
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
              //             if (value != null && value.isNotEmpty) {
              //               daypillController.text = value;
              //             } else {
              //               daypillController.text = '';
              //             }
              //           },
              //           items: listDay
              //               .map<DropdownMenuItem<String>>((String value) {
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
                    child: InkWell(
                      onTap: () async {
                        final DateTimeRange? pickedDate =
                            await showDateRangePicker(
                          context: context,
                          // initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (pickedDate != null) {
                          final startDateTime = pickedDate.start;
                          final endDateTime = pickedDate.end;

                          // คำนวณจำนวนวัน
                          final daysDifference =
                              endDateTime.difference(startDateTime).inDays;

                          // คำนวณเดือนและวันที่
                          final startMonth = startDateTime.month;
                          final endMonth = endDateTime.month;

                          setState(() {
                            if (startMonth == endMonth) {
                              // อยู่ในเดือนเดียวกัน
                              daypillController.text = '$daysDifference';
                            } else {
                              // อยู่ในเดือนต่างกัน
                              daypillController.text = '$daysDifference';
                            }
                          });
                        }
                      },
                      child: IgnorePointer(
                        child: TextFormField(
                          controller: daypillController,
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
              // InkWell(
              //   onTap: () {
              //     LocalNotification().cancelNoti();
              //   },
              //   child: Container(
              //     alignment: Alignment.center,
              //     height: 55,
              //     decoration: BoxDecoration(
              //       color: GlobalColors.mainColor,
              //       borderRadius: BorderRadius.circular(6),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.1),
              //           blurRadius: 10,
              //         ),
              //       ],
              //     ),
              //     child: const Text('yyyyy',
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.w600,
              //             fontFamily: 'Prompt')),
              //   ),
              // )
            ],
          ),
        ),
      )),
    );
  }
}
