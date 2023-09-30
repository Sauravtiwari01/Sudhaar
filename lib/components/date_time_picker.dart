import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final Function(DateTime, TimeOfDay) onDateTimeSelected;

  DateTimePicker({
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateTimeSelected,
  });

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => _selectDate(context),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Date of complaint',
              suffixIcon: Icon(Icons.calendar_today),
            ),
            child: DateText(
              selectedDate: widget.selectedDate,
            ),
          ),
        ),
        InkWell(
          onTap: () => _selectTime(context),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Time of complaint',
              suffixIcon: Icon(Icons.access_time),
            ),
            child: Text(
              widget.selectedTime == null
                  ? 'Select Time'
                  : widget.selectedTime!.format(context),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 20, // Adjust the width as needed
            child: AlertDialog(
              title: Text("Select Date"),
              content: Container(
                height: 300, // Adjust the height as needed
                child: CalendarDatePicker(
                  initialDate: widget.selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                  onDateChanged: (newDate) {
                    Navigator.of(context).pop(newDate);
                    setState(() {
                      widget.selectedDate = newDate; // Update the selected date
                    });
                  },
                ),
              ),
            ),
          ),
        );
      },
    )) as DateTime;

    if (pickedDate != null) {
      widget.onDateTimeSelected(pickedDate, widget.selectedTime!);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = (await showTimePicker(
      context: context,
      initialTime: widget.selectedTime ?? TimeOfDay.now(),
    ))!;

    if (pickedTime != null) {
      widget.onDateTimeSelected(widget.selectedDate!, pickedTime);
    }
  }
}

class DateText extends StatefulWidget {
  final DateTime? selectedDate;

  DateText({required this.selectedDate});

  @override
  _DateTextState createState() => _DateTextState();
}

class _DateTextState extends State<DateText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.selectedDate == null
          ? 'Select Date'
          : '${widget.selectedDate!.toLocal()}'.split(' ')[0],
    );
  }
}
