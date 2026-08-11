class RealStateProjectModel {
  bool? success;
  Project? project;
  Stats? stats;
  List<ProjectStages>? stages;
  List<Timeline>? timeline;

  RealStateProjectModel(
      {this.success, this.project, this.stats, this.stages, this.timeline});

  RealStateProjectModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    if (json['stages'] != null) {
      stages = <ProjectStages>[];
      json['stages'].forEach((v) {
        stages!.add(ProjectStages.fromJson(v));
      });
    }
    if (json['timeline'] != null) {
      timeline = <Timeline>[];
      json['timeline'].forEach((v) {
        timeline!.add(Timeline.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    if (stages != null) {
      data['stages'] = stages!.map((v) => v.toJson()).toList();
    }
    if (timeline != null) {
      data['timeline'] = timeline!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Project {
  String? id;
  String? name;
  String? type;
  String? location;
  String? startDate;
  String? endDate;
  String? manager;
  int? overallProgress;
  List<String>? attachments;

  Project(
      {this.id,
      this.name,
      this.type,
      this.location,
      this.startDate,
      this.endDate,
      this.manager,
      this.overallProgress,
      this.attachments});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    location = json['location'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    manager = json['manager'];
    overallProgress = json['overallProgress'];
    attachments = json['attachments'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['location'] = location;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['manager'] = manager;
    data['overallProgress'] = overallProgress;
    data['attachments'] = attachments;
    return data;
  }
}

class Stats {
  int? totalStages;
  int? completed;
  int? inProgress;
  int? delayed;

  Stats({this.totalStages, this.completed, this.inProgress, this.delayed});

  Stats.fromJson(Map<String, dynamic> json) {
    totalStages = json['totalStages'];
    completed = json['completed'];
    inProgress = json['inProgress'];
    delayed = json['delayed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalStages'] = totalStages;
    data['completed'] = completed;
    data['inProgress'] = inProgress;
    data['delayed'] = delayed;
    return data;
  }
}

class ProjectStages {
  String? id;
   String? stageName;
  int? progress;
  String? status;
  String? description;
  List<SubStages>? subStages;

  ProjectStages(
      {this.id,
       this.stageName,
      this.progress,
      this.status,
      this.description,
      this.subStages});

  ProjectStages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
     stageName = json['stageName'];
    progress = json['progress'];
    description = json['description'];
    status = json['status'];
    if (json['subStages'] != null) {
      subStages = <SubStages>[];
      json['subStages'].forEach((v) {
        subStages!.add(SubStages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['stageName'] = stageName;
    data['progress'] = progress;
    data['status'] = status;
    if (subStages != null) {
      data['subStages'] = subStages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubStages {
  String? id;
  String? subStageId;
  String? name;
  int? progress;
  String? status;

  SubStages({this.id, this.subStageId, this.name, this.progress, this.status});

  SubStages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subStageId = json['subStageId'];
    name = json['name'];
    progress = json['progress'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subStageId'] = subStageId;
    data['name'] = name;
    data['progress'] = progress;
    data['status'] = status;
    return data;
  }
}

class Timeline {
  String? id;
  String? content;
  List<String>? attachments;
  String? date;
  String? stageId;
  String? stageName;

  Timeline(
      {this.id,
      this.content,
      this.attachments,
      this.date,
      this.stageId,
      this.stageName});

  Timeline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    attachments = json['attachments'].cast<String>();
    date = json['date'];
    stageId = json['stageId'];
    stageName = json['stageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['attachments'] = attachments;
    data['date'] = date;
    data['stageId'] = stageId;
    data['stageName'] = stageName;
    return data;
  }
}
