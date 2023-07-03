import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:intl/intl.dart';
import 'package:mytest/utils/global.colors.dart';

class Addpill extends StatefulWidget {
  const Addpill({super.key});

  @override
  State<Addpill> createState() => _AddpillState();
}

class _AddpillState extends State<Addpill> {
  final TextEditingController namepillController = TextEditingController();

  List<String> listPeriod = <String>['เช้า', 'กลางวัน', 'เย็น', 'ก่อนนอน'];
  String? dropdownValuePeriod;

  List<String> listNote = <String>['ก่อนอาหาร', 'หลังอาหาร'];
  String? dropdownValueNote;

  late TextEditingController _textEditingController;
  late TextEditingController _timeEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _timeEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _timeEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: const Center(child: Text('เพิ่มยา')),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('ชื่อยา'),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
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
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('ช่วงเวลา'),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.only(top: 3, left: 15),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: GlobalColors.borderInput),
                    ),
                    child: DropdownButton<String>(
                      hint: const Text('เลือกช่วงเวลา'),
                      isExpanded: true,
                      value: dropdownValuePeriod,
                      // icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: TextStyle(color: GlobalColors.textColor),
                      underline: Container(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValuePeriod = value!;
                        });
                        // print(value);
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
                const Text('หมายเหตุ'),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.only(top: 3, left: 15),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: GlobalColors.borderInput),
                    ),
                    child: DropdownButton<String>(
                      hint: const Text('เลือกหมายเหตุ'),
                      isExpanded: true,
                      value: dropdownValueNote,
                      // icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: TextStyle(color: GlobalColors.textColor),
                      underline: Container(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValueNote = value!;
                        });
                        // print(value);
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
                const Text('จำนวนยาที่ได้รับต่อครั้ง'),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
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
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('เวลารับประทานยา'),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        final formattedTime = pickedTime.format(context);
                        setState(() {
                          _timeEditingController.text = formattedTime;
                        });
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: _timeEditingController,
                        style: TextStyle(color: Colors.black),
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
                const Text('วันที่'),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2030),
                      );

                      if (pickedDate != null) {
                        final formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          _textEditingController.text = formattedDate;
                        });
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: _textEditingController,
                        style: TextStyle(color: Colors.black),
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
            )
          ],
        ),
      )),
    );
  }
}
