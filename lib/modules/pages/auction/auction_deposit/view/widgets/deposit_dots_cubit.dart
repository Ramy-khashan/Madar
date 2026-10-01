import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _DotsTicker implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

class DepositDotsCubit extends Cubit<int> {
  DepositDotsCubit() : super(0) {
    controller = AnimationController(
      vsync: _DotsTicker(),
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  late final AnimationController controller;

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
