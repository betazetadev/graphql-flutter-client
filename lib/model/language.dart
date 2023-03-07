class Language {
  final int languageId;
  final String name;
  final DateTime lastUpdate;
  final String code;

  Language({
    required this.languageId,
    required this.name,
    required this.lastUpdate,
    required this.code,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      languageId: json['language_id'] as int,
      name: json['name'] as String,
      lastUpdate: DateTime.parse(json['last_update'] as String),
      code: json['code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'last_update': lastUpdate.toIso8601String(),
      'code': code,
    };
  }
}
