import 'package:flutter/material.dart';
import '../../controller/add_property_bloc.dart';
import 'property_inputs/radio_group_widget.dart';
import 'field_error_text.dart';
import 'detail_builder.dart';

class DetailRadioChips extends StatelessWidget {
  const DetailRadioChips({
    super.key,
    required this.label,
    required this.detailKey,
    required this.options,
  });

  final String label;
  final String detailKey;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return DetailBuilder(
      detailKey: detailKey,
      builder: (context, bloc, value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioGroupWidget(
            label: label,
            options: options,
            selectedOption: value?.toString() ?? '',
            onChanged: (v) => bloc.add(SetDetailFieldEvent(detailKey, v)),
          ),
          FieldErrorText(detailKey),
        ],
      ),
    );
  }
}
