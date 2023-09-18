// ignore_for_file: prefer_const_constructors

import 'dart:async';
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
  bool obSecurePassword = true;
  bool isEditing = false;
  late String password;
  final isLoading = StreamController<bool>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController historydrugController = TextEditingController();
  final TextEditingController diseaseNcdsController = TextEditingController();
  final TextEditingController congenitalDiseaseController =
      TextEditingController();

  Future<void> findUid() async {
    isLoading.add(true);
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
          emailController.text = userSnapshot.get('email');

          password = userSnapshot.get('password');
          passwordController.text = password;

          firstnameController.text = userSnapshot.get('firstname');

          lastnameController.text = userSnapshot.get('lastname');

          sexController.text = userSnapshot.get('sex');

          historydrugController.text = userSnapshot.get('historydrug');

          diseaseNcdsController.text = userSnapshot.get('diseasencds');

          congenitalDiseaseController.text = userSnapshot.get('congenitaldisease') ;

          isLoading.add(false);
        }
      }
    });
  }

  Future<void> updateFirstNameInFirestore() async {
    try {
      if (password != passwordController.text) {
        // to do Auth dat
        bool decide = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Do you want to change password?"),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text('Confirm')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text('Cancel')),
                  ],
                ),
              );
            });
        if (decide) {
          await _auth.currentUser!.updatePassword(passwordController.text);
        } else {
          passwordController.text = password;
        }
      }
      await FirebaseFirestore.instance.collection("users").doc(_uid).update({
        'firstname' :  firstnameController.text,
        'lastname'  :  lastnameController.text,
        'password'  :  passwordController.text,
        'sex'       :  sexController.text,
        'historydrug': historydrugController.text,
        'diseasencds': diseaseNcdsController.text,
        'congenitaldisease': congenitalDiseaseController.text,
      });

      Fluttertoast.showToast(
        msg: "บันทึกเสร็จสมบูรณ์",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      await findUid();
    } catch (error) {
      Fluttertoast.showToast(
        msg: "เกิดข้อผิดพลาดในการบันทึกข้อมูล",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }

    setState(() {
      isEditing = false;
      obSecurePassword = true;
    });
  }

  @override
  void initState() {
    super.initState();
    findUid();
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
      body: StreamBuilder<bool>(
          initialData: true,
          stream: isLoading.stream,
          builder: (context, snapshot) {
            if (snapshot.data!) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: SafeArea(
                    child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //----------------------- Image and Toggle -----------------------
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: sexController.text == 'ชาย'
                                      ? const AssetImage(
                                          'assets/images/man.png')
                                      : sexController.text == 'หญิง'
                                          ? const AssetImage(
                                              'assets/images/woman.png')
                                          : const AssetImage(
                                              'assets/images/unknow.png'),
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
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      //----------------------- Email -----------------------
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 8),
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
                                  readOnly: true,
                                  enabled: false,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.black38))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //----------------------- Password -----------------------
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 5),
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
                                  enabled: isEditing,
                                  controller: passwordController,
                                  obscureText: obSecurePassword,
                                  decoration: InputDecoration(
                                      suffixIcon: obSecurePassword
                                          ? IconButton(
                                              icon: Icon(Icons.visibility_off),
                                              onPressed: () {
                                                setState(() {
                                                  obSecurePassword =
                                                      !obSecurePassword;
                                                });
                                              },
                                            )
                                          : IconButton(
                                              icon: Icon(Icons.visibility),
                                              onPressed: () {
                                                setState(() {
                                                  obSecurePassword =
                                                      !obSecurePassword;
                                                });
                                              },
                                            ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.black38))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: const Color.fromARGB(66, 0, 0, 0),
                      ),
                      //----------------------- FirstName -----------------------
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              'ชื่อ :',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    controller: firstnameController,
                                    enabled: isEditing,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      //----------------------- LastName -----------------------
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              'นามสกุล',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    controller: lastnameController,
                                    enabled: isEditing,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      //----------------------- Sex -----------------------
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              'เพศ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    controller: sexController,
                                    enabled: isEditing,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      //----------------------- Historydrug -----------------------
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              'ประวัติแพ้ยา',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  controller: historydrugController,
                                  enabled: isEditing,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.black38))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //----------------------- NCDS -----------------------
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              'โรค NCDS',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  controller: diseaseNcdsController,
                                  enabled: isEditing,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.black38))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //----------------------- Congenitaldisease -----------------------
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 14),
                        child: Row(
                          children: [
                            Text(
                              'โรคประจำตัว',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  controller: congenitalDiseaseController,
                                  enabled: isEditing,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.black38))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //----------------------- Button -----------------------
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: InkWell(
                          onTap: isEditing
                              ? () {
                                  updateFirstNameInFirestore();
                                }
                              : null,
                          child: Container(
                            alignment: Alignment.center,
                            height: 55,
                            decoration: BoxDecoration(
                              color: isEditing
                                  ? GlobalColors.mainColor
                                  : Colors.grey,
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
                      ),
                    ],
                  ),
                )),
              );
            }
          }),
      drawer: DrawerMain(),
    );
  }
}
