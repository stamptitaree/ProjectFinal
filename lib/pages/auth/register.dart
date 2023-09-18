import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mytest/Splash.view.dart';
import 'package:mytest/models/user_model.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:mytest/utils/text.from.global.dart';
import 'package:mytest/widget/navbar_main.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;

  final formkkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController lastController = TextEditingController();

  final TextEditingController sexController = TextEditingController();

  final TextEditingController drugallergyController = TextEditingController();
  
  final TextEditingController diseaseNcdsController = TextEditingController();

  final TextEditingController congenitalDiseaseController = TextEditingController();

  List<String> list = <String>[
    'โรคเบาหวาน',
    'โรคหลอดเลือดสมอง',
    'โรคหัวใจ',
    'โรคถุงลมโป่งพอง',
    'โรคความดันโลหิตสูง',
    'โรคไขมันในเลือดสูง',
    'โรคอ้วนลงพุง'
    'โรคไตเรื้อรัง'
  ];
  String? dropdownValue;

  List<String> listSex = <String>[
    'ชาย',
    'หญิง',
    'ไม่ระบุ',
  ];
  String? dropdownValueSex;

void sigUp(String email, String password) async {
  if (formkkey.currentState!.validate()) {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await postDetailsToFirestore(userCredential.user!);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

postDetailsToFirestore(User user) async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  
  UserModel newUser = UserModel(
    uid: user.uid,
    email: emailController.text,
    password: passwordController.text,
    firstname: nameController.text,
    lastname: lastController.text,
    sex: sexController.text,
    historydrug: drugallergyController.text,
    diseasencds: diseaseNcdsController.text,
    congenitalDisease: congenitalDiseaseController.text,
  );

  await firebaseFirestore.collection('users').doc(user.uid).set(newUser.toMap());
  Fluttertoast.showToast(msg: "Account created successfully :) ");

  Get.offAll(
  const BottomNavigationBarExample(),
  predicate: (route) {
    return route.isFirst; // ให้ปิดหน้าก่อนหน้านี้ทั้งหมด
    },
  );

}


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
          child: Form(
            key: formkkey,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("กรุณาใส่อีเมลของคุณ");
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("กรุณาใส่อีเมลของคุณให้ถูกต้อง");
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormGlobal(
                      controller: passwordController,
                      text: 'Password',
                      obscure: true,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return ("กรุณาใส่หรัสผ่านของคุณ");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("กรุณาใส่รหัสผ่านให้ถูกต้อง(Min. 6 Character)");
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormGlobal(
                      controller: nameController,
                      text: 'ชื่อ',
                      obscure: false,
                      textInputType: TextInputType.text,
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
                    const SizedBox(height: 10),
                    TextFormGlobal(
                      controller: lastController,
                      text: 'นามสกุล',
                      obscure: false,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{3,}$');
                        if (value!.isEmpty) {
                          return ("กรุณาใส่นามสกุล");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("กรุณาใส่นามสกุล ให้ถูกต้อง(Min. 3 Character)");
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 55,
                      padding: const EdgeInsets.only(top: 3, left: 15),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 7,
                          ),
                        ],
                        color: const Color(0xffEEF3F8),
                      ),
                      child: DropdownButton<String>(
                        hint: const Text('เพศ'),
                        isExpanded: true,
                        value: dropdownValueSex,
                        elevation: 16,
                        style: TextStyle(color: GlobalColors.textColor),
                        underline: Container(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValueSex = value;
                          });
                          sexController.text = value ?? '';
                          if (value != null && value.isNotEmpty) {
                            sexController.text = value;
                          } else {
                            sexController.text = ''; 
                          }
                        },
                        items:
                            listSex.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormGlobal(
                      controller: drugallergyController,
                      text: 'ประวัติการแพ้ยา',
                      obscure: false,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("กรุณาใส่ประวัติการแพ้ยา");
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 55,
                      padding: const EdgeInsets.only(top: 3, left: 15),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 7,
                          ),
                        ],
                        color: const Color(0xffEEF3F8),
                      ),
                      child: DropdownButton<String>(
                        hint: const Text('โรค NCDS'),
                        isExpanded: true,
                        value: dropdownValue,
                        // icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: TextStyle(color: GlobalColors.textColor),
                        underline: Container(),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value;
                          });
                         if (value != null && value.isNotEmpty) {
                            diseaseNcdsController.text = value;
                          } else {
                            diseaseNcdsController.text = ''; // Reset the controller if not valid
                          }
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
                      controller: congenitalDiseaseController,
                      text: 'โรคประจำตัว',
                      obscure: false,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("กรุณาใส่โรคประจำตัว");
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                     onTap: () {
                        sigUp(emailController.text, passwordController.text);
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
