import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:thueoto/connect/url.dart';
import 'package:thueoto/data.dart';
import 'package:thueoto/page/showroom.dart';
import 'package:thueoto/constants.dart';

import 'package:thueoto/page/book_car.dart';


class PostTile extends StatefulWidget {
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
  PostTile({required this.id,required this.VehiclesTitle, required this.PricePerDay, required this.ModelYear,
    required this.Vimage1,required this.Vimage2, required this.Vimage3, required this.Vimage4,required this.VehiclesOverview,
    required this.LicensePlate, required this.Tanksize, required this.Tons});
  @override

  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {

  @override
  Widget build(BuildContext context) {
    var money = double.parse(widget.PricePerDay);
    return GestureDetector(
      onTap:  (){
        List<String> _image =  [
          url_image+widget.Vimage1,
          url_image+widget.Vimage2,
          url_image+widget.Vimage3,
          url_image+widget.Vimage4,
        ];
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BookCar(Vimage1: widget.Vimage1,Tons: widget.Tons,ModelYear: widget.ModelYear,PricePerDay: widget.PricePerDay,
          VehiclesTitle: widget.VehiclesTitle,Vimage2: widget.Vimage2,Vimage3:  widget.Vimage3,Vimage4: widget.Vimage4,VehiclesOverview: widget.VehiclesOverview,image: _image,
            Tanksize: widget.Tanksize,id: widget.id,LicensePlate: widget.LicensePlate,))

        );

      },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: EdgeInsets.all(16),
          // margin: EdgeInsets.only(right: index != null ? 16 : 0, left: index == 0 ? 16 : 0),
          margin: EdgeInsets.all(16),
          width: 280,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  child: Center(
                    child: Center(
                        child: Image.network(url_image+ widget.Vimage1,
                          fit: BoxFit.fitWidth,
                        ),
                    ),
                  ),
                ),

                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.only(left: 15, right:15),
                  child: Text(
                    widget.VehiclesTitle,
                    style: GoogleFonts.aclonica(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    NumberFormat.simpleCurrency(locale: "vi").format(money) +"/10km đầu",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.only(left: 15, ),

                  child: Row(
                    children: [
                     Icon(Icons.car_repair,size: 21,),
                      SizedBox(width: 5,),
                     Text(widget.Tons +" Tấn", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ],
                  )
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Row(
                    children: [
                      Icon(Icons.zoom_out_map,size: 21),
                      SizedBox(width: 5,),
                     Text(widget.Tanksize + " (m)", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                      ],
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}

