import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/add_property_bloc.dart';

class DetailBuilder extends StatelessWidget {
  const DetailBuilder({
    super.key,
    required this.detailKey,
    required this.builder,
  });

  final String detailKey;
  final Widget Function(
    BuildContext context,
    AddPropertyBloc bloc,
    dynamic value,
  )
  builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.typeDetails[detailKey] !=
              curr.model.typeDetails[detailKey] ||
          prev.fieldErrors[detailKey] != curr.fieldErrors[detailKey],
      builder: (context, state) => builder(
        context,
        AddPropertyBloc.get(context),
        state.model.typeDetails[detailKey],
      ),
    );
  }
}
