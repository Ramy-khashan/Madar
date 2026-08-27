import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import 'counter_button_item.dart';

class CounterRow extends StatelessWidget {
  const CounterRow({
    super.key,
    required this.label,
    this.image,
    required this.field,
    required this.getValue,
    required this.onIncrement,
    required this.onDecrement,
  });
  final String label;
  final String? image;
  final String field;
  final int Function(AddPropertyState state) getValue;
  final AddPropertyEvent onIncrement;
  final AddPropertyEvent onDecrement;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      builder: (context, state) {
        final value = getValue(state);
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.width,
            vertical: 16.height,
          ),
          decoration: BoxDecoration(
            color: tc.cardBackground,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: tc.borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (image != null)
                ImageItem(image!, width: 24.width, height: 24.width),
              if (label.isNotEmpty)
                Text(
                  label,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontWeight: FontWeight.w600,
                    color: tc.textPrimary,
                  ),
                ),
              Row(
                children: [
                  CounterButton(
                    icon: Icons.add_rounded,
                    onTap: () => AddPropertyBloc.get(context).add(onIncrement),
                    tc: tc,
                    enabled: true,
                    isPrimery: true,
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      '$value',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
                        fontWeight: FontWeight.w700,
                        color: tc.textPrimary,
                      ),
                    ),
                  ),
                  CounterButton(
                    icon: Icons.remove_rounded,
                    onTap: () => AddPropertyBloc.get(context).add(onDecrement),
                    tc: tc,
                    enabled: value > 0,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
