// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:mytest/widget/appbar_main.dart';
import 'package:mytest/widget/drawer_main.dart';

class PersonalMenu extends StatefulWidget {
  const PersonalMenu({super.key});

  @override
  State<PersonalMenu> createState() => _PersonalMenuState();
}

class _PersonalMenuState extends State<PersonalMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarMain(),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueGrey,
                // backgroundImage: NetworkImage(
                //     'https://static.thairath.co.th/media/dFQROr7oWzulq5Fa5nRRVgnzYSSwUoPM7rigVHaj4QhdURLfyt90hBPNzf89n8vZ5bp.jpg'),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(10),
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
                padding: EdgeInsets.all(10),
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
                          enabled: false,
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
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      'ชื่อ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              hintText: 'สุดหล่อ',
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
                padding: EdgeInsets.all(10),
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
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              hintText: 'สมมุติ',
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
                padding: EdgeInsets.all(10),
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
                          enabled: false,
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
                padding: EdgeInsets.all(10),
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
                          enabled: false,
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
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {},
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
      drawer: const DrawerMain(),
    );
  }
}
