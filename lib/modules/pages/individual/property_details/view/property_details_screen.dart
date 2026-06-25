import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/property_details_bloc.dart';
import 'widgets/property_details_content_widget.dart';
import 'widgets/waiting_reply_dialog_widget.dart';

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({super.key, this.propertyId = '1'});

  final String propertyId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyDetailsBloc, PropertyDetailsState>(
      listenWhen: (prev, curr) => prev.submitStatus != curr.submitStatus,
      listener: (ctx, state) {
        if (state.submitStatus == RequestStatus.success) {
          showDialog(
            context: ctx,
            builder: (_) => const WaitingOwnerReplyDialog(),
          );
        }
      },
      builder: (context, state) {
        final colors = AppThemeColors.of(context);
        return Scaffold(
          backgroundColor: colors.backgroundPrimary,
          appBar: AppAppbar(title: AppStrings.propertyDetailsTitle),
          body: SafeArea(
            child: LoadingProcess(
              status: state.getDetailsStatus,
              errorMsg: state.errorMsg,
              onTapRefresh: () => context
                  .read<PropertyDetailsBloc>()
                  .add(PropertyDetailsLoad(propertyId)),
              emptyMsg: '',
              isEmptyList: false,
              childIsLoader: true,
              child: PropertyDetailsContentWidget(property: state.property),
            ),
          ),
        );
      },
    );
  }
}
