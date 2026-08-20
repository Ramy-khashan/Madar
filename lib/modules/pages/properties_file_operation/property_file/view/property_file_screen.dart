import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/image_item.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../controller/property_file_bloc.dart';
import 'widgets/owner_property_content_item.dart';
import 'widgets/property_files_content_item.dart';

class PropertyFileScreen extends StatelessWidget {
  const PropertyFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = PropertyFileBloc.get(context);
    final colors = AppThemeColors.of(context);

    return BlocListener<PropertyFileBloc, PropertyFileState>(
      listenWhen: (prev, curr) => curr.isDeleted && !prev.isDeleted,
      listener: (context, state) => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: colors.backgroundPrimary,
        appBar: AppAppbar(
          title: AppStrings.propertyFileTitle,
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'send') {
                  RouterHandler.navigate(
                    context,
                    AppRouterKeys.chooseBroker,
                    extra: bloc.state.details?.propertyId ?? bloc.state.property?.id,
                  );
                } else if (value == 'delete') {
                  _confirmDelete(context, bloc);
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'send',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.sendPropertyFileToBroker,
                        style: TextStyle(
                          color: colors.textFieldTitle,
                          fontFamily: AppConstant.appFont,
                          fontSize: context.responsiveFontScale(14),
                        ),
                      ),
                      SizedBox(width: 10.width),

                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16.width,
                        color: colors.textFieldTitle,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.deleteProperty,
                        style: TextStyle(
                          color: AppColors.errorColor,
                          fontFamily: AppConstant.appFont,
                          fontSize: context.responsiveFontScale(14),
                        ),
                      ),
                      SizedBox(width: 8.width),

                      ImageItem(
                        AppImages.deleteIcon,
                        color: AppColors.errorColor,
                      ),
                    ],
                  ),
                ),
              ],
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
                child: state.property == null && state.details == null
                    ? const SizedBox()
                    : state.isMultiUnit
                    ? PropertyFileContentItem(
                        property: state.property!,
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

  void _confirmDelete(BuildContext context, PropertyFileBloc bloc) {
    showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppStrings.deleteProperty),
        content: Text(AppStrings.deletePropertyConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              bloc.add(const PropertyFileDeleteProperty());
            },
            child: Text(
              AppStrings.deleteBtn,
              style: const TextStyle(color: AppColors.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}
