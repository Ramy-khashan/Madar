import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import 'existing_folder_list.dart';

class PortfolioContent extends StatelessWidget {
  const PortfolioContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) => prev.isNewFolder != curr.isNewFolder,
      builder: (context, state) {
        if (state.isNewFolder) {
          return AppTextField(
            controller: AddPropertyBloc.get(context).portfolioNameController,
            hint: AppStrings.newFileNameHint,
            title: AppStrings.fileNameLabel,
            prefixIcon: Icons.folder_outlined,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppStrings.chooseTheFile,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w700,
              ),
            ),
            8.height.toSizedBox,
            const ExistingFolderList(),
          ],
        );
      },
    );
  }
}
