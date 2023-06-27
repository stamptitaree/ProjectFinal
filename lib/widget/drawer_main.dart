import 'package:flutter/material.dart';

class DrawerMain extends StatefulWidget {
  const DrawerMain({super.key});

  @override
  State<DrawerMain> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        // padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        children: <Widget>[
          // const DrawerHeader(
          //   child: Text('flutterassets.com'),
          //   decoration: BoxDecoration(
          //     // color: Color(0xFFEEF3F8),
          //   ),
          // ),
          Container(
            color: Colors.green,
            child: const Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: CircleAvatar(
                    radius: 72,
                    backgroundImage: NetworkImage(
                        'https://static.thairath.co.th/media/dFQROr7oWzulq5Fa5nRRVgnzYSSwUoPM7rigVHaj4QhdURLfyt90hBPNzf89n8vZ5bp.jpg'),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'My Profile',
                  style: TextStyle(fontSize: 16, color: Colors.amber),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  child: Text(
                    'Anna',
                    style: TextStyle(fontSize: 28, color: Colors.purple),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Text(
              'Profile',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_outlined),
            title: const Text('ข้อมูลส่วนตัว'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.medical_services_outlined),
            title: const Text('ความรู้เรื่องยา'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          // const SizedBox(
          //   height: 80,
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text('Logout'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
