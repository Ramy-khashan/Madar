import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../controller/add_property_bloc.dart';
import 'portfolio_content.dart';
import 'portfolio_mode_toggle.dart';

class SavePortfolioSheet extends StatelessWidget {
  const SavePortfolioSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    final bloc = AddPropertyBloc.get(context);
    return Container(
      decoration: BoxDecoration(
        color: tc.backgroundPrimary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        16.width,
        12.height,
        16.width,
        MediaQuery.of(context).viewInsets.bottom + 24.height,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.saveToMyPropertyFiles,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(18),
                        fontWeight: FontWeight.w700,
                        color: tc.textPrimary,
                      ),
                    ),
                    4.height.toSizedBox,
                    Text(
                      AppStrings.chooseSaveLocation,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        color: tc.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close, color: tc.textPrimary),
              ),
            ],
          ),
          20.height.toSizedBox,
          const PortfolioModeToggle(),
          16.height.toSizedBox,
          const PortfolioContent(),
          20.height.toSizedBox,
          AppButton(
            text: AppStrings.confirmSave,
            onTap: () {
              final state = bloc.state;
              if (!state.isNewFolder && !state.model.hasParentProperty) {
                AppToast(AppStrings.pleaseSelectExistingFile, isError: true);
                return;
              }
              bloc.add(const ConfirmSaveEvent());
              RouterHandler.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
