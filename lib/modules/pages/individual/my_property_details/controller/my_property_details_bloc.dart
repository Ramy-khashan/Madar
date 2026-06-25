import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../model/property_details_model.dart';

part 'my_property_details_event.dart';
part 'my_property_details_state.dart';

class MyPropertyDetailsBloc
    extends Bloc<MyPropertyDetailsEvent, MyPropertyDetailsState> {
  MyPropertyDetailsBloc() : super(const MyPropertyDetailsState()) {
    on<MyPropertyDetailsLoad>(_onLoad);
    on<MyPropertyDetailsToggleBookmark>(_onToggleBookmark);
    on<MyPropertyDetailsImageViewStarted>(_onImageViewStarted);
    on<MyPropertyDetailsPageChanged>(_onPageChanged);
    on<_MyPropertyDetailsAutoScrollTick>(_onAutoScrollTick);
  }

  StreamSubscription<void>? _autoScrollSubscription;
  final PageController pageController = PageController();

  static MyPropertyDetailsBloc get(BuildContext context) =>
      BlocProvider.of<MyPropertyDetailsBloc>(context);

  // ── Handlers ──────────────────────────────────────────────────────────────

  Future<void> _onLoad(
    MyPropertyDetailsLoad event,
    Emitter<MyPropertyDetailsState> emit,
  ) async {
    emit(const MyPropertyDetailsState(getDetailsStatus: RequestStatus.loading));
    emit(
      MyPropertyDetailsState(
        property: PropertyDetailsModel(
          id: event.propertyId,
          title: 'شقة فاخرة في الملقا',
          location: 'الرياض - حي الملقا',
          imageUrls: [
            AppImages.propertyImage,
            AppImages.propertyImage,
            AppImages.propertyImage,
          ],
          beds: 3,
          balconies: 3,
          baths: 3,
          area: '150 ${AppStrings.mesurement}',
          floor: 3,
          propertyNumber: '3',
          paymentMethod: 'كاش او تقسيط',
          tag: 'فلل',
          isBookmarked: false,
          occupancyRate: 0,
          contracts: const [
            ContractModel(
              id: 'c1',
              tenantName: 'أحمد محمد السعيد',
              monthlyRent: 200000,
              startDate: '1-1-2024',
              endDate: '3-2-2034',
              status: 'active',
            ),
          ],
          totalIncome: 48000,
          totalExpenses: 48000,
          monthlyFinancials: const [
            FinancialMonthData(month: 'يناير', income: 24, expenses: 21),
            FinancialMonthData(month: 'فبراير', income: 25, expenses: 22),
            FinancialMonthData(month: 'مارس', income: 23, expenses: 23.5),
            FinancialMonthData(month: 'أبريل', income: 26, expenses: 22),
          ],
        ),
        getDetailsStatus: RequestStatus.success,
      ),
    );
  }

  void _onToggleBookmark(
    MyPropertyDetailsToggleBookmark event,
    Emitter<MyPropertyDetailsState> emit,
  ) {
    final current = state;
    final updated = PropertyDetailsModel(
      id: current.property?.id ?? '',
      title: current.property?.title ?? '',
      location: current.property?.location ?? '',
      imageUrls: current.property?.imageUrls ?? [],
      beds: current.property?.beds ?? 0,
      balconies: current.property?.balconies ?? 0,
      baths: current.property?.baths ?? 0,
      area: current.property?.area ?? '',
      floor: current.property?.floor ?? 0,
      propertyNumber: current.property?.propertyNumber ?? '',
      paymentMethod: current.property?.paymentMethod ?? '',
      tag: current.property?.tag ?? '',
      isBookmarked: !(current.property?.isBookmarked ?? false),
      occupancyRate: current.property?.occupancyRate ?? 0,
      contracts: current.property?.contracts ?? const [],
      totalIncome: current.property?.totalIncome ?? 0,
      totalExpenses: current.property?.totalExpenses ?? 0,
      monthlyFinancials: current.property?.monthlyFinancials ?? const [],
    );
    emit(current.copyWith(property: updated));
  }

  void _onImageViewStarted(
    MyPropertyDetailsImageViewStarted event,
    Emitter<MyPropertyDetailsState> emit,
  ) {
    if (event.imageCount <= 1) return;
    _autoScrollSubscription?.cancel();
    _autoScrollSubscription = Stream.periodic(const Duration(seconds: 3))
        .listen((_) => add(const _MyPropertyDetailsAutoScrollTick()));
  }

  void _onPageChanged(
    MyPropertyDetailsPageChanged event,
    Emitter<MyPropertyDetailsState> emit,
  ) {
    emit(state.copyWith(currentImagePage: event.page));
  }

  void _onAutoScrollTick(
    _MyPropertyDetailsAutoScrollTick event,
    Emitter<MyPropertyDetailsState> emit,
  ) {
    final imageCount = state.property?.imageUrls.length ?? 0;
    if (imageCount <= 1) return;
    final next = (state.currentImagePage + 1) % imageCount;
    emit(state.copyWith(currentImagePage: next));
    if (pageController.hasClients) {
      pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Future<void> close() {
    _autoScrollSubscription?.cancel();
    pageController.dispose();
    return super.close();
  }
}
