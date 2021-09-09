import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thueoto/connect/api.dart';
import 'package:thueoto/page/book_car.dart';

import 'car_widget.dart';

class CarRentalALot extends StatefulWidget {
  const CarRentalALot({Key? key}) : super(key: key);

  @override
  _CarRentalALotState createState() => _CarRentalALotState();
}

class _CarRentalALotState extends State<CarRentalALot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.black,
                                size: 28,
                              )),
                          SizedBox(width: 16),
                          Text(
                            "Xe phổ biến",
                            style: GoogleFonts.averageSans(
                                fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                        height: 700,
                        margin: EdgeInsets.only(bottom: 16),
                        child: FutureBuilder(
                          future: fetchPosts(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: 3,
                                  itemBuilder: (BuildContext context, int index) {
                                    Map post = snapshot.data[index];
                                    return
                                       GestureDetector(
                                         child:  PostTile(
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
                                           id: post["id"],),
                                       );
                                  });
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 60,
      //   decoration: BoxDecoration(
      //     color: Colors.green,
      //   ),
      //   // child: Row(
      //   //   children: [
      //   //     buildFilterIcon(),
      //   //     Row(
      //   //       children: buildFilters(),
      //   //     ),
      //   //   ],
      //   // ),
      // ),
    );
  }
}
