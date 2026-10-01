import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import 'typing_dot_cubit.dart';

class TypingDot extends StatelessWidget {
  const TypingDot({super.key, required this.delay});

  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TypingDotCubit(delay),
      child: Builder(
        builder: (context) {
          final controller = context.read<TypingDotCubit>().controller;
          return FadeTransition(
            opacity: Tween<double>(begin: 0.3, end: 1).animate(controller),
            child: Container(
              width: 7.width,
              height: 7.width,
              decoration: BoxDecoration(
                color: AppThemeColors.of(context).textSecondary,
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      ),
    );
  }
}
