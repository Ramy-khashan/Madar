import 'package:equatable/equatable.dart';

class ProjectPhaseModel extends Equatable {
  const ProjectPhaseModel({
    required this.id,
    required this.name,
    required this.status,
  });

  final String id;
  final String name;

  /// 'completed' | 'in_progress' | 'delayed'
  final String status;

  factory ProjectPhaseModel.fromJson(Map<String, dynamic> json) =>
      ProjectPhaseModel(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        status: json['status'] as String? ?? 'in_progress',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
      };

  @override
  List<Object?> get props => [id, name, status];
}
