import 'package:graphql_flutter_client/model/mpaa_rating.dart';

class Film {
  final int? filmId;
  final String title;
  final String? description;
  final int? releaseYear;
  final int languageId;
  final int? originalLanguageId;
  final int rentalDuration;
  final double rentalRate;
  final int? length;
  final double replacementCost;
  final MPAARating? rating;
  final DateTime lastUpdate;
  final String? specialFeatures;
  final String fulltext;

  Film({
    this.filmId,
    required this.title,
    this.description,
    this.releaseYear,
    required this.languageId,
    this.originalLanguageId,
    required this.rentalDuration,
    required this.rentalRate,
    this.length,
    required this.replacementCost,
    this.rating,
    required this.lastUpdate,
    this.specialFeatures,
    required this.fulltext,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'release_year': releaseYear,
      'language_id': languageId,
      'original_language_id': originalLanguageId,
      'rental_duration': rentalDuration,
      'rental_rate': rentalRate,
      'length': length,
      'replacement_cost': replacementCost,
      'rating': mPAARatingKeyValues[rating],
      'last_update': lastUpdate.toIso8601String(),
      'special_features': specialFeatures,
      'fulltext': fulltext,
    };
  }

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      filmId: json['film_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      releaseYear: json['release_year'] as int,
      languageId: json['language_id'] as int,
      originalLanguageId: json['original_language_id'],
      rentalDuration: json['rental_duration'] as int,
      rentalRate: json['rental_rate'] as double,
      length: json['length'],
      replacementCost: json['replacement_cost'] as double,
      rating: mPAARatingKeyValues.keys.firstWhere(
          (k) => mPAARatingKeyValues[k] == json['rating'],
          orElse: () => MPAARating.g),
      lastUpdate: DateTime.parse(json['last_update'] as String),
      specialFeatures: json['special_features'],
      fulltext: json['fulltext'] as String,
    );
  }
}
