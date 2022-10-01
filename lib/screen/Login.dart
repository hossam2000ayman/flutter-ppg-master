// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable, prefer_final_fields, unused_field, avoid_print, unused_import, deprecated_member_use, unnecessary_new

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_ui/Exception/EmailException.dart';
import 'package:login_ui/Exception/PasswordException.dart';
import 'package:login_ui/Exception/ServerException.dart';
import 'package:login_ui/Model/Response.dart';
import 'package:login_ui/screen/HomeScreen.dart';
import 'package:login_ui/services/HttpApi.dart';
import 'package:toast/toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore_for_file: file_names

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isVisible = false;
  bool _isLoading = false;
  bool _golbalLoding = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FlutterSecureStorage storage = FlutterSecureStorage();
  @override
  void initState() {
    // storage.deleteAll();
    //middleWare if is logged
    storage.read(key: 'logger').then((value) => {
          if (value != null)
            {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()))
            }
          else
            {
              Future.delayed(
                  const Duration(seconds: 2),
                  () => {
                        setState(() {
                          _golbalLoding = false;
                        })
                      })
            }
        });

    // TODO: implement initState
    super.initState();
    //hné idha mlogini deja yhezou lel page acceuil
  }

  @override
  Widget build(BuildContext context) {
    var _fullWidthScreen = MediaQuery.of(context).size.width;
    var _fullHeightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _golbalLoding == true
          ? Center(
              child: SpinKitPianoWave(
                color: Colors.white,
                size: 48,
              ),
            )
          : Container(
              constraints: BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/back.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'EMPLOYEE SPACE',
                            style: TextStyle(
                              color: Color(0xFF028090),
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Don\'t miss updates,\n   stay Connected!',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        "assets/employee3.png",
                        width:
                            _fullWidthScreen - ((_fullWidthScreen * 45) / 100),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width:
                            _fullWidthScreen - ((_fullWidthScreen * 20) / 100),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF028090),
                                    ),
                                  ),
                                  labelText: 'username',
                                  prefixIcon: Icon(
                                    Icons.person,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: _isVisible ? false : true,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: Color(0xFF028090),
                                        )),
                                        prefixIcon: Icon(Icons.lock),
                                        labelText: 'password',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _isVisible = !_isVisible;
                                            });
                                          },
                                          child: _isVisible
                                              ? Icon(
                                                  Icons.visibility,
                                                  color: Color(0xFF028090),
                                                )
                                              : Icon(Icons.visibility_off),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              !_isLoading
                                  ? TextButton(
                                      onPressed: () async {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        var email = _emailController.text;
                                        var password = _passwordController.text;
                                        try {
                                          Response loginVerif =
                                              await HttpApi.loginEmployee(
                                                  email, password);
                                          //if no catch

                                          Future.delayed(
                                              const Duration(seconds: 2),
                                              () async {
                                            setState(() {
                                              _isLoading = false;
                                            });

                                            await (storage.write(
                                                key: 'logger',
                                                value: loginVerif.toString()
                                                    as String));
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen()));
                                          });
                                        } on EmailException {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content:
                                                      Text("email is wrong!"),
                                                );
                                              });
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        } on PasswordException {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text(
                                                      "your password is wrong!"),
                                                );
                                              });
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        } on ServerException {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text("Server down!"),
                                                );
                                              });
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        } catch (e) {
                                          print(e);
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                        backgroundColor: Color(0xFF028090),
                                        primary: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 60,
                                          vertical: 10,
                                        ),
                                        textStyle: const TextStyle(
                                          fontSize: 21,
                                        ),
                                      ),
                                      child: Text(
                                        'LOGIN',
                                      ),
                                    )
                                  : SpinKitSpinningLines(
                                      color: Color(0xFF028090),
                                      size: 48,
                                    ),
                              //or HourGlass animation
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
