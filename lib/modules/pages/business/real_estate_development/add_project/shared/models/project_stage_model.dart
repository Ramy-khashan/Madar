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
    return ProjectStageModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      subStages: (json['subStages'] as List<dynamic>?)
              ?.map((e) => SubStageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
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

  factory SubStageModel.fromJson(Map<String, dynamic> json) {
    return SubStageModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      stageId: json['stageId'] as String? ?? '',
      isCustom: json['isCustom'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stageId': stageId,
      'isCustom': isCustom,
    };
  }

  @override
  List<Object?> get props => [id, name, stageId, isCustom];
}
