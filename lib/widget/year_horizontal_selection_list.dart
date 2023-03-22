import 'package:flutter/material.dart';

class YearHorizontalSelectionList extends StatefulWidget {
  YearHorizontalSelectionList(
      {super.key,
      required this.onYearSelected,
      required this.latestSelectedYear});

  final Function onYearSelected;
  int latestSelectedYear = 2023;

  @override
  YearHorizontalSelectionListState createState() =>
      YearHorizontalSelectionListState();
}

class YearHorizontalSelectionListState
    extends State<YearHorizontalSelectionList> {
  List<int> years = [];

  @override
  void initState() {
    super.initState();
    for (int i = DateTime.now().year; i >= 2003; i--) {
      years.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  color: widget.latestSelectedYear == years[index]
                      ? Colors.black
                      : Colors.grey,
                  fontSize: 16.0,
                ),
              ),
              onTap: () {
                setState(() {
                  widget.latestSelectedYear = years[index];
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
