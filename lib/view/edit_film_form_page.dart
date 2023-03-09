import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter_client/util/string_extensions.dart';
import '../model/film.dart';
import '../model/mpaa_rating.dart';

String editFilmMutation = r"""
  mutation EditFilmMutation($filmId: Int, $film: film_set_input = {}) {
    update_film(where: {film_id: {_eq: $filmId}}, _set: $film) {
      affected_rows
    }
  }
""";

class EditFilmFormPage extends StatefulWidget {
  const EditFilmFormPage({super.key, required this.film});

  final Film film;

  @override
  EditFilmFormPageState createState() => EditFilmFormPageState();
}

class EditFilmFormPageState extends State<EditFilmFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _releaseYearController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _lengthController = TextEditingController();
  final _ratingController = TextEditingController();
  late MPAARating? mpaaRating = MPAARating.g;

  @override
  void dispose() {
    _titleController.dispose();
    _releaseYearController.dispose();
    _descriptionController.dispose();
    _lengthController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = widget.film.title;
    _releaseYearController.text = widget.film.releaseYear.toString();
    _descriptionController.text = widget.film.description ?? '';
    _lengthController.text = widget.film.length.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.film.title} edition'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _releaseYearController,
                decoration: const InputDecoration(
                  labelText: 'Release Year',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lengthController,
                decoration: const InputDecoration(
                  labelText: 'Length',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              DropdownButton<MPAARating>(
                  value: mpaaRating,
                  onChanged: (MPAARating? newValue) {
                    setState(() {
                      mpaaRating = newValue;
                    });
                  },
                  items: MPAARating.values.map((MPAARating classType) {
                    return DropdownMenuItem<MPAARating>(
                        value: classType,
                        child: Text(classType.name.toUpperCase()));
                  }).toList()),
              Mutation(
                options: MutationOptions(
                  document: gql(editFilmMutation),
                  onCompleted: (dynamic resultData) {
                    print(resultData);
                    if (resultData != null) {
                      int affectedRows =
                          resultData['update_film']['affected_rows'];
                      if (affectedRows > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Film ${widget.film.title} created successfully',
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    }
                  },
                  onError: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error creating film (${widget.film.title}): ${error.toString()}',
                        ),
                      ),
                    );
                    print(error);
                  },
                ),
                builder: (runMutation, result) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Film film = Film(
                          filmId: widget.film.filmId,
                          title: _titleController.text,
                          releaseYear: _releaseYearController.text.toYear(),
                          description: _descriptionController.text,
                          languageId: 1,
                          length: _lengthController.text.toInt(),
                          rating: mpaaRating,
                          rentalDuration: 7,
                          rentalRate: 20,
                          replacementCost: 10,
                          lastUpdate: DateTime.now(),
                          fulltext: 'Full text',
                        );
                        runMutation({
                          'filmId': film.filmId,
                          'film': film.toJson(),
                        });
                      }
                    },
                    child: const Text('Submit'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
