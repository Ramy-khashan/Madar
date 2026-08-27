import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart'; 
import '../../property_details/model/property_details_model.dart';
 
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
     }

  void _onToggleBookmark(
    MyPropertyDetailsToggleBookmark event,
    Emitter<MyPropertyDetailsState> emit,
  ) {
    
    // emit(current.copyWith(property: updated));
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
    final items = state.property?.media?.playable ?? const [];
    if (items.length <= 1) return;
    final currentIndex = state.currentImagePage.clamp(0, items.length - 1);
    if (items[currentIndex].isVideo) return;
    final next = (currentIndex + 1) % items.length;
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
