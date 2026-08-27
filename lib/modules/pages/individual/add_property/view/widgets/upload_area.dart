import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/image_picker_helper.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class UploadArea extends StatelessWidget {
  const UploadArea({super.key});

  Future<void> _pick(BuildContext context) async {
    final paths = await pickImages();
    if (paths == null || paths.isEmpty || !context.mounted) return;
    AddPropertyBloc.get(context).add(AddImagesEvent(paths));
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return GestureDetector(
      onTap: () => _pick(context),
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          color: tc.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: tc.primaryBrand.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageItem(
              AppImages.uploadIcon,
              color: tc.primaryBrand,
              width: 28,
              height: 28,
            ),
            12.height.toSizedBox,
            Text(
              AppStrings.clickToUploadPhotos,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w600,
                color: tc.primaryBrand,
              ),
            ),
            6.height.toSizedBox,
            Text(
              AppStrings.orDragImagesHere,
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                color: tc.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
