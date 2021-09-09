import 'package:flutter/material.dart';
import 'package:thueoto/connect/api.dart';
import 'car_widget.dart';
import 'showroom.dart';
class TotalCar extends StatefulWidget {
  const TotalCar({Key? key}) : super(key: key);

  @override
  _TotalCarState createState() => _TotalCarState();
}

class _TotalCarState extends State<TotalCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:  Size(100, 60),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(top: 20,left: 10),
            height: 100,
            color: Colors.grey[200],
            child: Row(
              children: [
                Container(
                    width: 45,
                    height: 45,
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
                  "Tất cả xe",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
              height: 700,
              margin: EdgeInsets.only(bottom: 16),
              child: FutureBuilder(
                future: fetchPosts(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
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
    );
  }
}
