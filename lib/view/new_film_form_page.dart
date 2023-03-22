import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter_client/util/string_extensions.dart';
import '../grapql/graphql_films.dart';
import '../model/film.dart';
import '../model/mpaa_rating.dart';

class NewFilmFormPage extends StatefulWidget {
  const NewFilmFormPage({super.key, required this.onFilmCreated});

  final Function(Film) onFilmCreated;

  @override
  NewFilmFormPageState createState() => NewFilmFormPageState();
}

class NewFilmFormPageState extends State<NewFilmFormPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Film'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                  document: gql(createFilmMutation),
                  onCompleted: (dynamic resultData) {
                    Film createdFilm =
                        Film.fromJson(resultData['insert_film_one']);
                    print(createdFilm.toJson());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Film ${createdFilm.title} created successfully',
                        ),
                      ),
                    );
                    Navigator.pop(context, createdFilm);
                    widget.onFilmCreated(createdFilm);
                  },
                  onError: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error creating film: ${error.toString()}',
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
