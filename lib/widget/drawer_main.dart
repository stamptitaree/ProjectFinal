import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/login.view.dart';
import 'package:mytest/pages/darwer/list_drug.dart';
import 'package:mytest/widget/navbar_main.dart';

class DrawerMain extends StatefulWidget {
  const DrawerMain({super.key});

  @override
  State<DrawerMain> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  String _uid = '';
  String _firstname = '';
  String _sex = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final isLoading = StreamController<bool>();

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

          String firstname = userSnapshot.get('firstname');
          String sex = userSnapshot.get('sex');

          setState(() {
            _firstname = firstname;
            _sex = sex;
          });
        }
      }
      isLoading.add(false);
    });
  }

  @override
  void initState() {
    super.initState();
    findUid();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFEEF3F8),
        child: ListView(
          children: <Widget>[
            StreamBuilder<bool>(
                initialData: true,
                stream: isLoading.stream,
                builder: (context, snapshot) {
                  if (snapshot.data!) {
                    return Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height * 0.34,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: CircleAvatar(
                            radius: 72,
                            backgroundImage: _sex == 'ชาย'
                                ? const AssetImage('assets/images/man.png')
                                : _sex == 'หญิง'
                                    ? const AssetImage(
                                        'assets/images/woman.png')
                                    : const AssetImage(
                                        'assets/images/unknow.png'),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'My Profile',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            _firstname,
                            style: const TextStyle(
                                fontSize: 28,
                                color: Color.fromARGB(187, 99, 14, 116)),
                          ),
                        )
                      ],
                    );
                  }
                }),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: Text(
                'PROFILE',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ),
            ListTile(
              // assets/images/accountW.png
              leading: const Icon(Icons.account_balance_outlined),
              title: const Text('ข้อมูลส่วนตัว'),
              onTap: () {
                Get.offAll(
                    () => const BottomNavigationBarExample(selectedIndex: 3));
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_services_outlined),
              title: const Text('ความรู้เรื่องโรค'),
              onTap: () {
                Get.to(const ListDrug());
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout'),
              onTap: () async {
                try {
                  await _auth.signOut();
                  Get.offAll(() => LoginView());
                } catch (e) {
                  // ignore: avoid_print
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
