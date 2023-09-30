import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MunicipalityForm extends StatefulWidget {
  const MunicipalityForm({super.key});

  @override
  State<MunicipalityForm> createState() => MunicipalityFormState();
}

class MunicipalityFormState extends State<MunicipalityForm> {
  Position? _currentPosition;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedComplaintType =
      ''; // You can set this value from the sub-dropdown.
  String? selectedPreferredModeOfResponse;
  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

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
            const SizedBox(height: 20),
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
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Water supply',
                    child: Text('Water supply'),
                  ),
                  PopupMenuItem<String>(
                    value: 'street lighting',
                    child: Text('street lighting'),
                  ),
                  PopupMenuItem<String>(
                    value: 'building code violations',
                    child: Text('building code violations'),
                  ),
                  PopupMenuItem<String>(
                    value: 'sanitation',
                    child: Text('sanitation'),
                  ),
                  PopupMenuItem<String>(
                    value: 'garbage disposal',
                    child: Text('garbage disposal'),
                  ),
                  PopupMenuItem<String>(
                    value: 'roads',
                    child: Text('roads'),
                  ),
                  PopupMenuItem<String>(
                    value: 'parks and gardens',
                    child: Text('parks and gardens'),
                  ),
                  PopupMenuItem<String>(
                    value: 'stray animals',
                    child: Text('stray animals'),
                  ),
                  PopupMenuItem<String>(
                    value: 'noise pollution',
                    child: Text('noise pollution'),
                  ),
                  PopupMenuItem<String>(
                    value: 'air pollution',
                    child: Text('air pollution'),
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
            SizedBox(height: 10),
            Text(
              'Location of Complaint',
              style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 20)),
            ),
            Text('Click to get the location'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPosition != null)
                  Text(
                    "LAT: ${_currentPosition?.latitude} \nLNG: ${_currentPosition?.longitude}",
                    style:
                        GoogleFonts.kanit(textStyle: TextStyle(fontSize: 15)),
                  ),
                IconButton(
                    iconSize: 35,
                    onPressed: () {
                      _getCurrentLocation();
                    },
                    color: HexColor('#004225'),
                    icon: Icon(Icons.location_on_outlined)),
              ],
            ),
            SizedBox(height: 15),
            Text(
              'Preferred Mode of Response',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'Phone',
                  groupValue: selectedPreferredModeOfResponse,
                  onChanged: (value) {
                    setState(() {
                      selectedPreferredModeOfResponse = value;
                    });
                  },
                ),
                Text('Phone'),
                Radio<String>(
                  value: 'Email',
                  groupValue: selectedPreferredModeOfResponse,
                  onChanged: (value) {
                    setState(() {
                      selectedPreferredModeOfResponse = value;
                    });
                  },
                ),
                Text('Email'),
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
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
