
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thueoto/page/profile/profile_login.dart';
import 'package:thueoto/page/profile/profile_logined.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String useremail ="1";
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
  @override
  void initState(){
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data.toString() == "1" )
              return ProfileLogin();
            else
              return ProfileLogined();
          }else
            return Center(child: CircularProgressIndicator());

        },);
  }
}


