import 'package:graphql_flutter_client/model/mpaa_rating.dart';
import 'language.dart';

class Film {
  final int? filmId;
  final String title;
  final String? description;
  final int? releaseYear;
  final int languageId;
  final Language? language;
  final int? originalLanguageId;
  final int rentalDuration;
  final double rentalRate;
  final int? length;
  final double replacementCost;
  final MPAARating? rating;
  final DateTime lastUpdate;
  final List<String?>? specialFeatures;
  final String fulltext;

  Film({
    this.filmId,
    required this.title,
    this.description,
    this.releaseYear,
    required this.languageId,
    this.language,
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

  String get lengthText {
    final int hours = (length ?? 0) ~/ 60;
    final int minutes = (length ?? 0) % 60;
    final String minutesString = minutes < 10 ? '0$minutes' : '$minutes';
    final String hoursString = hours < 10 ? '0$hours' : '$hours';
    return '$hoursString:$minutesString';
  }

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
    List<String> specialFeatures = [];
    if (json['special_features'] != null) {
      specialFeatures =
          (json['special_features']).map<String>((e) => e.toString()).toList();
    }
    return Film(
      filmId: json['film_id'],
      title: json['title'] as String,
      description: json['description'] as String,
      releaseYear: json['release_year'] as int,
      languageId: json['language_id'] as int,
      language: json['language'] != null
          ? Language.fromJson(json['language'] as Map<String, dynamic>)
          : null,
      originalLanguageId: json['original_language_id'],
      rentalDuration: json['rental_duration'] as int,
      rentalRate: json['rental_rate'] as double,
      length: json['length'],
      replacementCost: json['replacement_cost'] as double,
      rating: mPAARatingKeyValues.keys.firstWhere(
          (k) => mPAARatingKeyValues[k] == json['rating'],
          orElse: () => MPAARating.g),
      lastUpdate: DateTime.parse(json['last_update'] as String),
      specialFeatures: specialFeatures,
      fulltext: json['fulltext'] as String,
    );
  }
}
