import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _DotTicker implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

class TypingDotCubit extends Cubit<int> {
  TypingDotCubit(Duration delay) : super(0) {
    controller = AnimationController(
      vsync: _DotTicker(),
      duration: const Duration(milliseconds: 700),
    );
    Future.delayed(delay, () {
      if (!isClosed) controller.repeat(reverse: true);
    });
  }

  late final AnimationController controller;

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
