import 'package:flutter/material.dart';

import '../model/film.dart';
import '../model/mpaa_rating.dart';

class FilmDetailsPage extends StatelessWidget {
  final Film film;

  const FilmDetailsPage({
    super.key,
    required this.film,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              film.title,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const Icon(
                      Icons.timer_outlined,
                      color: Colors.grey,
                    ),
                    Text(
                      ' ${film.lengthText}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ]),
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
            Text(
              film.description ?? '',
              style: const TextStyle(fontSize: 16.0),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
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
                    film.specialFeatures?.join(', \n').replaceAll(",", "") ??
                        '',
                    style:
                        const TextStyle(fontSize: 12.0, color: Colors.indigo),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
