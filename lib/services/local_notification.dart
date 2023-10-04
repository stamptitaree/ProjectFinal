import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mytest/pages/notificationpop/popup_notify.dart';
// import 'package:mytest/widget/navbar_main.dart';
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // LocalNotification().cancelNoti(id: notificationResponse.id);
  Get.to(() => Popupnotify(id: notificationResponse.id!));
}

class LocalNotification {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> pendingNotificationRequests() async {
    await notificationsPlugin
        .pendingNotificationRequests()
        .then((value) => value.forEach((element) {
              print(element.id);
            }));
  }

  Future<void> cancelNoti({int? id}) async {
    if (id == null) {
      await notificationsPlugin.cancelAll();
    } else {
      String idString = id.toString();
      print('Will remove id : $id');
      await notificationsPlugin.pendingNotificationRequests().then((value) {
        var data = value
            .where((element) => element.id
                .toString()
                .contains(idString.substring(0, idString.length - 1)))
            .toList();
        data.forEach((element) {
          print("removed : ${element.id}");
          notificationsPlugin.cancel(element.id);
        });
      });

      // Get.to(() => const BottomNavigationBarExample(selectedIndex: 1));
    }
  }

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("mipmap/launcher_icon");

    DarwinInitializationSettings initializationIos =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationIos);

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        // print(details.);
        if (details.id != null) {
          Get.to(() => Popupnotify(id: details.id!));
        }

        // cancelNoti(id: details.id);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  // Future<void> simpleNotificationShow() async {
  //   AndroidNotificationDetails androidNotificationDetails =
  //       const AndroidNotificationDetails(
  //     'Channel_id',
  //     'Channel_title',
  //     priority: Priority.high,
  //     importance: Importance.max,
  //     channelShowBadge: true,
  //   );
  //   NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await notificationsPlugin.show(
  //       0, 'Simple Notification', 'New User send message', notificationDetails);
  // }

  Future<void> simpleNotificationShow(DateTime date, int period) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'Channel_id',
      'Channel_title',
      priority: Priority.high,
      importance: Importance.max,
      channelShowBadge: true,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    // ตั้งการแจ้งเตือนเวลา
    for (var i = 0; i < period; i++) {
      for (var j = 0; j < 5; j++) {
        tz.TZDateTime scheduledTime = tz.TZDateTime.from(
            date.add(Duration(days: i * 1, minutes: j * 5)), tz.local);
        String id =
            "${scheduledTime.month.toString().padLeft(2, '9')}${scheduledTime.day.toString().padLeft(2, '0')}${date.hour}${date.minute.toString().padLeft(2, '0')}$j";
        // ignore: unused_local_variable
        final scheduledNotification = notificationsPlugin.zonedSchedule(
          int.parse(id),
          'การแจ้งเตือน',
          'ได้เวลารับประทานยาแล้ว',
          scheduledTime,
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
    }
  }
}
