import 'package:flutter/material.dart';
import '../../controller/add_property_bloc.dart';
import 'property_inputs/counter_field_widget.dart';
import 'field_error_text.dart';
import 'detail_builder.dart';

class DetailCounter extends StatelessWidget {
  const DetailCounter({
    super.key,
    required this.label,
    required this.detailKey,
  });

  final String label;
  final String detailKey;

  @override
  Widget build(BuildContext context) {
    return DetailBuilder(
      detailKey: detailKey,
      builder: (context, bloc, value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CounterFieldWidget(
            label: label,
            value: value is int ? value : 0,
            onChanged: (next) => bloc.add(
              next > (value is int ? value : 0)
                  ? IncrementDetailCounterEvent(detailKey)
                  : DecrementDetailCounterEvent(detailKey),
            ),
          ),
          FieldErrorText(detailKey),
        ],
      ),
    );
  }
}
