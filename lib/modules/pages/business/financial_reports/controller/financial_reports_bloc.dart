import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/statistic_circle_model.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../model/financial_report_models.dart';

part 'financial_reports_event.dart';
part 'financial_reports_state.dart';

class FinancialReportsBloc
    extends Bloc<FinancialReportsEvent, FinancialReportsState> {
  FinancialReportsBloc() : super(const FinancialReportsState()) {
    on<FinancialReportsLoad>(_onLoad);
    on<FinancialReportsTabChanged>(_onTabChanged);
    on<FinancialReportsPeriodChanged>(_onPeriodChanged);
    on<FinancialReportsScopeChanged>(_onScopeChanged);
  }

  static FinancialReportsBloc get(BuildContext context) =>
      context.read<FinancialReportsBloc>();

  static final List<FinancialPropertyItem> _mockCategoryItems = [
    FinancialPropertyItem(
      name: 'برج الياسمين',
      amount: '45,000',
      paid: true,
      status: 'مدفوع',
      date: DateTime(2026, 1, 5),
    ),
    FinancialPropertyItem(
      name: 'فيلا النخيل',
      amount: '28,000',
      paid: true,
      status: 'مدفوع',
      date: DateTime(2026, 1, 10),
    ),
    FinancialPropertyItem(
      name: 'شقق الورود',
      amount: '35,000',
      paid: false,
      status: 'دفع جزئي',
      date: DateTime(2026, 1, 15),
    ),
    FinancialPropertyItem(
      name: 'مجمع السلام',
      amount: '52,000',
      paid: true,
      status: 'مدفوع',
      date: DateTime(2026, 1, 20),
    ),
  ];

  static final List<FinancialTransaction> _mockTransactions = [
    FinancialTransaction(
      name: 'برج الياسمين',
      date: DateTime(2026, 1, 5),
      desc: 'صيانة المصاعد',
      amount: '3,500',
    ),
    FinancialTransaction(
      name: 'فيلا النخيل',
      date: DateTime(2026, 1, 8),
      desc: 'إصلاح السكنية',
      amount: '1,200',
    ),
    FinancialTransaction(
      name: 'شقق الورود',
      date: DateTime(2026, 1, 12),
      desc: 'تأمين شامل',
      amount: '4,000',
    ),
    FinancialTransaction(
      name: 'مجمع السلام',
      date: DateTime(2026, 1, 15),
      desc: 'عمولة تسويقية',
      amount: '2,500',
    ),
    FinancialTransaction(
      name: 'برج الياسمين',
      date: DateTime(2026, 1, 20),
      desc: 'خدمات نظافة',
      amount: '1,500',
    ),
  ];

  static final List<FinancialRentItem> _mockRentItems = [
    FinancialRentItem(
      name: 'برج الياسمين',
      amount: '45,000',
      date: DateTime(2026, 1, 5),
      status: 'مدفوع',
      paid: true,
    ),
    FinancialRentItem(
      name: 'فيلا النخيل',
      amount: '28,000',
      date: DateTime(2026, 1, 10),
      status: 'مدفوع',
      paid: true,
    ),
    FinancialRentItem(
      name: 'شقق الورود',
      amount: '35,000',
      date: DateTime(2026, 1, 15),
      status: 'دفع جزئي',
      paid: false,
    ),
    FinancialRentItem(
      name: 'مجمع السلام',
      amount: '52,000',
      date: DateTime(2026, 1, 20),
      status: 'مدفوع',
      paid: true,
    ),
  ];

  static final List<FinancialTenant> _mockLateTenants = [
    const FinancialTenant(
      name: 'أحمد محمد',
      property: 'برج الياسمين',
      amount: '2,500',
      days: '15 يوم',
    ),
    const FinancialTenant(
      name: 'فاطمة علي',
      property: 'شقق الورود',
      amount: '1,800',
      days: '8 يوم',
    ),
  ];

  static final List<FinancialSettlement> _mockSettlements = [
    FinancialSettlement(
      label: 'تسوية إيجار فيلا النرجس',
      date: DateTime(2025, 3, 1),
      amount: '8,500',
      status: 'مكتملة',
    ),
    FinancialSettlement(
      label: 'تسوية صيانة شقة العليا',
      date: DateTime(2025, 2, 15),
      amount: '1,200',
      status: 'قيد المراجعة',
    ),
    FinancialSettlement(
      label: 'تسوية رسوم إدارية',
      date: DateTime(2025, 1, 20),
      amount: '650',
      status: 'مكتملة',
    ),
  ];

  static const List<StatisticCircleModel> _mockIncomeSections = [
    StatisticCircleModel(
      label: 'إيجارات',
      value: 0.50,
      color: Color(0xFF6C63FF),
    ),
    StatisticCircleModel(
      label: 'خدمات إضافية',
      value: 0.35,
      color: Color(0xFFFF6B9D),
    ),
    StatisticCircleModel(
      label: 'رسوم تأخير',
      value: 0.15,
      color: Color(0xFFB39DDB),
    ),
  ];

  static const List<StatisticCircleModel> _mockExpensesSections = [
    StatisticCircleModel(label: 'صيانة', value: 0.50, color: Color(0xFF6C63FF)),
    StatisticCircleModel(label: 'تأمين', value: 0.35, color: Color(0xFFFF6B9D)),
    StatisticCircleModel(
      label: 'عمولات',
      value: 0.15,
      color: Color(0xFFB39DDB),
    ),
  ];

  void _onLoad(
    FinancialReportsLoad event,
    Emitter<FinancialReportsState> emit,
  ) {
    emit(state.copyWith(status: RequestStatus.loading));
    emit(
      state.copyWith(
        status: RequestStatus.success,
        categoryItems: _mockCategoryItems,
        transactions: _mockTransactions,
        rentItems: _mockRentItems,
        lateTenants: _mockLateTenants,
        settlements: _mockSettlements,
        incomeSections: _mockIncomeSections,
        expensesSections: _mockExpensesSections,
      ),
    );
  }

  void _onTabChanged(
    FinancialReportsTabChanged event,
    Emitter<FinancialReportsState> emit,
  ) {
    emit(state.copyWith(selectedTab: event.tabIndex));
  }

  void _onPeriodChanged(
    FinancialReportsPeriodChanged event,
    Emitter<FinancialReportsState> emit,
  ) {
    emit(state.copyWith(selectedPeriod: event.period));
  }

  void _onScopeChanged(
    FinancialReportsScopeChanged event,
    Emitter<FinancialReportsState> emit,
  ) {
    emit(state.copyWith(selectedScope: event.scope));
  }
}
