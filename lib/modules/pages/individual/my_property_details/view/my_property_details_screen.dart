import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/my_property_details_bloc.dart';
import 'widgets/property_details_content_widget.dart';

class MyPropertyDetailsScreen extends StatelessWidget {
  const MyPropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppAppbar(title: AppStrings.propertyDetailsTitle),

      body: SafeArea(
        child: BlocBuilder<MyPropertyDetailsBloc, MyPropertyDetailsState>(
          builder: (context, state) {
            return LoadingProcess(
              status: state.getDetailsStatus,
              errorMsg: state.errorMsg,
              onTapRefresh: () {},
              emptyMsg: '',
              isEmptyList: false,
              childIsLoader: true,
              child: PropertyDetailsContentWidget(property: state.property),
            );
          },
        ),
      ),
    );
  }
}
