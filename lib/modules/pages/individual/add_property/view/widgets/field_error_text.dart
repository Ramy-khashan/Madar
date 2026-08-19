import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class FieldErrorText extends StatelessWidget {
  const FieldErrorText(this.fieldKey, {super.key});

  final String fieldKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.fieldErrors[fieldKey] != curr.fieldErrors[fieldKey],
      builder: (context, state) {
        final message = state.fieldErrors[fieldKey];
        if (message == null || message.isEmpty) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: EdgeInsets.only(top: 6.height),
          child: Text(
            message,
            style: TextStyle(
              fontSize: context.responsiveFontScale(12),
              color: AppColors.errorColor,
            ),
          ),
        );
      },
    );
  }
}
