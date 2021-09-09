import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thueoto/connect/url.dart';
import 'package:thueoto/page/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'nav.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  StreamController userinfor = StreamController();


  Future api_login() async {
    var response = await http.post(Uri.parse(url_login),
        body: {"email": email.text, "password": password.text});
   var data = jsonDecode(response.body);
    print(data.toString());
    if (data == "Error") {
      print(data.toString());
      Fluttertoast.showToast(
          msg: "Thông tin sai",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          timeInSecForIosWeb: 1);
    } else {
      String emailuser = email.text;
      print(data.toString());
      Fluttertoast.showToast(
          msg: "Thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          timeInSecForIosWeb: 1);
      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Nav(),
          ));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("useremail","$emailuser");


    }
    //print('value: ${response.body}');
    // return _controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 50)),
                Container(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Đăng nhập',
                      style: GoogleFonts.averageSans(
                          fontSize: 50, color: Colors.white),
                    ),
                  ),
                ),
                Image.asset("assets/images/favicon.png"),
                SizedBox(
                  height: 70,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                        Colors.grey[600]!.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: TextFormField(
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20),
                                          border: InputBorder.none,
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          hintText: "Email",
                                          hintStyle:
                                          TextStyle(color: Colors.white),
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Icon(
                                              Icons.email,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        controller: email,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Vui lòng nhập email";
                                          }
                                          if (!RegExp(
                                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                              .hasMatch(value)) {
                                            return 'Email không hợp lệ';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                        Colors.grey[600]!.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: TextFormField(
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20),
                                          border: InputBorder.none,
                                          focusedErrorBorder:
                                          OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          hintText: "Mật khẩu",
                                          hintStyle:
                                          TextStyle(color: Colors.white),
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Icon(
                                              Icons.work_outline_outlined,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        obscureText: true,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Vui lòng nhập email";
                                          }
                                        },
                                        controller: password,
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: FlatButton(
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                //   return ;
                                // } else{}
                                api_login();
                                print(email.text);
                                print(password.text);
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  "Đăng nhập",
                                  //  style: kBodyText,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.white, width: 1),
                                )),
                            child: Text(
                              'Tạo tài khoản',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [Colors.black, Colors.black12],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                url_imageloginbackground),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
