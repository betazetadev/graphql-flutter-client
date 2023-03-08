import 'package:flutter/material.dart';

class YearHorizontalSelectionList extends StatefulWidget {
  const YearHorizontalSelectionList(this.onYearSelected, {super.key});

  final Function(int) onYearSelected;

  @override
  YearHorizontalSelectionListState createState() =>
      YearHorizontalSelectionListState();
}

class YearHorizontalSelectionListState
    extends State<YearHorizontalSelectionList> {
  List<int> years = [];
  int selectedYear = 2023;

  @override
  void initState() {
    super.initState();
    int currentYear = DateTime.now().year;
    selectedYear = currentYear;
    for (int i = currentYear; i >= 2006; i--) {
      years.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: years.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 12),
            child: GestureDetector(
              child: Text(
                years[index].toString(),
                style: TextStyle(
                  color:
                      selectedYear == years[index] ? Colors.black : Colors.grey,
                  fontSize: 16.0,
                ),
              ),
              onTap: () {
                setState(() {
                  selectedYear = years[index];
                });
                widget.onYearSelected(years[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
