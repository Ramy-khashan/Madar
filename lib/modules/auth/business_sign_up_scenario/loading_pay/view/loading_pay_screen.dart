import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_pay_view.dart';
import 'pay_dots_cubit.dart';

class LoadingPayScreen extends StatelessWidget {
  const LoadingPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PayDotsCubit(),
      child: Builder(
        builder: (context) {
          final dotController = context.read<PayDotsCubit>().controller;
          return LoadingPayView(dotController: dotController);
        },
      ),
    );
  }
}
