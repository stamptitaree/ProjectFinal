import 'package:flutter/material.dart';
import 'package:mytest/services/local_notification.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  // final TextEditingController _title = TextEditingController();
  // final TextEditingController _desc = TextEditingController();

  // final TextEditingController _date = TextEditingController();
  // final TextEditingController _time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TextField(
              //   controller: _title,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16.0),
              //     ),
              //     label: Text("Notification Title"),
              //   ),
              // ),
              // const SizedBox(height: 16),
              // TextField(
              //   controller: _desc,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16.0),
              //     ),
              //     label: Text("Notification Description"),
              //   ),
              // ),
              // const SizedBox(height: 16),
              // TextField(
              //   controller: _date,
              //   decoration: InputDecoration(
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(12.0),
              //       ),
              //       suffixIcon: InkWell(
              //         child: Icon(Icons.date_range),
              //         onTap: () async {
              //           final DateTime? newlySelectedDate =
              //               await showDatePicker(
              //             context: context,
              //             initialDate: dateTime,
              //             firstDate: DateTime.now(),
              //             lastDate: DateTime(2095),
              //           );

              //           if (newlySelectedDate == null) {
              //             return;
              //           }

              //           setState(() {
              //             dateTime = newlySelectedDate;
              //             // _date.text =
              //             //     "${dateTime.year}/${dateTime.month}/${dateTime.day}";
              //           });
              //         },
              //       ),
              //       label: Text("Date")),
              // ),
              // const SizedBox(
              //   height: 16.0,
              // ),
              // TextField(
              //   controller: _time,
              //   decoration: InputDecoration(
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(12.0),
              //       ),
              //       suffixIcon: InkWell(
              //         child: const Icon(
              //           Icons.timer_outlined,
              //         ),
              //         onTap: () async {
              //           final TimeOfDay? slectedTime = await showTimePicker(
              //               context: context, initialTime: TimeOfDay.now());

              //           if (slectedTime == null) {
              //             return;
              //           }

              //           _time.text =
              //               "${slectedTime.hour}:${slectedTime.minute}:${slectedTime.period.toString()}";

              //           DateTime newDT = DateTime(
              //             dateTime.year,
              //             dateTime.month,
              //             dateTime.day,
              //             slectedTime.hour,
              //             slectedTime.minute,
              //           );
              //           setState(() {
              //             dateTime = newDT;
              //           });
              //         },
              //       ),
              //       label: Text("Time")),
              // ),
              // const SizedBox(
              //   height: 24.0,
              // ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55),
                  ),
                  onPressed: () => LocalNotification().simpleNotificationShow(
                      DateTime.now().add(Duration(seconds: 10)), 3),
                  child: Text("Show Notification")),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55),
                  ),
                  onPressed: () =>
                      LocalNotification().pendingNotificationRequests(),
                  child: Text("getActive Noti")),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55),
                  ),
                  onPressed: () => LocalNotification().cancelNoti(),
                  child: Text("Cancel All Noti")),
            ],
          ),
        ),
      ),
    );
  }
}
