import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/image_picker_helper.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_validator.dart';
import '../widgets/add_property_section_label.dart';
import '../widgets/add_property_step_buttons.dart';
import '../widgets/field_error_text.dart';
import '../widgets/image_grid.dart';
import '../widgets/media_picker_card.dart';
import '../widgets/upload_area.dart';

class AddPropertyStep4Screen extends StatelessWidget {
  const AddPropertyStep4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 8.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddPropertySectionLabel(label: AppStrings.propertyPhotos),
                Text(
                  AppStrings.uploadPhotosHint,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: tc.textSecondary,
                  ),
                ),
                12.height.toSizedBox,
                const UploadArea(),
                const FieldErrorText(AddPropertyField.images),
                16.height.toSizedBox,
                const ImageGrid(),
                24.height.toSizedBox,
                Row(
                  children: [
                    Expanded(
                      child: MediaPickerCard(
                        label: AppStrings.tour360,
                        hint: AppStrings.strongerEngagement,
                        emptyHint: AppStrings.tapToAdd360Tour,
                        icon: Icons.map_outlined,
                        pathSelector: (model) => model.virtualTourPath,
                        onPick: () async {
                          final path = await pickVideo();
                          if (path == null || !context.mounted) return;
                          AddPropertyBloc.get(
                            context,
                          ).add(SetVirtualTourPathEvent(path));
                        },
                        onClear: () => AddPropertyBloc.get(
                          context,
                        ).add(const ClearVirtualTourEvent()),
                      ),
                    ),
                    12.width.toSizedBox,
                    Expanded(
                      child: MediaPickerCard(
                        label: AppStrings.videoLabel,
                        hint: AppStrings.upTo60Seconds,
                        emptyHint: AppStrings.tapToAddVideo,
                        icon: Icons.videocam_outlined,
                        pathSelector: (model) => model.videoPath,
                        onPick: () async {
                          final path = await pickVideo(
                            maxDuration: const Duration(seconds: 60),
                          );
                          if (path == null || !context.mounted) return;
                          AddPropertyBloc.get(
                            context,
                          ).add(SetVideoPathEvent(path));
                        },
                        onClear: () => AddPropertyBloc.get(
                          context,
                        ).add(const ClearVideoEvent()),
                      ),
                    ),
                  ],
                ),
                20.height.toSizedBox,
              ],
            ),
          ),
        ),
        const AddPropertyStepButtons(),
      ],
    );
  }
}
