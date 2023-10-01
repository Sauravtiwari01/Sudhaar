import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import '../camera.dart';
import '../date_time_picker.dart';

class PoliceForm extends StatefulWidget {
  const PoliceForm({Key? key}) : super(key: key);

  @override
  State<PoliceForm> createState() => _PoliceFormState();
}

class _PoliceFormState extends State<PoliceForm> {
  Position? _currentPosition;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedComplaintType =
      ''; // You can set this value from the sub-dropdown.

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
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
  File? _selectedImage;
  TextEditingController _evidenceController = TextEditingController();

  // Function to open the bottom sheet for image selection
  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a Picture'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Pick from Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _evidenceController.text = pickedImage.name;
      });
    }
  }

  // Function to remove the selected image
  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _evidenceController.clear();
    });
  }

  @override
  void dispose() {
    _evidenceController.dispose();
    super.dispose();
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
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Complainant\'s Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Contact number'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your contact number';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email address'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Complaint Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'theft',
                    child: Text('theft'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'robbery',
                    child: Text('robbery'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'harassment',
                    child: Text('harassment'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'assault',
                    child: Text('assault'),
                  ),
                  const PopupMenuItem<String>(
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
                decoration: const InputDecoration(
                  labelText: 'Type of complaint',
                ),
                child: Text(selectedComplaintType ?? ''),
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description of complaint',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Location of Complaint',
              style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: 20)),
            ),
            const Text('Click to get the location'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPosition != null)
                  Text(
                    "LAT: ${_currentPosition?.latitude} \nLNG: ${_currentPosition?.longitude}",
                    style:
                    GoogleFonts.kanit(textStyle: const TextStyle(fontSize: 15)),
                  ),
                IconButton(
                    iconSize: 35,
                    onPressed: () {
                      _getCurrentLocation();
                    },
                    color: HexColor('#004225'),
                    icon: const Icon(Icons.location_on_outlined)),
              ],
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
            TextFormField(
              controller: _evidenceController,
              readOnly: true, // Make the field non-editable
              decoration: InputDecoration(
                labelText: 'Evidence',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_selectedImage != null) ...[
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: _removeImage, // Remove the selected image
                      ),
                      SizedBox(width: 10),
                    ],
                    IconButton(
                      icon: Icon(Icons.camera_alt_outlined),
                      onPressed: () {
                        _openImagePicker(context); // Open the bottom sheet for image selection
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Display selected image
            if (_selectedImage != null) ...[
              SizedBox(height: 20),
              Image.file(
                _selectedImage!,
                width: 200,
                height: 200,
              ),
            ],

            const SizedBox(height: 20),
            const Text(
              'Additional Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Any other relevant information',
              ),
            ),
            const SizedBox(height: 20),
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
