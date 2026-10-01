import 'package:flutter/material.dart';
import '../../config/theme/app_theme_colors.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';
import 'publication_status_tag.dart';

class PortfolioCardHeader extends StatelessWidget {
  const PortfolioCardHeader({
    super.key,
    required this.colors,
    required this.title,
    required this.location,
    required this.imageUrl,
    this.publicationRequestStatus = '',
  });
  final String title;
  final String location;
  final String imageUrl;
  final String publicationRequestStatus;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageItem(
          imageUrl,
          width: (context.isTablet ? 72 : 66).width,
          height: 58.height,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(8),
        ),

        SizedBox(width: 12.width),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,

                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w600,
                  color: colors.textFieldTitle,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.height),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 12.width,
                    color: colors.primaryBrand,
                  ),
                  SizedBox(width: 8.width),

                  Flexible(
                    child: Text(
                      location,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        color: colors.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 8.width),
        PublicationStatusTag(status: publicationRequestStatus),
      ],
    );
  }
}
