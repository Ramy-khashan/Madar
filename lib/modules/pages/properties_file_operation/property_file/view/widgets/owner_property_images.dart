import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/property_media_gallery.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../../../individual/property_details/model/property_details_model.dart';

class OwnerPropertyImages extends StatelessWidget {
  const OwnerPropertyImages({super.key, required this.property});

  final PropertyDetailsModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return PropertyMediaGallery(
      media: property?.media,
      height: 220.height,
      topEnd: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.width,
          vertical: 6.height,
        ),
        decoration: BoxDecoration(
          color: colors.hoverColor,
          borderRadius: BorderRadius.circular(20.radius),
        ),
        child: Text(
          (property?.type ?? '').transIfExists,
          style: TextStyle(
            color: colors.primaryBrand,
            fontSize: context.responsiveFontScale(13),
            fontFamily: AppConstant.appHeaderFont,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
