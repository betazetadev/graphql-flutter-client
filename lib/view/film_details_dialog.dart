import 'package:flutter/material.dart';

import '../model/film.dart';
import '../model/mpaa_rating.dart';

class FilmDetailsDialog extends StatelessWidget {
  final Film film;

  const FilmDetailsDialog({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Refactor this to a separate class
    final int hours = (film.length ?? 0) ~/ 60;
    final int minutes = (film.length ?? 0) % 60;
    final String minutesString = minutes < 10 ? '0$minutes' : '$minutes';
    final String hoursString = hours < 10 ? '0$hours' : '$hours';
    final String length = '$hoursString:$minutesString';

    return AlertDialog(
      title: const Text('Movie Details'),
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
                // TODO: Implement modify film logic
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // TODO: Implement delete film logic
                Navigator.of(context).pop();
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
                      ' $length',
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
