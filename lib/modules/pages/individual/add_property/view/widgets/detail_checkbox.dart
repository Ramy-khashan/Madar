import 'package:flutter/material.dart';
import '../../controller/add_property_bloc.dart';
import 'property_inputs/checkbox_item_widget.dart';
import 'detail_builder.dart';

class DetailCheckbox extends StatelessWidget {
  const DetailCheckbox({
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
      builder: (context, bloc, value) => CheckboxItemWidget(
        label: label,
        isSelected: value == true,
        onTap: () => bloc.add(ToggleDetailFlagEvent(detailKey)),
      ),
    );
  }
}
