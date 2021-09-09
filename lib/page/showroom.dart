import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thueoto/data.dart';
import 'package:thueoto/page/car_widget.dart';
import 'package:thueoto/constants.dart';
import 'package:http/http.dart' as http;
import 'package:thueoto/page/profile/profile.dart';
import 'package:thueoto/page/cars_rental_a_lot.dart';
import 'package:thueoto/page/total_car.dart';

import '../connect/api.dart';

class Showroom extends StatefulWidget {
  const Showroom({Key? key}) : super(key: key);

  @override
  _ShowroomState createState() => _ShowroomState();
}

class _ShowroomState extends State<Showroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.dark,
        title: Text(
          "Vận chuyển Cần Thơ",
          style: GoogleFonts.averageSans(
              fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.menu,
              color: Colors.black,
              size: 28,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Tìm xe...",
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(width: 10, style: BorderStyle.none)),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.only(left: 30),
                    suffixIcon: Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 18.0),
                        child:
                            Icon(Icons.search, size: 24, color: Colors.black))),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Xe mới nhất",
                            style: GoogleFonts.aleo(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500]),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => TotalCar(),)
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Xem tất cả",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 15),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 320,
                        margin: EdgeInsets.only(bottom: 16),
                        child: FutureBuilder(
                          future: fetchPosts(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Map post = snapshot.data[index];
                                    return PostTile(
                                        VehiclesTitle: post["VehiclesTitle"],
                                        PricePerDay: post["PricePerDay"],
                                        ModelYear: post["ModelYear"],
                                        Vimage1: post["Vimage1"],
                                        Vimage2: post["Vimage2"],
                                        Vimage3: post["Vimage3"],
                                        Vimage4: post["Vimage4"],
                                        VehiclesOverview: post["VehiclesOverview"],
                                    LicensePlate: post["LicensePlate"],
                                    Tanksize: post["Tanksize"],
                                    Tons: post["Tons"],
                                    id: post["id"],);
                                  });
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        )),
                    GestureDetector(
                      onTap:  (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CarRentalALot())
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          padding: EdgeInsets.all(24),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Phổ biến",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white)),
                                  Text(
                                    "Xe được thuê nhiều",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.green,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap:  (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CarRentalALot())
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          padding: EdgeInsets.all(24),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Báo giá",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white)),
                                  Text(
                                    "Đăng ký báo giá cho chuyến hàng",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.green,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Các đánh giá",
                              style: GoogleFonts.aleo(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500]),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  child: Text(
                                    "Xem tất cả",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 15),
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(),));
                                  },
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ]),
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
