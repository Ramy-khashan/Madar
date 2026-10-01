import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _PayTicker implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

class PayDotsCubit extends Cubit<int> {
  PayDotsCubit() : super(0) {
    controller = AnimationController(
      vsync: _PayTicker(),
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
