import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/property_media_gallery.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/guest_mode.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../controller/property_details_bloc.dart';
import '../../model/property_details_model.dart';

class PropertyDetailsImageSectionWidget extends StatelessWidget {
  const PropertyDetailsImageSectionWidget({super.key, required this.property});

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
          (property?.type ?? '').trans,
          style: TextStyle(
            color: colors.primaryBrand,
            fontSize: context.responsiveFontScale(13),
            fontFamily: AppConstant.appHeaderFont,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      topStart: BlocBuilder<PropertyDetailsBloc, PropertyDetailsState>(
        builder: (ctx, state) {
          return GestureDetector(
            onTap: () {
              if (!GuestMode.requireAuth(
                ctx,
                subtitle: AppStrings.guestFeaturesMessage,
              )) {
                return;
              }
              ctx.read<PropertyDetailsBloc>().add(
                const PropertyDetailsToggleBookmark(),
              );
            },
            child: Container(
              padding: EdgeInsets.all(8.width),
              decoration: BoxDecoration(
                color: colors.cardBackground.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Icon(
                state.isSavedWishList == true
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                size: 20.width,
                color: state.isSavedWishList == true
                    ? colors.primaryBrand
                    : colors.cardBackground,
              ),
            ),
          );
        },
      ),
    );
  }
}
