import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login1.dart';



class ProfileLogin extends StatefulWidget {
  const ProfileLogin({Key? key}) : super(key: key);

  @override
  _ProfileLoginState createState() => _ProfileLoginState();
}

class _ProfileLoginState extends State<ProfileLogin> {
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
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 300)),

              FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Colors.green,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login(), ));
                },
                child: Text(
                  "Đăng nhập",
                  style: TextStyle(fontSize: 20),
                ),
              ),

            Text("Bạn cần đăng nhập để sử dụng dịch vụ!")
          ],
        ),
      ),
    );
  }
}
