import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter_client/view/edit_film_form_page.dart';
import '../grapql/graphql_films.dart';
import '../model/film.dart';
import '../model/mpaa_rating.dart';

class FilmDetailsDialog extends StatelessWidget {
  const FilmDetailsDialog(
      {Key? key,
      required this.film,
      required this.onFilmDeleted,
      required this.onFilmEdited})
      : super(key: key);

  final Film film;
  final Function(Film deletedFilm) onFilmDeleted;
  final Function(Film editedFilm) onFilmEdited;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditFilmFormPage(
                      film: film,
                      onFilmEdited: (Film editedFilm) =>
                          onFilmEdited(editedFilm),
                    ),
                  ),
                );
              },
            ),
            Mutation(
              options: MutationOptions(
                document: gql(deleteFilmMutation),
                onError: (OperationException? error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Error deleting film ${film.title}: ${error?.toString() ?? 'Unknown error'}',
                      ),
                    ),
                  );
                },
                onCompleted: (dynamic resultData) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Film ${film.title} deleted successfully',
                      ),
                    ),
                  );
                  onFilmDeleted(film);
                  Navigator.pop(context);
                },
              ),
              builder: (MultiSourceResult<Object?> Function(
                          Map<String, dynamic>,
                          {Object? optimisticResult})
                      runMutation,
                  QueryResult<Object?>? result) {
                return IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    runMutation({
                      'film_id': film.filmId,
                    });
                  },
                );
              },
            ),
          ],
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              film.title,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.timer_outlined,
                      color: Colors.grey,
                    ),
                    Text(
                      ' ${film.lengthText}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.tag, color: Colors.grey),
                    Text(
                      ' ${mPAARatingKeyValues[film.rating]}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              film.description ?? '',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  film.rentalRate.toString(),
                  style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
                Text(
                  film.specialFeatures?.join(', \n').replaceAll(",", "") ?? '',
                  style: const TextStyle(fontSize: 12.0, color: Colors.indigo),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
