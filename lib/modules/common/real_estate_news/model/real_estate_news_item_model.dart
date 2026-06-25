class RealEstateNewsItemModel {
  final String id;
  final String category;
  final String title;
  final String summary;
  final String body;
  final String readTime;
  final String publishedAt;
  final String image;
  final List<String> tags;
  final String createdAt;
  final String updatedAt;

  const RealEstateNewsItemModel({
    required this.id,
    required this.category,
    required this.title,
    required this.summary,
    required this.body,
    required this.readTime,
    required this.publishedAt,
    required this.image,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RealEstateNewsItemModel.fromJson(Map<String, dynamic> json) {
    return RealEstateNewsItemModel(
      id: json['id'] as String? ?? '',
      category: json['category'] as String? ?? '',
      title: json['title'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      body: json['body'] as String? ?? '',
      readTime: json['readTime']?.toString() ?? '0',
      publishedAt: json['publishedAt'] as String? ?? '',
      image: json['image'] as String? ?? '',
      tags: (json['tags'] as List?)?.cast<String>() ?? [],
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  /// Minutes to read, derived from [readTime].
  String get readMinutes => readTime;

  /// Relative time string derived from [publishedAt].
  String get timeAgo {
    if (publishedAt.isEmpty) return '';
    final date = DateTime.tryParse(publishedAt);
    if (date == null) return publishedAt;
    final diff = DateTime.now().difference(date);
    if (diff.inDays >= 365) {
      final y = (diff.inDays / 365).floor();
      return 'منذ $y ${y == 1 ? 'سنة' : 'سنوات'}';
    } else if (diff.inDays >= 30) {
      final m = (diff.inDays / 30).floor();
      return 'منذ $m ${m == 1 ? 'شهر' : 'أشهر'}';
    } else if (diff.inDays >= 1) {
      return 'منذ ${diff.inDays} ${diff.inDays == 1 ? 'يوم' : 'أيام'}';
    } else if (diff.inHours >= 1) {
      return 'منذ ${diff.inHours} ${diff.inHours == 1 ? 'ساعة' : 'ساعات'}';
    } else if (diff.inMinutes >= 1) {
      return 'منذ ${diff.inMinutes} ${diff.inMinutes == 1 ? 'دقيقة' : 'دقائق'}';
    } else {
      return 'الآن';
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category,
        'title': title,
        'summary': summary,
        'body': body,
        'readTime': readTime,
        'publishedAt': publishedAt,
        'image': image,
        'tags': tags,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
