import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../../../individual/property_details/model/property_details_model.dart';

class OwnerPropertyImages extends StatefulWidget {
  const OwnerPropertyImages({super.key, required this.property});

  final PropertyDetailsModel? property;

  @override
  State<OwnerPropertyImages> createState() => _OwnerPropertyImagesState();
}

class _OwnerPropertyImagesState extends State<OwnerPropertyImages> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final images =
        widget.property?.media
            ?.where((m) => m.url != null && m.url!.isNotEmpty)
            .map((m) => m.url!)
            .toList() ??
        [];

    return ClipRRect(
      borderRadius: BorderRadius.circular(24.radius),
      child: Stack(
        children: [
          SizedBox(
            height: 220.height,
            width: double.infinity,
            child: images.isEmpty
                ? ImageItem(
                    '',
                    fit: BoxFit.cover,
                    height: 220.height,
                    width: double.infinity,
                  )
                : PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                    itemBuilder: (context, index) => ImageItem(
                      images[index],
                      fit: BoxFit.cover,
                      height: 220.height,
                      width: double.infinity,
                    ),
                  ),
          ),
          if (images.length > 1)
            Positioned(
              bottom: 10.height,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 3.width),
                    width: _currentPage == index ? 16.width : 6.width,
                    height: 6.height,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? colors.primaryBrand
                          : colors.cardBackground.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(3.radius),
                    ),
                  ),
                ),
              ),
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
                (widget.property?.type ?? '').trans,
                style: TextStyle(
                  color: colors.primaryBrand,
                  fontSize: context.responsiveFontScale(13),
                  fontFamily: AppConstant.appHeaderFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
