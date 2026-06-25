import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/models/project_timeline_model.dart';
import '../../shared/models/real_estate_project_model.dart';
import '../../../../../../../../../core/utils/constants/app_enums.dart';

part 'business_project_details_event.dart';
part 'business_project_details_state.dart';

class BusinessProjectDetailsBloc
    extends Bloc<BusinessProjectDetailsEvent, BusinessProjectDetailsState> {
  BusinessProjectDetailsBloc() : super(const BusinessProjectDetailsState()) {
    on<BusinessProjectDetailsLoad>(_onLoad);
    on<BusinessProjectDetailsAddTimeline>(_onAddTimeline);
  }

  static BusinessProjectDetailsBloc get(BuildContext context) =>
      context.read<BusinessProjectDetailsBloc>();

  void _onLoad(
    BusinessProjectDetailsLoad event,
    Emitter<BusinessProjectDetailsState> emit,
  ) {
    emit(state.copyWith(status: RequestStatus.loading));
    emit(
      state.copyWith(
        status: RequestStatus.success,
        project: event.project,
       ),
    );
  }

  void _onAddTimeline(
    BusinessProjectDetailsAddTimeline event,
    Emitter<BusinessProjectDetailsState> emit,
  ) {
    if (state.project == null) return;

    final updatedTimeline = [
      ProjectTimelineModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: event.date,
        description: event.description,
      ),
      ...state.project!.timeline,
    ];

    emit(
      state.copyWith(
        project: RealEstateProjectModel(
          id: state.project!.id,
          name: state.project!.name,
          location: state.project!.location,
          status: state.project!.status,
          completionPercentage: state.project!.completionPercentage,
          lastUpdate: state.project!.lastUpdate,
          imageUrl: state.project!.imageUrl,
          type: state.project!.type,
          budget: state.project!.budget,
          startDate: state.project!.startDate,
          expectedEndDate: state.project!.expectedEndDate,
          mainPhases: state.project!.mainPhases,
          roomsCount: state.project!.roomsCount,
          bathroomsCount: state.project!.bathroomsCount,
          area: state.project!.area,
          balconyCount: state.project!.balconyCount,
          floorNumber: state.project!.floorNumber,
          propertyNumber: state.project!.propertyNumber,
          unitsCount: state.project!.unitsCount,
          parkingSpots: state.project!.parkingSpots,
          tenants: state.project!.tenants,
          inProgressPhasesCount: state.project!.inProgressPhasesCount,
          delayedPhasesCount: state.project!.delayedPhasesCount,
          phases: state.project!.phases,
          timeline: updatedTimeline,
          smartNotes: state.project!.smartNotes,
          pdfReportUrl: state.project!.pdfReportUrl,
          attachmentUrl: state.project!.attachmentUrl,
        ),
      ),
    );
  }
}
