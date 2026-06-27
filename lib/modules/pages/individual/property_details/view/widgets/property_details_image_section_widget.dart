import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:share_plus/share_plus.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/property_details_bloc.dart';
import '../../model/property_details_buyer_model.dart';

class PropertyDetailsImageSectionWidget extends StatelessWidget {
  const PropertyDetailsImageSectionWidget({super.key, required this.property});

  final PropertyBuyerModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.radius),
      child: Stack(
        children: [
          ImageItem(
            property?.imageUrls.isNotEmpty == true
                ? property!.imageUrls.first
                : '',
            fit: BoxFit.cover,
            height: 220.height,
            width: double.infinity,
          ),
          Positioned(
            top: 12.height,
            right: 12.width,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 14.width,
                vertical: 6.height,
              ),
              decoration: BoxDecoration(
                color: colors.hoverColor,
                borderRadius: BorderRadius.circular(20.radius),
              ),
              child: Text(
                property?.tag ?? '',
                style: TextStyle(
                  color: colors.primaryBrand,
                  fontSize: context.responsiveFontScale(13),
                  fontFamily: AppConstant.appHeaderFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            top: 12.height,
            left: 12.width,
            child: BlocBuilder<PropertyDetailsBloc, PropertyDetailsState>(
              builder: (ctx, state) {
                return GestureDetector(
                  onTap: () => ctx
                      .read<PropertyDetailsBloc>()
                      .add(const PropertyDetailsToggleBookmark()),
                  child: Container(
                    padding: EdgeInsets.all(8.width),
                    decoration: BoxDecoration(
                      color:
                          colors.cardBackground.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      state.property?.isBookmarked == true
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      size: 20.width,
                      color: state.property?.isBookmarked == true
                          ? colors.primaryBrand
                          : colors.cardBackground,
                    ),
                  ),
                );
              },
            ),
          ),
          // Positioned(
          //   bottom: 12.height,
          //   left: 12.width,
          //   child: GestureDetector(
          //     onTap: () => Share.share(
          //       '${property?.tag ?? ''}\n${property?.imageUrls.isNotEmpty == true ? property!.imageUrls.first : ''}',
          //     ),
          //     child: Container(
          //       padding: EdgeInsets.all(8.width),
          //       decoration: BoxDecoration(
          //         color: colors.cardBackground.withValues(alpha: 0.2),
          //         shape: BoxShape.circle,
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withValues(alpha: 0.1),
          //             blurRadius: 6,
          //           ),
          //         ],
          //       ),
          //       child: Icon(
          //         Icons.share_outlined,
          //         size: 20.width,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
      
        ],
      ),
    );
  }
}
