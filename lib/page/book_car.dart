import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thueoto/connect/url.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:thueoto/page/show_fullmages.dart';
import 'booking/inf_book.dart';
import 'package:thueoto/page/booking/map.dart';

import 'login1.dart';

class BookCar extends StatefulWidget {
  final String id,
      VehiclesTitle,
      VehiclesOverview,
      PricePerDay,
      ModelYear,
      Tons,
      Vimage1,
      Vimage2,
      Vimage3,
      Vimage4,
      Tanksize,
      LicensePlate;
  List<String> image;
  //ignore: non_constant_identifier_names
  BookCar(
      {required this.id,required this.VehiclesTitle, required this.PricePerDay, required this.ModelYear,
        required this.Vimage1,required this.Vimage2, required this.Vimage3, required this.Vimage4,required this.VehiclesOverview,
        required this.LicensePlate, required this.Tanksize, required this.Tons, required this.image});

  @override
  _BookCarState createState() => _BookCarState();
}

class _BookCarState extends State<BookCar> {
  Widget postContent(htmlContent) {
    return Html(
        data: htmlContent,
       //defaultTextStyle: TextStyle(color: Colors.black, fontSize: 15)
        );
  }

  int _currentImage = 0;

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (var i = 0; i < widget.image.length; i++) {
      list.add(buildIndicator(i == _currentImage));
    }
    return list;
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey[400],
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
  String useremail = "1";
  @override
  void initState(){
    getData();
  }
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      useremail = prefs.getString("useremail")!;
    });
  }


  @override
  Widget build(BuildContext context) {
    var moneytotal = double.parse(widget.PricePerDay);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.VehiclesTitle,style: GoogleFonts.averageSans(
            fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        // elevation: 0,
        // brightness: Brightness.light,
        actions: [],
        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //show image
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowFullImage(
                                image: widget.image,
                                currentImage: _currentImage,
                              ),
                            ));
                      },
                      child: Container(
                        height: 280,
                        child: PageView(
                          physics: BouncingScrollPhysics(),
                          onPageChanged: (int page) {
                            setState(() {
                              _currentImage = page;
                            });
                          },
                          children: widget.image.map((path) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Image.network(
                                path,
                                fit: BoxFit.scaleDown,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    widget.image.length > 1
                        ? Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buildPageIndicator(),
                      ),
                    )
                        : Container(),
                    //tên xe
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        widget.VehiclesTitle,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //giá
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        NumberFormat.simpleCurrency(locale: 'vi').format(moneytotal) + " /10km đầu",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //show infor car
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            padding: EdgeInsets.only(top: 16),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.car_repair),
                                Text(
                                  widget.Tons,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text(
                                  "Trọng tải(tấn)",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            padding: EdgeInsets.only(top: 16),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.zoom_out_map),
                                Text(
                                  widget.Tanksize,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text(
                                  "Size thùng(m)",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            padding: EdgeInsets.only(top: 16),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.view_module_outlined),
                                Text(
                                  widget.LicensePlate,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text(
                                  "Biển số",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    //show thonngo tin xe
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.only(top: 16, left: 16, right: 16),
                            child: Text(
                              "THÔNG TIN XE",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: postContent(widget.VehiclesOverview),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.only(right: 16, left: 16),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Giá thuê:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      NumberFormat.simpleCurrency(locale: 'vi').format(moneytotal) + "/10km đầu",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                if ( useremail != "1") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapView()));

                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Đặt ngay",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
