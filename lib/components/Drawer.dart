// ignore_for_file: file_names, unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_ui/screen/Login.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 100,
            child: DrawerHeader(
              child: ListTile(
                leading: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
                title: Text(
                  'Ahmed Ben Hamouda',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: '',
                  ),
                ),
                subtitle: Text('Developpeur web'),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: const Text(
              'Done Tasks',
              style: TextStyle(color: Colors.white, fontFamily: 'arial'),
            ),
            subtitle: Text(
              '12',
              style: TextStyle(color: Colors.white, fontFamily: 'arial'),
            ),
            leading: Icon(
              Icons.task_alt,
              color: Colors.white,
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text(
              'In Progress Tasks',
              style: TextStyle(color: Colors.white, fontFamily: 'arial'),
            ),
            subtitle: Text(
              '20',
              style: TextStyle(color: Colors.white, fontFamily: 'arial'),
            ),
            leading: Icon(
              Icons.timelapse_outlined,
              color: Colors.white,
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text(
              'My tasks',
              style: TextStyle(color: Colors.white, fontFamily: 'arial'),
            ),
            subtitle: Text(
              '20',
              style: TextStyle(color: Colors.white, fontFamily: 'arial'),
            ),
            leading: Icon(
              Icons.task,
              color: Colors.white,
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          SizedBox(
            height: 35,
          ),
          ListTile(
            onTap: () {
              FlutterSecureStorage().deleteAll();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontFamily: 'arial'),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            // trailing: Icon(
            //   Icons.logout,
            //   color: Colors.white,
            // ),
          ),
        ],
      ),
    );
  }
}
