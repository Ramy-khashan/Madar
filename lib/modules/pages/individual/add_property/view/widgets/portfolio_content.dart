import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../controller/add_property_bloc.dart';

class PortfolioContent extends StatelessWidget {
  const PortfolioContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.isNewFolder != curr.isNewFolder ||
          prev.hasPortfolioMode != curr.hasPortfolioMode,
      builder: (context, state) {
        if (!state.hasPortfolioMode) {
          return const SizedBox.shrink();
        }
        return AppTextField(
          controller: AddPropertyBloc.get(context).portfolioNameController,
          hint: AppStrings.newFileNameHint,
          title: AppStrings.fileNameLabel,
          prefixIcon: Icons.folder_outlined,
        );
      },
    );
  }
}
