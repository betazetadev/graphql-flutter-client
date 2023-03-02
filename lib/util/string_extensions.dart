extension StringExtension on String {
  int toInt() {
    return int.tryParse(this) ?? 0;
  }

  int toYear() {
    return int.tryParse(this) ?? DateTime.now().year;
  }
}
