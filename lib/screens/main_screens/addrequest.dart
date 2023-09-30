import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../components/forms/autonomousbody.dart';
import '../../components/forms/electricityboardform.dart';
import '../../components/forms/municipality_form.dart';
import '../../components/forms/police_form.dart';
import '../../components/forms/psuform.dart';
import '../../components/forms/telecomform.dart';
import '../../components/forms/waterboard.dart';
class AddRequest extends StatefulWidget {
  const AddRequest({Key? key}) : super(key: key);

  @override
  State<AddRequest> createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  final TextEditingController textEditingController = TextEditingController();
  String selectedValue = '';
  String selectedSubValue = '';
  String? selectedComplaintType;
  bool isDropdownOpen = false; // Added to track dropdown state

  List<String> suggestions = [
    'Municipality',
    'Water Board',
    'Electricity Board',
    'Police',
    'Telecom',
    'Public Sector Undertaking (PSU)',
    'Autonomous Body'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Close the keyboard when tapping outside the text fields.
          FocusScope.of(context).unfocus();

          // Close the dropdown when tapping outside
          if (isDropdownOpen) {
            setState(() {
              isDropdownOpen = false;
            });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return suggestions
                                .where((option) => option.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase(),
                                    ))
                                .toList();
                          },
                          onSelected: (String value) {
                            setState(() {
                              selectedValue = value;
                              selectedComplaintType = null;
                              isDropdownOpen = false;
                            });
                          },
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted) {
                            return TextFormField(
                              controller: textEditingController,
                              focusNode: focusNode,
                              onFieldSubmitted: (_) => onFieldSubmitted(),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search_outlined),
                                hintText: 'What is your problem ?',
                                hintStyle: TextStyle(fontSize: 20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor('#004225')),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isDropdownOpen) // Check if the dropdown is open
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: suggestions.length,
                    itemBuilder: (BuildContext context, int index) {
                      final option = suggestions[index];
                      return ListTile(
                        title: Text(option),
                        onTap: () {
                          setState(() {
                            selectedValue = option;
                            selectedSubValue = '';
                            selectedComplaintType = null;
                            isDropdownOpen = false;
                          });
                        },
                      );
                    },
                  ),
                ),
              const SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: CSCPicker(
                  layout: Layout.vertical,
                  defaultCountry: CscCountry.India,
                  disableCountry: true,
                  selectedItemStyle: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      color: HexColor('#004225'),
                      fontSize: 20,
                    ),
                  ),
                  onCountryChanged: (country) {},
                  onStateChanged: (state) {},
                  onCityChanged: (city) {},
                ),
              ),
              if (selectedValue == 'Municipality')
                MunicipalityForm()
              else if (selectedValue == 'Electricity Board')
                ElectricityBoardForm()
              else if (selectedValue == 'Police')
                PoliceForm()
              else if (selectedValue == 'Public Sector Undertaking (PSU)')
                PSU_Form()
              else if (selectedValue == 'Telecom')
                TelecomForm()
              else if (selectedValue == 'Water Board')
                WaterBoardForm()
              else if (selectedValue == 'Autonomous Body')
                AutonomousBodyForm()
            ],
          ),
        ),
      ),
    );
  }
}
