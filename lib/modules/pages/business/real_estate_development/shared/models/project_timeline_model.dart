import 'package:equatable/equatable.dart';

class ProjectTimelineModel extends Equatable {
  const ProjectTimelineModel({
    required this.id,
    required this.date,
    required this.description,
  });

  final String id;
  final String date;
  final String description;

  factory ProjectTimelineModel.fromJson(Map<String, dynamic> json) =>
      ProjectTimelineModel(
        id: json['id'] as String? ?? '',
        date: json['date'] as String? ?? '',
        description: json['description'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'description': description,
      };

  @override
  List<Object?> get props => [id, date, description];
}
