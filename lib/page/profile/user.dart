import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:thueoto/connect/url.dart';
import 'package:async/async.dart';

class UserInfor extends StatefulWidget {
  String useremail;
   UserInfor({Key? key, required this.useremail}) : super(key: key);

  @override
  _UserInforState createState() => _UserInforState();
}
class _UserInforState extends State<UserInfor> {
  AsyncMemoizer _asyncMemoizer = AsyncMemoizer();
  Future getdataUser() async {

  return  _asyncMemoizer.runOnce(() async{
      var response  = await http.post(Uri.parse(url_userinfor),
          body: {"useremail": widget.useremail});
      var data = jsonDecode(response.body);
    //  print(data);
      return data;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          "Thông tin tài khoản",
          style: GoogleFonts.averageSans(
              fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(

                height: 400,
                child: FutureBuilder(
                  future: getdataUser(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map wppost = snapshot.data[index];
                            return Container(
                              height: 400,
                              child: Card(
                                // shape: RoundedRectangleBorder(
                                // borderRadius: BorderRadius.circular(10.0),
                                // ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Padding(padding: EdgeInsets.only(left: 10)),
                                          Text("Họ tên: "),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(wppost["FullName"]),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Padding(padding: EdgeInsets.only(left: 10)),
                                          Text("Email: "),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(widget.useremail),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Padding(padding: EdgeInsets.only(left: 10)),
                                          Text("Số điện thoại: "),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(wppost["ContactNo"]),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Padding(padding: EdgeInsets.only(left: 10)),
                                          Text("Ngày sinh: "),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(wppost["dob"]),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Padding(padding: EdgeInsets.only(left: 10)),
                                          Text("Thành phố: "),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(wppost["City"]),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Padding(padding: EdgeInsets.only(left: 10)),
                                          Text("Quốc gia: "),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(wppost["Country"]),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(color: Colors.black),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Padding(padding: EdgeInsets.only(left: 10)),
                                          Text("Địa chỉ: "),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(wppost["Address"]),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          });
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),),
            SizedBox(
              height: 20,
            ),
            FlatButton(
                color: Colors.green,
                child: Text("Cập nhật thông tin"),
                onPressed: () {

                }),
          ],
        ),
      ),
    );
  }
}
