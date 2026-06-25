import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/project_model.dart';

part 'project_manager_home_event.dart';
part 'project_manager_home_state.dart';

class ProjectManagerHomeBloc
    extends Bloc<ProjectManagerHomeEvent, ProjectManagerHomeState> {
  ProjectManagerHomeBloc() : super(const ProjectManagerHomeState()) {
    on<ProjectManagerHomeLoad>(_onLoad);
  }

  static ProjectManagerHomeBloc get(BuildContext context) =>
      context.read<ProjectManagerHomeBloc>();

  static final List<TaskModel> _defaultTasks = [
    const TaskModel(id: 't1', label: 'إصدار رخصة بناء', isCompleted: true),
    const TaskModel(
        id: 't2',
        label: 'اعتماد المخططات المعمارية والانشائية',
        isCompleted: true),
    const TaskModel(
        id: 't3',
        label: 'اعتماد مخططات الكهرباء والسباكة',
        isCompleted: true),
    const TaskModel(
        id: 't4',
        label: 'اعتماد مخططات الحريق والسلامة',
        isCompleted: true),
    const TaskModel(
        id: 't5',
        label: 'اعتماد مخططات التكييف المركزي',
        isCompleted: true),
    const TaskModel(id: 't6', label: 'تقرير فحص التربة', isCompleted: true),
    const TaskModel(
        id: 't7',
        label: 'التعاقد مع مكتب إشراف هندسي',
        isCompleted: true),
  ];

  static final List<TaskModel> _partialTasks = [
    const TaskModel(id: 't1', label: 'إصدار رخصة بناء', isCompleted: true),
    const TaskModel(
        id: 't2',
        label: 'اعتماد المخططات المعمارية والانشائية',
        isCompleted: true),
    const TaskModel(
        id: 't3',
        label: 'اعتماد مخططات الكهرباء والسباكة',
        isCompleted: true),
    const TaskModel(
        id: 't4',
        label: 'اعتماد مخططات الحريق والسلامة',
        isCompleted: true),
    const TaskModel(
        id: 't5',
        label: 'اعتماد مخططات التكييف المركزي',
        isCompleted: false),
    const TaskModel(id: 't6', label: 'تقرير فحص التربة', isCompleted: false),
    const TaskModel(
        id: 't7',
        label: 'التعاقد مع مكتب إشراف هندسي',
        isCompleted: false),
  ];

  static List<PhaseModel> _buildPhases(String projectId) => [
        PhaseModel(
          id: '${projectId}_p1',
          title: 'المرحلة الاولى: التخطيط والترخيص',
          description: 'تشمل الاعمال الانشائية الاساسية للمشروع',
          status: 'completed',
          tasks: _defaultTasks,
          imagePaths: ['assets/images/property.png'],
          note: 'تم إنجاز هذه المرحلة بنجاح',
        ),
        PhaseModel(
          id: '${projectId}_p2',
          title: 'المرحلة الثانية: الاعمال الاساسية',
          description: 'تشمل الاعمال الانشائية الاساسية للمشروع',
          status: 'in_progress',
          tasks: _partialTasks,
          imagePaths: ['assets/images/property.png'],
        ),
        PhaseModel(
          id: '${projectId}_p3',
          title: 'المرحلة الثالثة: الاعمال الانشائية',
          description: 'تشمل تنفيذ الهيكل الخرساني والجدران',
          status: 'in_progress',
          tasks: _partialTasks
              .map((t) => t.copyWith(
                  isCompleted:
                      t.id == 't1' || t.id == 't2' || t.id == 't3'))
              .toList(),
        ),
        PhaseModel(
          id: '${projectId}_p4',
          title: 'المرحلة الرابعة: التشطيبات',
          description: 'تشمل اعمال التشطيب الداخلي والخارجي',
          status: 'in_progress',
          tasks: _partialTasks
              .map((t) => t.copyWith(isCompleted: t.id == 't1'))
              .toList(),
        ),
        PhaseModel(
          id: '${projectId}_p5',
          title: 'المرحلة الخامسة: التسليم والتشغيل',
          description: 'تشمل الفحوصات النهائية وتسليم المشروع',
          status: 'in_progress',
          tasks: _partialTasks
              .map((t) => t.copyWith(isCompleted: false))
              .toList(),
        ),
      ];

  static List<ProjectModel> get sampleProjects => [
        ProjectModel(
          id: 'proj_1',
          name: 'عمارة النرجس',
          location: 'الرياض - حي اللقا',
          status: 'in_progress',
          progress: 0.45,
          imageUrl: 'assets/images/property.png',
          phases: _buildPhases('proj_1'),
        ),
        ProjectModel(
          id: 'proj_2',
          name: 'عمارة النرجس',
          location: 'الرياض - حي اللقا',
          status: 'completed',
          progress: 0.45,
          imageUrl: 'assets/images/property.png',
          phases: _buildPhases('proj_2'),
        ),
        ProjectModel(
          id: 'proj_3',
          name: 'عمارة النرجس',
          location: 'الرياض - حي اللقا',
          status: 'in_progress',
          progress: 0.45,
          imageUrl: 'assets/images/property.png',
          phases: _buildPhases('proj_3'),
        ),
      ];

  void _onLoad(
      ProjectManagerHomeLoad event, Emitter<ProjectManagerHomeState> emit) {
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(projects: sampleProjects, isLoading: false));
  }
}
