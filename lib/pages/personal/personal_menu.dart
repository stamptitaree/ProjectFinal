// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:mytest/widget/appbar_main.dart';
import 'package:mytest/widget/drawer_main.dart';

class PersonalMenu extends StatefulWidget {
  const PersonalMenu({super.key});

  @override
  State<PersonalMenu> createState() => _PersonalMenuState();
}

class _PersonalMenuState extends State<PersonalMenu> {
  String _uid = '';
  String _firstname = '';
  String _lastname = '';
  // String _sex = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  bool isEditing = false;

  Future<void> findUid() async {
    _auth.authStateChanges().listen((event) async {
      if (event != null) {
        setState(() {
          _uid = event.uid;
        });

        if (_uid.isNotEmpty) {
          DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
              .collection("users")
              .doc(_uid)
              .get();

          String firstname = userSnapshot.get('firstname');
          String lastname  = userSnapshot.get('lastname');
          // String sex = userSnapshot.get('sex');

          setState(() {
            _firstname = firstname;
            _lastname  = lastname;
            // _sex = sex;
          });
          // print(_firstname);
        }
      }
    });
  }

  Future<void> updateFirstNameInFirestore(String newFirstName,String newLastname) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_uid)
          .update({'firstname': newFirstName,
                   'lastname': newLastname
          });

      setState(() {
        _firstname = newFirstName;
        _lastname  = newLastname;
      });

      // แสดงข้อความแจ้งเตือนด้วย Fluttertoast
      Fluttertoast.showToast(
        msg: "บันทึกเสร็จสมบูรณ์",
        gravity: ToastGravity.BOTTOM, // ตำแหน่งของข้อความแจ้งเตือน
        backgroundColor: Colors.green, // สีพื้นหลังข้อความแจ้งเตือน
        textColor: Colors.white, // สีขอบข้อความแจ้งเตือน
      );
    } catch (error) {
      // แสดงข้อความแจ้งเตือนด้วย Fluttertoast หากเกิดข้อผิดพลาดในการบันทึก
      Fluttertoast.showToast(
        msg: "เกิดข้อผิดพลาดในการบันทึกข้อมูล",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }

    setState(() {
      isEditing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    findUid();
    firstnameController.text = _firstname;
    lastnameController.text  = _lastname;
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarMain(title: 'ข้อมูลส่วนตัว'),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blueGrey,
                          backgroundImage: NetworkImage(
                              'https://static.thairath.co.th/media/dFQROr7oWzulq5Fa5nRRVgnzYSSwUoPM7rigVHaj4QhdURLfyt90hBPNzf89n8vZ5bp.jpg'),
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: toggleEditing,
                        child: Image.asset(
                          'assets/images/edit.png',
                          width: 22,
                          height: 22,
                        ),
                      ),
                    ),

                    // isEditing // ตรวจสอบว่ากำลังแก้ไขหรือไม่
                    //     ? Container() // ถ้ากำลังแก้ไขให้แสดงว่าง
                    //     : Align(
                    //         // ถ้าไม่ใช่โหมดแก้ไขให้แสดง text
                    //         alignment: Alignment.centerRight,
                    //         child: GestureDetector(
                    //           onTap: toggleEditing,
                    //           child: Text(
                    //             'แก้ไข',
                    //             style: TextStyle(
                    //               color: Colors.blue,
                    //               decoration: TextDecoration.underline,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 8),
                child: Row(
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          // readOnly: true,
                          // enabled: false,
                          decoration: InputDecoration(
                              hintText: 'oomsinboyyyy@gmail.com',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black38))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Row(
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(fontSize: 18),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          // enabled: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black38))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: const Color.fromARGB(66, 0, 0, 0),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 8),
                child: Row(
                  children: [
                    Text(
                      'ชื่อ :',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: isEditing // ตรวจสอบว่ากำลังแก้ไขหรือไม่
                            ? TextFormField(
                                controller: firstnameController,
                                // enabled: firstnameController.text.isEmpty,
                                enabled: true,
                                decoration: InputDecoration(
                                  hintText: _firstname,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black38,
                                    ),
                                  ),
                                ),
                              )
                            : TextFormField(
                                controller:
                                    TextEditingController(text: _firstname),
                                enabled:
                                    false, // ไม่สามารถแก้ไขข้อมูลได้เมื่อไม่ได้กดแก้ไข
                                decoration: InputDecoration(
                                  hintText: _firstname,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black38,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 8),
                child: Row(
                  children: [
                    Text(
                      'นามสกุล',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        // child: isEditing // ตรวจสอบว่ากำลังแก้ไขหรือไม่
                          child:TextFormField(
                                controller: lastnameController,
                                enabled: true,
                                decoration: InputDecoration(
                                  hintText: _lastname,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black38,
                                    ),
                                  ),
                                ),
                              )
                            // : TextFormField(
                            //     controller:
                            //         TextEditingController(text: _lastname),
                            //     enabled:
                            //         false, 
                            //     decoration: InputDecoration(
                            //       hintText: _lastname,
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //         borderSide: BorderSide(
                            //           color: Colors.black38,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 8),
                child: Row(
                  children: [
                    Text(
                      'ประวัติแพ้ยา',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          // enabled: false,
                          decoration: InputDecoration(
                              hintText: '-',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black38))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 14),
                child: Row(
                  children: [
                    Text(
                      'โรคประจำตัว',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          // enabled: false,
                          decoration: InputDecoration(
                              hintText: 'ความดันโลหิต',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black38))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    final newFirstName = firstnameController.text;
                    final newLastName = lastnameController.text;
                    print(newFirstName != _firstname);
                    print(newLastName != _lastname);

                    if (((newFirstName != _firstname) == true )||(newLastName != _lastname)) {
                      updateFirstNameInFirestore(newFirstName, newLastName);
                    }

                    
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
                        )),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
      drawer: DrawerMain(),
    );
  }
}
