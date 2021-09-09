import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:thueoto/connect/url.dart';
import 'package:thueoto/page/profile/user.dart';
import 'package:thueoto/page/profilebooking/profilebooking.dart';
import 'package:http/http.dart' as http;
import '../nav.dart';

class ProfileLogined extends StatefulWidget {
  const ProfileLogined({Key? key}) : super(key: key);

  @override
  _ProfileLoginedState createState() => _ProfileLoginedState();
}

class _ProfileLoginedState extends State<ProfileLogined> {
  String useremail = "1";
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if(prefs.getString("useremail") == null ){
        useremail = "1";
      } else
        useremail = prefs.getString("useremail")!;
    });
    return useremail;
  }
  Future getdataUser() async {
      var response  = await http.post(Uri.parse(url_userinfor),
          body: {"useremail": useremail});
      var data = jsonDecode(response.body);
        print(data);
      return data;
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hồ sơ",
          style: GoogleFonts.averageSans(
              fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        // brightness: Brightness.light,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 40, left: 10),
                title: Text(
                  "Trần Đạt",
                  style: TextStyle(fontSize: 30),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://s120-ava-talk.zadn.vn/f/6/4/0/144/120/2c64e04896c43a0546cb67873d753849.jpg"),
                  radius: 30,
                ),
                subtitle: Text(useremail),
                onTap: () {},
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  "Tài khoản",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  Icons.account_box_rounded,
                  size: 50,
                ),
                subtitle: Text("Quản lý tài khoản cá nhân"),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserInfor(useremail: useremail,),
                      ));
                },
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  "Đã đặt",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  Icons.car_repair,
                  size: 50,
                ),
                subtitle: Text("Quản lý xe đã đặt"),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  size: 50,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileBooking(useremail: useremail,),));
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  "Đăng xuất",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  Icons.logout,
                  size: 50,
                ),
                onTap: () async {
                  showDialog<String>(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Icon(
                              Icons.logout,
                              color: Colors.green,
                            ),
                            content: Text(
                              "Bạn muốn đăng xuất",
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString("useremail", "1");
                                  Navigator.pop(context);
                                },
                                child: const Text('Đồng ý'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                child: const Text('Hủy'),
                              ),
                            ],
                          ));
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
