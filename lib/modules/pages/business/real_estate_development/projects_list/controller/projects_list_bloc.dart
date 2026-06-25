import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/constants/app_images.dart';

import '../../shared/models/project_phase_model.dart';
import '../../shared/models/project_timeline_model.dart';
import '../../shared/models/real_estate_project_model.dart';
import '../../../../../../../../../core/utils/constants/app_enums.dart';

part 'projects_list_event.dart';
part 'projects_list_state.dart';

class ProjectsListBloc
    extends Bloc<ProjectsListEvent, ProjectsListState> {
  ProjectsListBloc() : super(const ProjectsListState()) {
    on<ProjectsListLoad>(_onLoad);
  }

  static ProjectsListBloc get(BuildContext context) =>
      context.read<ProjectsListBloc>();

  Future<void> _onLoad(
    ProjectsListLoad event,
    Emitter<ProjectsListState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final mockProjects = [
      RealEstateProjectModel(
        id: '1',
        name: 'مشروع أبراج النرجس',
        location: 'الرياض - حي الملقا',
        status: 'in_progress',
        completionPercentage: 40,
        lastUpdate: 'قبل اسبوع',
        imageUrl: AppImages.propertyImage,
        type: event.role,
        inProgressPhasesCount: 4,
        delayedPhasesCount: 4,
        budget: 5000000,
        startDate: '20/1/2026',
        expectedEndDate: '20/12/2026',
        mainPhases: 'الحفر - الاساسات - التشطيبات',
        phases: const [
          ProjectPhaseModel(id: '1', name: 'الاعمال الترابية', status: 'completed'),
          ProjectPhaseModel(id: '2', name: 'الاساسات', status: 'in_progress'),
          ProjectPhaseModel(id: '3', name: 'الاساسات', status: 'delayed'),
        ],
        timeline: const [
          ProjectTimelineModel(id: '1', date: '20-1-2026', description: 'انهاء صب خرسانة للدور الاول'),
          ProjectTimelineModel(id: '2', date: '26-1-2026', description: 'توريد المواد للعزل'),
          ProjectTimelineModel(id: '3', date: '20-1-2026', description: 'انهاء صب خرسانة للدور الاول'),
        ],
        smartNotes: const [
          'التقدم الحالي: 33%',
          'هناك مراحل متأخرة تحتاج متابعة',
          'مراحل قيد التنفيذ تتطلب تنسيق موارد',
          'تقرير هندسي . PDF',
        ],
      ),
      RealEstateProjectModel(
        id: '2',
        name: 'كمباوند حدائق الرياض',
        location: 'الرياض - حي الملقا',
        status: 'delayed',
        completionPercentage: 0,
        lastUpdate: 'قبل اسبوع',
        imageUrl: AppImages.propertyImage,
        type: event.role,
        inProgressPhasesCount: 0,
        delayedPhasesCount: 2,
        phases: const [],
        timeline: const [],
        smartNotes: const [],
      ),
      RealEstateProjectModel(
        id: '3',
        name: 'مجمع سكني الدمام',
        location: 'الرياض - حي الملقا',
        status: 'completed',
        completionPercentage: 100,
        lastUpdate: 'قبل اسبوع',
        imageUrl: AppImages.propertyImage,
        type: event.role,
        inProgressPhasesCount: 0,
        delayedPhasesCount: 0,
        phases: const [],
        timeline: const [],
        smartNotes: const [],
      ),
    ];

    if (mockProjects.isEmpty) {
      emit(state.copyWith(status: RequestStatus.failed, projects: const []));
    } else {
      emit(
        state.copyWith(
          status: RequestStatus.success,
          projects: mockProjects,
          role: event.role,
        ),
      );
    }
  }
}
