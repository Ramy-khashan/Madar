extension StringExtension on String {
  String get toCamelCase {
    final processed = replaceAll('_', ' ').toLowerCase();
    final words = processed.split(' ');

    final buffer = StringBuffer();

    for (var word in words) {
      if (word.trim().isEmpty) continue;

      buffer.write(word[0].toUpperCase() + word.substring(1));
      buffer.write(' ');
    }

    return buffer.toString().trim();
  }
}
