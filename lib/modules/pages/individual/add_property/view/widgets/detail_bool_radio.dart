import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/property_enums.dart';
import 'property_inputs/radio_group_widget.dart';
import 'field_error_text.dart';
import 'detail_builder.dart';

class DetailBoolRadio extends StatelessWidget {
  const DetailBoolRadio({
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
          RadioGroupWidget(
            label: label,
            options: AppConstant.availabilityOptions,
            selectedOption: value is bool
                ? PropertyApiEnums.availabilityFromBool(value)
                : '',
            onChanged: (v) => bloc.add(
              SetDetailFieldEvent(
                detailKey,
                v == PropertyApiEnums.availabilityExist,
              ),
            ),
          ),
          FieldErrorText(detailKey),
        ],
      ),
    );
  }
}
