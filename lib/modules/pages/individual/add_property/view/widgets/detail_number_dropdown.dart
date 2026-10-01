import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../controller/add_property_bloc.dart';
import 'property_inputs/dropdown_field_widget.dart';
import 'detail_builder.dart';

class DetailNumberDropdown extends StatelessWidget {
  const DetailNumberDropdown({
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
      builder: (context, bloc, value) => DropdownFieldWidget(
        label: label,
        items: options,
        translateItems: false,
        hint: AppStrings.chooseLabel(label),
        selectedValue: value?.toString(),
        errorText: AddPropertyBloc.get(context).state.fieldErrors[detailKey],
        onChanged: (v) {
          if (v == null) return;
          bloc.add(SetDetailFieldEvent(detailKey, int.tryParse(v) ?? 0));
        },
      ),
    );
  }
}
