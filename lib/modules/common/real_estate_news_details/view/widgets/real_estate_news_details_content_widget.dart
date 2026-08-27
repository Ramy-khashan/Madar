import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../real_estate_news/model/real_estate_news_item_model.dart';

class RealEstateNewsDetailsContentWidget extends StatefulWidget {
  const RealEstateNewsDetailsContentWidget({super.key, required this.item});

  final RealEstateNewsItemModel? item;

  @override
  State<RealEstateNewsDetailsContentWidget> createState() =>
      _RealEstateNewsDetailsContentWidgetState();
}

class _RealEstateNewsDetailsContentWidgetState
    extends State<RealEstateNewsDetailsContentWidget> {
  static const int _collapseLength = 280;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final item = widget.item;
    final body = item?.body ?? 'News Content is not available';
    final canToggle = body.trim().length > _collapseLength;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 10.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ImageItem(
                item?.image ?? '',
                width: double.infinity,
                height: 300.height,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(24.radius),
              ),
              PositionedDirectional(
                top: 12.height,
                end: 12.width,
                child: Wrap(
                  spacing: 6.width,
                  children: (item?.tags ?? [])
                      .asMap()
                      .entries
                      .map(
                        (tag) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.width,
                            vertical: 4.height,
                          ),
                          decoration: BoxDecoration(
                            color: colors.primaryBrand,
                            borderRadius: BorderRadius.circular(20.radius),
                          ),
                          child: Text(
                            tag.value,
                            style: TextStyle(
                              color: colors.onPrimary,
                              fontSize: context.responsiveFontScale(12),
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.height),
          Text(
            item?.title ?? 'News Title is not available',
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
          SizedBox(height: 12.height),
          Text(
            body,
            maxLines: canToggle && !_expanded ? 8 : null,
            overflow: canToggle && !_expanded
                ? TextOverflow.ellipsis
                : TextOverflow.visible,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              color: colors.textSecondary,
              fontFamily: AppConstant.appFont,
              height: 1.8,
            ),
          ),
          if (canToggle)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(
                onPressed: () => setState(() => _expanded = !_expanded),
                child: Text(
                  _expanded
                      ? AppStrings.showLess
                      : AppStrings.readMoreNewsBtn,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
