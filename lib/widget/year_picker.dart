import 'package:flutter/material.dart';

class CustomYearPicker extends StatefulWidget {
  final int startYear;
  final int endYear;
  final ValueChanged<int> onChanged;

  const CustomYearPicker(
      {super.key,
      this.startYear = 1900,
      this.endYear = 2100,
      required this.onChanged});

  @override
  CustomYearPickerState createState() => CustomYearPickerState();
}

class CustomYearPickerState extends State<CustomYearPicker> {
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedYear = DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: _selectedYear,
      items: _buildYearItems(),
      onChanged: (value) {
        setState(() {
          _selectedYear = value ?? DateTime.now().year;
          widget.onChanged(value ?? DateTime.now().year);
        });
      },
    );
  }

  List<DropdownMenuItem<int>> _buildYearItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int year = widget.startYear; year <= widget.endYear; year++) {
      items.add(DropdownMenuItem<int>(
        value: year,
        child: Text(year.toString()),
      ));
    }
    return items.reversed.toList();
  }
}
