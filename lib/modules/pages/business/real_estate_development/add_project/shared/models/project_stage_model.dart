import 'package:equatable/equatable.dart';

class ProjectStageModel extends Equatable {
  const ProjectStageModel({
    required this.id,
    required this.name,
    required this.description,
    required this.subStages,
  });

  final String id;
  final String name;
  final String description;
  final List<SubStageModel> subStages;

  factory ProjectStageModel.fromJson(Map<String, dynamic> json) {
    final rawSubs =
        json['subStages'] ?? json['sub_stages'] ?? json['substages'];
    return ProjectStageModel(
      id: (json['id'] ?? json['stageId'] ?? json['stage_id'] ?? '').toString(),
      name:
          (json['name'] ??
                  json['title'] ??
                  json['nameAr'] ??
                  json['nameEn'] ??
                  '')
              .toString(),
      description: (json['description'] ?? json['desc'] ?? '').toString(),
      subStages: rawSubs is List
          ? rawSubs
                .whereType<Map>()
                .map(
                  (e) => SubStageModel.fromJson(Map<String, dynamic>.from(e)),
                )
                .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'subStages': subStages.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, name, description, subStages];
}

class SubStageModel extends Equatable {
  const SubStageModel({
    required this.id,
    required this.name,
    required this.stageId,
    this.isCustom = false,
  });

  final String id;
  final String name;
  final String stageId;
  final bool isCustom;

  bool get isOther {
    final n = name.trim().toLowerCase();
    return isCustom ||
        n == 'other' ||
        n == 'أخرى' ||
        n == 'اخري' ||
        n == 'اخرى';
  }

  factory SubStageModel.fromJson(Map<String, dynamic> json) {
    return SubStageModel(
      id: (json['id'] ?? json['subStageId'] ?? json['sub_stage_id'] ?? '')
          .toString(),
      name:
          (json['name'] ??
                  json['title'] ??
                  json['nameAr'] ??
                  json['nameEn'] ??
                  '')
              .toString(),
      stageId: (json['stageId'] ?? json['stage_id'] ?? '').toString(),
      isCustom: json['isCustom'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'stageId': stageId, 'isCustom': isCustom};
  }

  @override
  List<Object?> get props => [id, name, stageId, isCustom];
}
