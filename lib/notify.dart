import 'package:flutter/material.dart';
import 'package:mytest/services/local_notification.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('asd'),
      ),
      body: Center(
          child: SizedBox(
        width: 180,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            LocalNotification().simpleNotificationShow();
          },
          child: const Text(
            'Send',
            style: TextStyle(fontSize: 18),
          ),
        ),
      )),
    );
  }
}
