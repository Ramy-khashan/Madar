import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/app_enums.dart';
import '../model/contract_details_model.dart';

part 'contract_details_event.dart';
part 'contract_details_state.dart';

class ContractDetailsBloc
    extends Bloc<ContractDetailsEvent, ContractDetailsState> {
  ContractDetailsBloc() : super(const ContractDetailsState()) {
    on<ContractDetailsLoad>(_onLoad);
  }

  static ContractDetailsBloc get(BuildContext context) =>
      context.read<ContractDetailsBloc>();

  Future<void> _onLoad(
    ContractDetailsLoad event,
    Emitter<ContractDetailsState> emit,
  ) async {
    emit(state.copyWith(loadStatus: RequestStatus.loading));
 
    const ContractDetailsModel data = ContractDetailsModel(
      id: '1',
      title: 'عقد شراء - شقة الملقا',
      propertyName: 'شقة الملقا، الرياض',
      location: 'الرياض',
      tenantName: 'أحمد محمد',
      ownerName: 'شركة مدار العقارية',
      brokerName: 'خالد العتيبي',
      status: 'active',
      type: 'buy',
      startDate: '2024-01-15',
      endDate: '2025-01-14',
      paymentCycle: 'سنوي',
      securityDeposit: 20000,
      annualRent: 850000,
      monthlyRent: 70833,
      totalContractValue: 850000,
      terms: 
        'يلتزم المستأجر بسداد الدفعات في موعدها المحدد.'
        'يحظر إجراء أي تعديلات إنشائية دون موافقة خطية.'
        'يتحمل المستأجر تكاليف الخدمات التشغيلية الدورية.'
      ,
      attachments: [
        'contract-main.pdf',
        'national-id.pdf',
        'payment-receipt.pdf',
      ],
    );
    emit(
      state.copyWith(
        loadStatus: RequestStatus.success,
        contract: data,
        errorMsg: '',
      ),
    );
  }
}
