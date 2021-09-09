import 'package:flutter/material.dart';

class Booking_finished extends StatefulWidget {
  String startDate, endDate;
   Booking_finished({Key? key,required this.startDate, required this.endDate}) : super(key: key);

  @override
  _Booking_finishedState createState() => _Booking_finishedState();
}

class _Booking_finishedState extends State<Booking_finished> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:  Column(
            children: [
              Text(widget.startDate,style: TextStyle(fontSize: 30,color: Colors.black),),
              Text(widget.endDate,style: TextStyle(fontSize: 30,color: Colors.black),)
            ],
          ),
    );

  }
}
