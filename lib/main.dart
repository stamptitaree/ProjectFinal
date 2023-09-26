import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mytest/Splash.view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mytest/services/local_notification.dart';
// import 'package:mytest/api/firebase_api.dart';
// import 'package:mytest/notify.dart';
import 'package:mytest/widget/navbar_main.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest_all.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

void main() async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Bangkok'));
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotification().initNotification();
  await Firebase.initializeApp();

  // await FirebaseApi().initNotifications();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppNavigator(),
    );
  }
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // ถ้าผู้ใช้ล็อคอินอยู่ ให้ไปที่หน้า BottomNavigationBarExample
      return const BottomNavigationBarExample();
    } else {
      // ถ้าไม่ได้ล็อคอิน ให้ไปที่หน้า SplashView เพื่อล็อคอิน
      return const SplashView();
    }
  }
}
