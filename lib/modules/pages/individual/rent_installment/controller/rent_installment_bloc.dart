import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../model/rent_installment_model.dart';
import '../model/rent_working_info_model.dart';
import '../model/request_status_model.dart';

part 'rent_installment_event.dart';
part 'rent_installment_state.dart';

class RentInstallmentBloc
    extends Bloc<RentInstallmentEvent, RentInstallmentState> {
  RentInstallmentBloc() : super(const RentInstallmentState()) {
    on<RentInstallmentLoad>(_onLoad);
    on<RentInstallmentTabChanged>(_onTabChanged);
  }

  static RentInstallmentBloc get(BuildContext context) =>
      context.read<RentInstallmentBloc>();

  static List<RentInstallmentRequestModel> get _mockRequests => [
    RentInstallmentRequestModel(
      id: '1',
      propertyName: 'شقة في حي النرجس',
      requestNumber: 'REQ-002',
      rentValue: 45000,
      planMonths: 12,
      providerName: AppStrings.providerTamara,
      status: 'accepted',
    ),
    RentInstallmentRequestModel(
      id: '2',
      propertyName: 'شقة في حي النرجس',
      requestNumber: 'REQ-002',
      rentValue: 45000,
      planMonths: 12,
      providerName: AppStrings.providerTamara,
      status: 'under_review',
    ),
    RentInstallmentRequestModel(
      id: '3',
      propertyName: 'شقة في حي النرجس',
      requestNumber: 'REQ-002',
      rentValue: 45000,
      planMonths: 12,
      providerName: AppStrings.providerTamara,
      status: 'rejected',
      rejectionReason: 'بيانات العميل غير مستوفية لمتطلبات التقسيط.',
    ),
  ];

  static List<InstallmentProviderInfoModel> get _mockProviders => [
    InstallmentProviderInfoModel(
      name: AppStrings.providerTamara,
      subtitle: 'خطط مرنة - موافقة سريعة',
    ),
    InstallmentProviderInfoModel(
      name: AppStrings.providerTabby,
      subtitle: 'خطط مرنة - موافقة سريعة',
    ),
    const InstallmentProviderInfoModel(
      name: 'سبوتي',
      subtitle: 'خطط مرنة - موافقة سريعة',
    ),
  ];

  void _onLoad(RentInstallmentLoad event, Emitter<RentInstallmentState> emit) {
    emit(state.copyWith(requests: _mockRequests, providers: _mockProviders));
  }

  void _onTabChanged(
    RentInstallmentTabChanged event,
    Emitter<RentInstallmentState> emit,
  ) {
    emit(state.copyWith(selectedTab: event.tabIndex));
  }

  static List<RentWorkingInfoModel> stepsItem = [
    RentWorkingInfoModel(
      title: AppStrings.installmentStep1,
      icon: AppImages.auctionHomeIcon,
    ),
    RentWorkingInfoModel(
      title: AppStrings.installmentStep2,
      icon: AppImages.documentsIcon,
    ),
    RentWorkingInfoModel(
      title: AppStrings.installmentStep3,
      icon: AppImages.sendMsgIcon,
    ),
    RentWorkingInfoModel(
      title: AppStrings.installmentStep4,
      icon: AppImages.pendingIcon,
    ),
    RentWorkingInfoModel(
      title: AppStrings.installmentStep5,
      icon: AppImages.trackRequestImage,
    ),
  ];
  static (String, Color) requestNoteStatus(String status) {
    final String note;
    final Color noteColor;
    switch (status) {
      case 'accepted':
        note = AppStrings.installmentAcceptedNote;
        noteColor = AppColors.successColor;
        break;
      case 'under_review':
        note = AppStrings.installmentUnderReviewNote;
        noteColor = AppColors.rate;
        break;
      case 'rejected':
        note = AppStrings.installmentRejectedNote;
        noteColor = AppColors.errorColor;
        break;
      default:
        note = '';
        noteColor = AppColors.grey400;
    }
    return (note, noteColor);
  }

  static RequestStatusModel statusInfo(String status) {
    switch (status) {
      case 'accepted':
        return RequestStatusModel(
          label: AppStrings.acceptedStatus,
          color: AppColors.successColor,
        );
      case 'under_review':
        return RequestStatusModel(
          label: AppStrings.underReviewStatus,
          color: Colors.orange,
        );
      case 'rejected':
        return RequestStatusModel(
          label: AppStrings.rejectedStatus,
          color: AppColors.errorColor,
        );
      default:
        return RequestStatusModel(label: status, color: Colors.grey);
    }
  }
}
