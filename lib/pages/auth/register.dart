import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mytest/Splash.view.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:mytest/utils/text.from.global.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController lastController = TextEditingController();

  final TextEditingController drugallergy = TextEditingController();

  List<String> list = <String>[
    'โรคเบาหวาน',
    'โรคหลอดเลือดสมอง',
    'โรคถุงลมโป่งพอง',
    'โรคความดันโลหิตสูง',
    'โรคไขมันในเลือดสูง',
    'โรคไตเรื้อรัง'
  ];
  String? dropdownValue ;

  List<String> listSex = <String>[
    'ชาย',
    'หญิง',
    'ไม่ระบุ',
  ];
  String? dropdownValueSex;


  // @override
  // void initState() {
  //   super.initState();
  //   dropdownValue = list.first;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color.fromARGB(255, 245, 43, 29)),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Applogo(color: GlobalColors.mainColor),
              // const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Create your Account',
                    style: TextStyle(
                      color: GlobalColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormGlobal(
                    controller: emailController,
                    text: 'Email',
                    obscure: false,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  TextFormGlobal(
                    controller: passwordController,
                    text: 'Password',
                    obscure: false,
                    textInputType: TextInputType.text,
                  ),
                  
                  const SizedBox(height: 10),
                  TextFormGlobal(
                    controller: nameController,
                    text: 'ชื่อ',
                    obscure: false,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  TextFormGlobal(
                    controller: lastController,
                    text: 'นามสกุล',
                    obscure: false,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 55,
                    padding: const EdgeInsets.only(top: 3, left: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 7,
                        ),
                      ],
                      color: Color(0xffEEF3F8),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValueSex ?? listSex.first,
                      // icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style:  TextStyle(color: GlobalColors.textColor),
                      underline: Container(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValueSex = value!;
                        });
                        // print(value);
                      },
                      items: listSex.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height:10),
                  TextFormGlobal(
                    controller: drugallergy,
                    text: 'ประวัติการแพ้ยา',
                    obscure: true,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 55,
                    padding: const EdgeInsets.only(top: 3, left: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 7,
                        ),
                      ],
                      color: Color(0xffEEF3F8),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue ?? list.first,
                      // icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style:  TextStyle(color: GlobalColors.textColor),
                      underline: Container(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                        // print(value);
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormGlobal(
                    controller: drugallergy,
                    text: 'ประวัติการแพ้ยา',
                    obscure: false,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  InkWell(
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
                      child: const Text('ยืนยันการสมัคร',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}

// class DropdownButtonExample extends StatefulWidget {
//   const DropdownButtonExample({super.key});

//   @override
//   State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
// }

// class _DropdownButtonExampleState extends State<DropdownButtonExample> {
//   List<String> list = <String>['One', 'Two', 'Three', 'Four'];
//   late String dropdownValue;

//   @override
//   void initState() {
//     super.initState();
//     dropdownValue = list.first;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//     DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 16,
//       style: const TextStyle(color: Colors.deepPurple),
//       underline: Container(
//         height: 2,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       items: list.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
