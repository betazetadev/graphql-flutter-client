import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:flutter/material.dart';
import '../model/film.dart';
import '../view/film_details_page.dart';

class AlphabeticalSelectionList extends StatefulWidget {
  final List<Film> items;

  const AlphabeticalSelectionList({super.key, required this.items});

  @override
  AlphabeticalSelectionListState createState() =>
      AlphabeticalSelectionListState();
}

class AlphabeticalSelectionListState extends State<AlphabeticalSelectionList> {
  final ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AlphabetScrollView(
        list: widget.items.map((e) => AlphaModel(e.title)).toList(),
        itemExtent: 100,
        itemBuilder: (_, index, title) {
          final Film rowFilm =
              widget.items.where((element) => element.title == title).first;
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ListTile(
              onTap: () {
                final Film selectedFilm = widget.items
                    .where((element) => element.title == title)
                    .first;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FilmDetailsPage(
                            film: selectedFilm,
                          )),
                );
              },
              title: Text(rowFilm.title),
              subtitle: Text(rowFilm.description ?? ''),
              leading: Text(
                rowFilm.rentalRate.toString(),
                style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Image.asset(
                  'icons/flags/png/2.5x/${rowFilm.language?.code ?? 'en'}.png',
                  package: 'country_icons',
                  width: 64),
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
