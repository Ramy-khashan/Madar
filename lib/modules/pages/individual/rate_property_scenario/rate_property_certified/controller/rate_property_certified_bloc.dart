import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/constants/app_enums.dart';
import '../../rate_property/model/rate_property_model.dart';

part 'rate_property_certified_event.dart';
part 'rate_property_certified_state.dart';

class RatePropertyCertifiedBloc
    extends Bloc<RatePropertyCertifiedEvent, RatePropertyCertifiedState> {
  RatePropertyCertifiedBloc() : super(const RatePropertyCertifiedState()) {
    on<RatePropertyCertifiedTypeSelected>(_onTypeSelected);
    on<RatePropertyCertifiedFieldChanged>(_onFieldChanged);
    on<RatePropertyCertifiedNextStep>(_onNextStep);
    on<RatePropertyCertifiedPrevStep>(_onPrevStep);
    on<RatePropertyCertifiedFileAdded>(_onFileAdded);
    on<RatePropertyCertifiedFileRemoved>(_onFileRemoved);
    on<RatePropertyCertifiedCompanySelected>(_onCompanySelected);
    on<RatePropertyCertifiedSubmit>(_onSubmit);
    on<RatePropertyCertifiedLoadCompanies>(_onLoadCompanies);
  }

  static RatePropertyCertifiedBloc get(BuildContext context) =>
      BlocProvider.of<RatePropertyCertifiedBloc>(context);
  final TextEditingController propertyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
   void _onTypeSelected(
    RatePropertyCertifiedTypeSelected event,
    Emitter<RatePropertyCertifiedState> emit,
  ) {
    emit(state.copyWith(selectedType: event.typeId));
  }

  void _onFieldChanged(
    RatePropertyCertifiedFieldChanged event,
    Emitter<RatePropertyCertifiedState> emit,
  ) {
    emit(
      state.copyWith(
        location: event.location ?? state.location,
        area: event.area ?? state.area,
        propertyAge: event.propertyAge ?? state.propertyAge,
        finishingLevel: event.finishingLevel ?? state.finishingLevel,
        purpose: event.purpose ?? state.purpose,
      ),
    );
  }

  void _onNextStep(
    RatePropertyCertifiedNextStep event,
    Emitter<RatePropertyCertifiedState> emit,
  ) {
     if (state.currentStep < 2) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void _onPrevStep(
    RatePropertyCertifiedPrevStep event,
    Emitter<RatePropertyCertifiedState> emit,
  ) {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void _onFileAdded(
    RatePropertyCertifiedFileAdded event,
    Emitter<RatePropertyCertifiedState> emit,
  ) {
    final file = RatePropertyUploadedFile(
      name: event.fileName,
      sizeKb: event.sizeKb,
    );
    switch (event.fileKey) {
      case 'ownership_deed':
        emit(state.copyWith(ownershipDeedFile: file));
      case 'owner_id':
        emit(state.copyWith(ownerIdFile: file, ownerIdError: false));
      case 'property_plan':
        emit(state.copyWith(propertyPlanFile: file));
    }
  }

  void _onFileRemoved(
    RatePropertyCertifiedFileRemoved event,
    Emitter<RatePropertyCertifiedState> emit,
  ) {
    switch (event.fileKey) {
      case 'ownership_deed':
        emit(state.copyWith(clearOwnershipDeed: true));
      case 'owner_id':
        emit(state.copyWith(clearOwnerId: true));
      case 'property_plan':
        emit(state.copyWith(clearPropertyPlan: true));
    }
  }

  Future<void> _onLoadCompanies(
    RatePropertyCertifiedLoadCompanies event,
    Emitter<RatePropertyCertifiedState> emit,
  ) async {
    emit(state.copyWith(companiesStatus: RequestStatus.loading));
     emit(
      state.copyWith(
        companiesStatus: RequestStatus.success,
        companies: const [
          RatePropertyCompanyModel(
            id: 'company1',
            name: 'شركة التقييم العقاري المعتمدة',
            rating: 4.8,
            reviewsCount: 25,
            workDays: '4-3',
            price: 1500,
          ),
          RatePropertyCompanyModel(
            id: 'company2',
            name: 'مؤسسة الخبراء للتقييم',
            rating: 4.6,
            reviewsCount: 25,
            workDays: '4-0',
            price: 1500,
          ),
          RatePropertyCompanyModel(
            id: 'company3',
            name: 'مكتب المحترفون للاستشارات العقارية',
            rating: 4.5,
            reviewsCount: 25,
            workDays: '7-5',
            price: 1500,
          ),
        ],
      ),
    );
  }

  void _onCompanySelected(
    RatePropertyCertifiedCompanySelected event,
    Emitter<RatePropertyCertifiedState> emit,
  ) {
    emit(state.copyWith(selectedCompanyId: event.companyId));
  }

  Future<void> _onSubmit(
    RatePropertyCertifiedSubmit event,
    Emitter<RatePropertyCertifiedState> emit,
  ) async {
    // if (state.ownerIdFile == null) {
    //   emit(state.copyWith(ownerIdError: true));
    //   return;
    // }
    emit(state.copyWith(submitStatus: RequestStatus.loading));
     emit(
      state.copyWith(
        submitStatus: RequestStatus.success,
        requestNumber: 'INS-002',
      ),
    );
  }
}
