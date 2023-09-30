import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../date_time_picker.dart';

class AutonomousBodyForm extends StatefulWidget {
  const AutonomousBodyForm({super.key});

  @override
  State<AutonomousBodyForm> createState() => _AutonomousBodyFormState();
}

class _AutonomousBodyFormState extends State<AutonomousBodyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedComplaintType; // Changed to nullable
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Fill the form with correct details',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Text(
              'Complainant\'s Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Contact number'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your contact number';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email address'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your email address';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Text(
              'Complaint Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

// Use PopupMenuButton for selecting complaint type
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'government service issue',
                    child: Text('government service issue'),
                  ),
                  PopupMenuItem<String>(
                    value: 'corruption',
                    child: Text(' corruption'),
                  ),
                  PopupMenuItem<String>(
                    value: 'discrimination',
                    child: Text('discrimination'),
                  ),
                  PopupMenuItem<String>(
                    value: 'others',
                    child: Text('others'),
                  ),
                    // Add your complaint types here
                ];
              },
              onSelected: (String value) {
                setState(() {
                  selectedComplaintType = value;
                });
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Type of complaint',
                ),
                child: Text(selectedComplaintType ?? ''),
              ),
            ),

            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description of complaint',
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                DateTimePicker(
                  selectedDate: _selectedDate,
                  selectedTime: _selectedTime,
                  onDateTimeSelected: (date, time) {
                    setState(() {
                      _selectedDate = date;
                      _selectedTime = time;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Additional Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Any other relevant information',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                side: MaterialStatePropertyAll(BorderSide(
                  color: HexColor('#004225'),
                )),
                backgroundColor: MaterialStatePropertyAll(
                  HexColor('#F5F5DC'),
                ),
              ),
              onPressed: () {
// Handle form submission
                if (_formKey.currentState?.validate() == true) {
// Form is valid, perform your action here
                }
              },
              child: Center(
                child: Text(
                  'SUBMIT',
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: HexColor('#004225'),
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
