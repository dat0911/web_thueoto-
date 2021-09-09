import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:thueoto/connect/url.dart';

class ProfileBooking extends StatefulWidget {
  String useremail;
  ProfileBooking({Key? key, required this.useremail}) : super(key: key);

  @override
  _ProfileBookingState createState() => _ProfileBookingState();
}

class _ProfileBookingState extends State<ProfileBooking> {
  Future getProfileBooking() async {
    var response = await http.post(Uri.parse(url_profilebooking),
        body: {"useremail": widget.useremail});
    var data = jsonDecode(response.body);
    if(data.toString() == "error"){
      print(data);
    }
    else{
      print(data);
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Thông tin xe đã đặt",
            style: GoogleFonts.averageSans(
                fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
            child: Container(
              height: 700,
              child: FutureBuilder(
          future: getProfileBooking(),
          builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context,int index){
                      Map post = snapshot.data[index];
                      return Widget_profilebooking(vehiclesTitle: post["VehiclesTitle"],
                        brandName: post["BrandName"],
                        fromDate: post["FromDate"],
                        toDate: post["ToDate"],
                        message: post["message"],
                        pricePerDay: post["PricePerDay"],
                        status: post["Status"],
                        totaldays: post["totaldays"],
                      );
                    }
                );
              }
              return Center(child: Text("Bạn chưa đặt xe nào"));
          },
        ),
            )));
  }
}

class Widget_profilebooking extends StatefulWidget {
  String vehiclesTitle;
  String brandName;
  String fromDate;
  String toDate;
  String message;
  String status;
  String pricePerDay;
  String totaldays;

  Widget_profilebooking(
      {required this.vehiclesTitle,
      required this.brandName,
      required this.fromDate,
      required this.toDate,
      required this.message,
      required this.status,
      required this.pricePerDay,
      required this.totaldays});

  @override
  _widget_profilebookingState createState() => _widget_profilebookingState();
}

class _widget_profilebookingState extends State<Widget_profilebooking> {

  @override
  Widget build(BuildContext context) {
    var moneytotal = double.parse(widget.pricePerDay);
    var totalday = double.parse(widget.totaldays);
    moneytotal = moneytotal * totalday;
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      // margin: EdgeInsets.only(right: index != null ? 16 : 0, left: index == 0 ? 16 : 0),
      margin: EdgeInsets.only(top: 16),
      width: 280,
      decoration: BoxDecoration(

        color: Colors.white60,
      ),
      child: Column(
        children: [
          Text(widget.vehiclesTitle, style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          Text(widget.brandName,style: TextStyle(fontSize: 20)),
          Divider(color: Colors.black,),
          SizedBox(height: 10,),
          Container(alignment: Alignment.topLeft,child: Text("Từ ngày: "+widget.fromDate,style: TextStyle(fontSize: 20),)),
          Container(alignment:Alignment.topLeft,child: Text("Đến ngày: "+widget.toDate,style: TextStyle(fontSize: 20))),
          Container(alignment:Alignment.topLeft,child: Text("Tổng số ngày: "+widget.totaldays,style: TextStyle(fontSize: 20))),
          Container(alignment:Alignment.topLeft,child: Text("Tổng số tiền: "+(NumberFormat.simpleCurrency(locale: 'vi').format(moneytotal)),style: TextStyle(fontSize: 20),
          ),),
          Container(child: check()),
          Container(alignment:Alignment.topLeft,child: Text("Lời nhắn: "+widget.message,style: TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
  check(){
    if(widget.status =="1"){
      return Container(alignment:Alignment.topLeft,child: Row(
        children: [
          Text("Tình trạng: ",style: TextStyle(fontSize: 20)),
          Text("Đã xác nhận ",style: TextStyle(color: Colors.green,fontSize: 20),),
        ],
      ));
    } else if(widget.status =="2"){
      return Container(alignment:Alignment.topLeft,child: Row(
        children: [
          Text("Tình trạng: ",style: TextStyle(fontSize: 20)),
          Text("Đã hủy ", style: TextStyle(color: Colors.red,fontSize: 20),),
        ],
      ));
    } else {
      return Container(alignment:Alignment.topLeft,child: Row(
        children: [
          Text("Tình trạng: ",style: TextStyle(fontSize: 20)),
          Text("Đang phê duyệt!",style: TextStyle(color: Colors.blue,fontSize: 20),),
        ],
      ));
    }
  }
}
