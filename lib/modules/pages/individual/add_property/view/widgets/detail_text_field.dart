import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class DetailTextField extends StatelessWidget {
  const DetailTextField({
    super.key,
    required this.label,
    required this.detailKey,
    this.unit,
    this.isNumeric = false,
  });

  final String label;
  final String detailKey;
  final String? unit;
  final bool isNumeric;

  @override
  Widget build(BuildContext context) {
    final bloc = AddPropertyBloc.get(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.fieldErrors[detailKey] != curr.fieldErrors[detailKey],
      builder: (context, state) {
        return AppTextField(
          controller: bloc.detailController(detailKey),
          title: label,
          textInputType: isNumeric ? TextInputType.number : TextInputType.text,
          errorText: state.fieldErrors[detailKey],
          suffixIconWidget: unit == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    unit!,
                    style: TextStyle(fontSize: context.responsiveFontScale(14)),
                  ),
                ),
        );
      },
    );
  }
}
