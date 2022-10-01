// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_null_comparison, unused_local_variable

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_ui/Model/Response.dart';
import 'package:login_ui/components/Drawer.dart';
import 'package:login_ui/helper/responseConverter.dart';
import 'package:login_ui/screen/Login.dart';
import 'package:login_ui/services/HttpApi.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _itemsLstView = [];
  final storage = FlutterSecureStorage();
  late Response _allData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storage.read(key: 'logger').then((value) {
      if (value == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }

      setState(() {
        _allData = convertStringToResponse(value as String);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _fullWidthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('TAKS INFO'),
        elevation: 8,
        // leading: Icon(Icons.task_outlined),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        // actions: [],
      ),
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    _allData != null ? _allData.projetTitle : '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF205375),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        print('Valid taks');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            Icon(
                              Icons.task_alt_sharp,
                              size: 50,
                              color: Colors.green[300],
                            ),
                            Text(
                                _allData != null
                                    ? _allData.Tasks.where(
                                            (element) => element.status == 1)
                                        .length
                                        .toString()
                                    : '',
                                style: TextStyle(
                                  color: Color(0xFF205375),
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        print('In progress tasks');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            Icon(
                              Icons.timer,
                              size: 50,
                              color: Colors.amber,
                            ),
                            Text(
                              _allData != null
                                  ? _allData.Tasks.where(
                                          (element) => element.status == 0)
                                      .length
                                      .toString()
                                  : '',
                              style: TextStyle(
                                color: Color(0xFF205375),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //backUp area1
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: Color(0xFF205375),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'LES MEMBRES D\'EQUIPE',
                      style: TextStyle(
                        color: Color(0xFF205375),
                        fontFamily: 'Arial',
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                //backUp area instead of listView static
                SizedBox(
                  height: 85,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Image.network(
                        'https://ui-avatars.com/api/?name=Ibrahim+Boujemaa&rounded=true&color=fff&background=028090',
                      ),
                      Image.network(
                        'https://ui-avatars.com/api/?name=Ahmed+BenHamouda&rounded=true&color=fff&background=028090',
                      ),
                      Image.network(
                        'https://ui-avatars.com/api/?name=Mourad+Salmi&rounded=true&color=fff&background=028090',
                      ),
                      Image.network(
                        'https://ui-avatars.com/api/?name=Anass+Grammi&rounded=true&color=fff&background=028090',
                      ),
                      Image.network(
                        'https://ui-avatars.com/api/?name=mortadha+Zb&rounded=true&color=fff&background=028090',
                      ),
                      Image.network(
                        'https://ui-avatars.com/api/?name=Souhail+moussa&rounded=true&color=fff&background=028090',
                      ),
                      Image.network(
                        'https://ui-avatars.com/api/?name=John+Doe&rounded=true&color=fff&background=028090',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                //start new

                Container(
                  height: 300,
                  child: ListView(
                      children: _allData != null
                          ? _allData.Tasks.map((e) => InkWell(
                                onTap: () => {
                                  if (e.status == 0)
                                    {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Container(
                                                height: 140,
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "is this task done?",
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  new BorderRadius
                                                                          .circular(
                                                                      30.0),
                                                            ),
                                                            backgroundColor:
                                                                Color(
                                                                    0xFF028090),
                                                            primary:
                                                                Colors.white,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal: 60,
                                                              vertical: 10,
                                                            ),
                                                            textStyle:
                                                                const TextStyle(
                                                              fontSize: 21,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'Yes',
                                                          ),
                                                          onPressed: () {
                                                            HttpApi.validTask(
                                                                e.id,
                                                                _allData.token);
                                                            e.status = 1;
                                                            setState(() {
                                                              _allData =
                                                                  _allData;
                                                            });
                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop();
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          })
                                    }
                                },
                                child: ListTile(
                                  leading: Icon(
                                    Icons.task_outlined,
                                    color: Color(0xFF028090),
                                  ),
                                  title: Text(e.title),
                                  subtitle: Text(e.description.substring(1,
                                          (e.description.length / 4).toInt()) +
                                      " ..."),
                                  trailing: Icon(
                                    e.status == 1
                                        ? Icons.verified
                                        : Icons.crop_square,
                                    color: Color(0xFF028090),
                                  ),
                                ),
                              )).toList()
                          : [Container()]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  //backUp Area 1
                    // InkWell(
                    //   onTap: () {
                    //     print('you typed the valid tasks');
                    //   },
                    //   child: Column(
                    //     children: [
                    //       Icon(
                    //         Icons.timer,
                    //         size: 50,
                    //         color: Colors.amber,
                    //       ),
                    //       Text(
                    //         '15',
                    //         style: TextStyle(
                    //           color: Color(0xFF028090),
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
    //backUp area instead of listView static
                    // SizedBox(
                    //   height: 100,
                    //   child: ListView.separated(
                    //     itemBuilder: (context, i) => _itemsLstView.elementAt(i),
                    //     separatorBuilder: (context, index) => SizedBox(
                    //       width: 0,
                    //     ),
                    //     itemCount: _itemsLstView.length,
                    //     scrollDirection: Axis.horizontal,
                    //   ),
                    // )