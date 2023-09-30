import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
              child: Text(
            'History',
            style: GoogleFonts.kanit(
                textStyle: TextStyle(fontSize: 34, color: HexColor('#004225'),fontWeight: FontWeight.bold)),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 2,),
                Text('Problem Name:',style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20)),),
                Text('Issued Date: ' ,style: GoogleFonts.kanit(textStyle: TextStyle()),),
                Text('Completion Date:',style: GoogleFonts.kanit(textStyle: TextStyle()),),
                Text('Department:',style: GoogleFonts.kanit(textStyle: TextStyle()),),
                Text('Status:',style: GoogleFonts.kanit(textStyle: TextStyle()),),
              ],
            ),
          ),
          Divider(height: 2,)
        ],
      ),
    );
  }
}
