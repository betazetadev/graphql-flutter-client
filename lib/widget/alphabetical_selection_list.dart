import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:flutter/material.dart';
import '../model/film.dart';
import '../view/film_details_page.dart';

class AlphabeticalSelectionList extends StatefulWidget {
  final List<Film> items;

  AlphabeticalSelectionList({required this.items});

  @override
  _AlphabeticalSelectionListState createState() =>
      _AlphabeticalSelectionListState();
}

class _AlphabeticalSelectionListState extends State<AlphabeticalSelectionList> {
  final ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AlphabetScrollView(
        list: widget.items.map((e) => AlphaModel(e.title)).toList(),
        itemExtent: 50,
        itemBuilder: (_, index, title) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ListTile(
              onTap: () {
                print(index);
                final Film selectedFilm = widget.items.where((element) => element.title == title).first;
                print(selectedFilm.title);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FilmDetailsPage(
                            film: selectedFilm,
                          )),
                );
              },
              title: Text(title),
              subtitle: Text('Secondary text'),
            ),
          );
        },
        selectedTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        unselectedTextStyle:
            TextStyle(color: Colors.grey, fontWeight: FontWeight.normal));
  }
}
