import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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

  final TextEditingController drugallergy = TextEditingController();

  List<String> list = <String>['โรคเบาหวาน', 'โรคหลอดเลือดสมอง', 'โรคถุงลมโป่งพอง', 'โรคความดันโลหิตสูง','โรคไขมันในเลือดสูง','โรคไขมันในเลือดสูง','โรคไตเรื้อรัง'];
  late String dropdownValue = list.first;

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
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(255, 245, 43, 29)
            ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/moreX.png',
                  // width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'N C D s',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: GlobalColors.mainColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/moreX.png',
                  // width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(height: 50),
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
                  const SizedBox(height: 20),
                  TextFormGlobal(
                    controller: emailController,
                    text: 'Email',
                    obscure: false,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  TextFormGlobal(
                    controller: passwordController,
                    text: 'Password',
                    obscure: false,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  TextFormGlobal(
                    controller: nameController,
                    text: 'ชื่อ-นามสกุล',
                    obscure: false,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  TextFormGlobal(
                    controller: drugallergy,
                    text: 'ประวัติการแพ้ยา',
                    obscure: false,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
