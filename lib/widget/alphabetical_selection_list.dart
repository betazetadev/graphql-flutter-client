import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:flutter/material.dart';
import '../model/film.dart';
import '../view/film_details_dialog.dart';

class AlphabeticalSelectionList extends StatefulWidget {
  const AlphabeticalSelectionList({super.key, required this.items});

  final List<Film> items;

  @override
  AlphabeticalSelectionListState createState() =>
      AlphabeticalSelectionListState();
}

class AlphabeticalSelectionListState extends State<AlphabeticalSelectionList> {
  @override
  Widget build(BuildContext context) {
    return AlphabetScrollView(
        list: widget.items.map((e) => AlphaModel(e.title)).toList(),
        itemExtent: 50,
        isAlphabetsFiltered: true,
        itemBuilder: (_, index, title) {
          final Film rowFilm =
              widget.items.where((element) => element.title == title).first;
          return Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: ListTile(
              dense: true,
              onTap: () {
                final Film selectedFilm = widget.items
                    .where((element) => element.title == title)
                    .first;
                showDialog(
                    context: context,
                    builder: (context) => FilmDetailsDialog(
                          film: selectedFilm,
                          onFilmDeleted: (Film deletedFilm) {
                            setState(() {
                              widget.items.remove(deletedFilm);
                            });
                          },
                          onFilmEdited: (Film editedFilm) {
                            setState(() {
                              widget.items[
                                  widget.items.indexWhere((element) =>
                                      element.filmId == editedFilm.filmId)] =
                                  editedFilm;
                            });
                          },
                        ));
              },
              title: Text(rowFilm.title),
              subtitle: Text(
                rowFilm.description ?? '',
              ),
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
        selectedTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        unselectedTextStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal));
  }
}
