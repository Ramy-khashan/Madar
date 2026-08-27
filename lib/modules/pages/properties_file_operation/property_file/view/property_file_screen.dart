import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/confirm_delete_dialog.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/constants/storage_keys.dart';
import '../../../../../core/utils/functions/preference_utils.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../controller/property_file_bloc.dart';
import 'widgets/owner_property_content_item.dart';
import 'widgets/property_file_overflow_menu.dart';
import 'widgets/property_files_content_item.dart';

class PropertyFileScreen extends StatelessWidget {
  const PropertyFileScreen({super.key});

  bool get _isBroker =>
      PreferenceUtils().getString(StorageKeys.accountType) ==
      AppConstant.business;

  @override
  Widget build(BuildContext context) {
    final bloc = PropertyFileBloc.get(context);
    final colors = AppThemeColors.of(context);

    return BlocListener<PropertyFileBloc, PropertyFileState>(
      listenWhen: (prev, curr) => curr.isDeleted && !prev.isDeleted,
      listener: (context, state) =>RouterHandler.pop(context),
      child: Scaffold(
        backgroundColor: colors.backgroundPrimary,
        appBar: AppAppbar(
          title: AppStrings.propertyFileTitle,
          actions: [
            PropertyFileOverflowMenu(
              showSend: !_isBroker,
              onSend: () => RouterHandler.navigate(
                context,
                AppRouterKeys.chooseBroker,
                extra:
                    bloc.state.details?.propertyId ??
                    bloc.state.property?.id,
              ),
              onDelete: () => showConfirmDeleteDialog(
                context: context,
                title: AppStrings.deleteProperty,
                content: AppStrings.deletePropertyConfirmation,
                onConfirm: () =>
                    bloc.add(const PropertyFileDeleteProperty()),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<PropertyFileBloc, PropertyFileState>(
            builder: (context, state) {
              return LoadingProcess(
                status: state.status,
                errorMsg: state.errorMsg,
                onTapRefresh: () => bloc.add(const PropertyFileLoad()),
                emptyMsg: '',
                isEmptyList: false,
                childIsLoader: true,
                child: 
                // state.property == null && state.details == null
                //     ? const SizedBox()
                //     :
                     state.isMultiUnit
                    ? PropertyFileContentItem(
                        property: state.property,
                        colors: colors,
                        state: state,
                        bloc: bloc,
                      )
                    : OwnerPropertyContentItem(
                        bloc: bloc,
                        state: state,
                        colors: colors,
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
