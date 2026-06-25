import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  const TaskModel({
    required this.id,
    required this.label,
    this.isCompleted = false,
  });

  final String id;
  final String label;
  final bool isCompleted;

  TaskModel copyWith({bool? isCompleted}) {
    return TaskModel(
      id: id,
      label: label,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, label, isCompleted];
}

class PhaseModel extends Equatable {
  const PhaseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.tasks,
    this.imagePaths = const [],
    this.note = '',
    this.customTask = '',
  });

  final String id;
  final String title;
  final String description;
  final String status; // 'completed' | 'in_progress'
  final List<TaskModel> tasks;
  final List<String> imagePaths;
  final String note;
  final String customTask;

  bool get canApprove => imagePaths.isNotEmpty;

  PhaseModel copyWith({
    String? status,
    List<TaskModel>? tasks,
    List<String>? imagePaths,
    String? note,
    String? customTask,
  }) {
    return PhaseModel(
      id: id,
      title: title,
      description: description,
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      imagePaths: imagePaths ?? this.imagePaths,
      note: note ?? this.note,
      customTask: customTask ?? this.customTask,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, status, tasks, imagePaths, note, customTask];
}

class ProjectModel extends Equatable {
  const ProjectModel({
    required this.id,
    required this.name,
    required this.location,
    required this.status,
    required this.progress,
    required this.imageUrl,
    required this.phases,
  });

  final String id;
  final String name;
  final String location;
  final String status; // 'in_progress' | 'completed'
  final double progress; // 0.0 to 1.0
  final String imageUrl;
  final List<PhaseModel> phases;

  ProjectModel copyWith({
    String? status,
    double? progress,
    List<PhaseModel>? phases,
  }) {
    return ProjectModel(
      id: id,
      name: name,
      location: location,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      imageUrl: imageUrl,
      phases: phases ?? this.phases,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, location, status, progress, imageUrl, phases];
}
