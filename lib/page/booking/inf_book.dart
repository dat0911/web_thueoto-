import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:thueoto/page/booking/booking_finished.dart';


class InfBook extends StatefulWidget {
  const InfBook({Key? key}) : super(key: key);

  @override
  _InfBookState createState() => _InfBookState();
}

class _InfBookState extends State<InfBook> {
  @override
  Widget build(BuildContext context) {
      DateRangePickerController _datePickerControler =DateRangePickerController();
      PickerDateRange dateTimeRange;
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('vi'),
      ],
      locale: const Locale('zh'),
      title: 'DateRangePicker Localization',
      home: Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Chọn ngày ",style: GoogleFonts.averageSans(fontSize: 28,color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
             height: 400,
            // width: 500,
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,textStyle: TextStyle(fontSize: 20,color: Colors.black)
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      backgroundColor: Color(0xff7fcd91),
                      textStyle: TextStyle(fontSize: 15, )),),
              selectionMode: DateRangePickerSelectionMode.range,
              //showActionButtons: true,
              backgroundColor: Colors.white,
              selectionColor: Colors.green,
              startRangeSelectionColor: Colors.green,
              endRangeSelectionColor: Colors.green,
              enablePastDates: false,
              //controller: _datePickerControler,
              confirmText: 'Chọn',
              cancelText: "Hủy",
              onSelectionChanged: _onSelectionChanged,
              // onSubmit: (Object val){
              //  // print(val.value.startDate);
              // // print(dateTimeRange);
              // },
              // onCancel: (){
              //   _datePickerControler.selectedRanges = null;
              // },
            ),
          ),

          Row(
            children: [
              //_onSelectionChanged();
            ],
          ),
          FlatButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Booking_finished(startDate: a, endDate: b),));
          },
              child: Text("tiep tuc"))
        ],
      )
    ),
    );

  }

  String a= "1";
  String b= "1";
  String c = "null";
  String d ="null";
  getFormatedDate(_date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {

    // args!=null && args.value is PickerDateRange? a=args.value.startDate.toString(): c;
    // args!=null && args.value is PickerDateRange? b=args.value.endDate.toString(): d;
    //
    //
    // print(getFormatedDate(args.value.startDate.toString()));
    // String _endDate = args.value.endDate.toString();
    // print(getFormatedDate(_endDate));
    // a = args.value.startDate;
    // b =args.value.endDate;
    print("args : ${args!=null && args.value is PickerDateRange? args.value.startDate : "Empty start"}");
    print("args : ${args!=null && args.value is PickerDateRange? args.value.endDate : "Empty end"}");
  }
}

