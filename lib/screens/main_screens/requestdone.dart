import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
class RequestDone extends StatefulWidget {
  const RequestDone({super.key});

  @override
  State<RequestDone> createState() => _RequestDoneState();
}

class _RequestDoneState extends State<RequestDone> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
              child: Text(
                'Request Completed',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(fontSize: 34, color: HexColor('#004225'),fontWeight: FontWeight.bold)),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 2,),
                Text('Problem Name: Garbage Disposal',style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20)),),
                Text('Issued Date: 21-09-2023' ,style: GoogleFonts.kanit(textStyle: TextStyle()),),
                Text('Completion Date:01-10-2023',style: GoogleFonts.kanit(textStyle: TextStyle()),),
                Text('Department: MCD',style: GoogleFonts.kanit(textStyle: TextStyle()),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 2,),
                Text('Problem Name: Power Outages',style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20)),),
                Text('Issued Date: 28-09-2023' ,style: GoogleFonts.kanit(textStyle: TextStyle()),),
                Text('Completion Date:01-13-2023',style: GoogleFonts.kanit(textStyle: TextStyle()),),
                Text('Department: Electricity Board',style: GoogleFonts.kanit(textStyle: TextStyle()),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 2,),
                Text('Problem Name: Poor Network Connectivity',style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20)),),
                Text('Issued Date: 06-10-2023' ,style: GoogleFonts.kanit(textStyle: TextStyle()),),
                Text('Completion Date:12-10-2023',style: GoogleFonts.kanit(textStyle: TextStyle()),),
                Text('Department: Telecom',style: GoogleFonts.kanit(textStyle: TextStyle()),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 2,),
                Text('Problem Name: Corruption',style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20)),),
                Text('Issued Date: 11-10-2023' ,style: GoogleFonts.kanit(textStyle: TextStyle()),),
                Text('Completion Date:31-10-2023',style: GoogleFonts.kanit(textStyle: TextStyle()),),
                Text('Department: Autonomous Body',style: GoogleFonts.kanit(textStyle: TextStyle()),),
              ],
            ),
          ),Divider(height: 2,),
        ],
      ),
    );
  }
}
