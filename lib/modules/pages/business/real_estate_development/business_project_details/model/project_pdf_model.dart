import 'real_state_project_model.dart';

class ProjectDetailsModel {
  final ProjectInfo project;
  final ProjectStats stats;
  final List<ProjectStage> stages;
  final List<TimelineItem> timeline;

  ProjectDetailsModel({
    required this.project,
    required this.stats,
    required this.stages,
    required this.timeline,
  });

  factory ProjectDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProjectDetailsModel(
      project: ProjectInfo.fromJson(_asMap(json['project'])),
      stats: ProjectStats.fromJson(_asMap(json['stats'])),
      stages: _asList(json['stages']).map(ProjectStage.fromJson).toList(),
      timeline: _asList(json['timeline']).map(TimelineItem.fromJson).toList(),
    );
  }

  factory ProjectDetailsModel.fromRealState(RealStateProjectModel model) {
    final project = model.project;
    final stats = model.stats;
    return ProjectDetailsModel(
      project: ProjectInfo(
        name: project?.name ?? '',
        type: project?.type ?? '',
        location: project?.location ?? '',
        manager: project?.manager ?? '',
        overallProgress: (project?.overallProgress ?? 0).toDouble(),
        startDate: project?.startDate ?? '',
        endDate: project?.endDate ?? '',
      ),
      stats: ProjectStats(
        totalStages: stats?.totalStages ?? 0,
        completed: stats?.completed ?? 0,
        inProgress: stats?.inProgress ?? 0,
        delayed: stats?.delayed ?? 0,
      ),
      stages: (model.stages ?? [])
          .map(
            (stage) => ProjectStage(
              stageName: stage.stageName ?? '',
              description: stage.description ?? '',
              progress: (stage.progress ?? 0).toDouble(),
              status: stage.status ?? '',
              subStages: (stage.subStages ?? [])
                  .map(
                    (sub) => SubStage(
                      name: sub.name ?? '',
                      progress: (sub.progress ?? 0).toDouble(),
                      status: sub.status ?? '',
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
      timeline: (model.timeline ?? [])
          .map(
            (item) => TimelineItem(
              content: item.content ?? '',
              date: item.date ?? '',
              stageName: item.stageName ?? '',
              attachments: item.attachments ?? const [],
            ),
          )
          .toList(),
    );
  }
}

class ProjectInfo {
  final String name;
  final String type;
  final String location;
  final String manager;
  final double overallProgress;
  final String startDate;
  final String endDate;

  ProjectInfo({
    required this.name,
    required this.type,
    required this.location,
    required this.manager,
    required this.overallProgress,
    required this.startDate,
    required this.endDate,
  });

  factory ProjectInfo.fromJson(Map<String, dynamic> json) {
    return ProjectInfo(
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      location: json['location'] ?? '',
      manager: json['manager'] ?? '',
      overallProgress: (json['overallProgress'] as num?)?.toDouble() ?? 0,
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
    );
  }
}

class ProjectStats {
  final int totalStages;
  final int completed;
  final int inProgress;
  final int delayed;

  ProjectStats({
    required this.totalStages,
    required this.completed,
    required this.inProgress,
    required this.delayed,
  });

  factory ProjectStats.fromJson(Map<String, dynamic> json) {
    return ProjectStats(
      totalStages: json['totalStages'] ?? 0,
      completed: json['completed'] ?? 0,
      inProgress: json['inProgress'] ?? 0,
      delayed: json['delayed'] ?? 0,
    );
  }
}

class ProjectStage {
  final String stageName;
  final String description;
  final double progress;
  final String status;
  final List<SubStage> subStages;

  ProjectStage({
    required this.stageName,
    required this.description,
    required this.progress,
    required this.status,
    required this.subStages,
  });

  factory ProjectStage.fromJson(Map<String, dynamic> json) {
    return ProjectStage(
      stageName: json['stageName'] ?? '',
      description: json['description'] ?? '',
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
      status: json['status'] ?? '',
      subStages: _asList(json['subStages']).map(SubStage.fromJson).toList(),
    );
  }
}

class SubStage {
  final String name;
  final double progress;
  final String status;

  SubStage({
    required this.name,
    required this.progress,
    required this.status,
  });

  factory SubStage.fromJson(Map<String, dynamic> json) {
    return SubStage(
      name: json['name'] ?? '',
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
      status: json['status'] ?? '',
    );
  }
}

class TimelineItem {
  final String content;
  final String date;
  final String stageName;
  final List<String> attachments;

  TimelineItem({
    required this.content,
    required this.date,
    required this.stageName,
    required this.attachments,
  });

  factory TimelineItem.fromJson(Map<String, dynamic> json) {
    return TimelineItem(
      content: json['content'] ?? '',
      date: json['date'] ?? '',
      stageName: json['stageName'] ?? '',
      attachments: List<String>.from(json['attachments'] ?? []),
    );
  }
}

Map<String, dynamic> _asMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  return const <String, dynamic>{};
}

List<Map<String, dynamic>> _asList(dynamic value) {
  if (value is! List) return const [];
  return value.map(_asMap).toList();
}
 