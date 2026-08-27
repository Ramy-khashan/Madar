import 'package:flutter/material.dart';

import '../../config/router/app_router_keys.dart';
import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_images.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
import '../utils/functions/router_handler.dart';
import 'app_textfield.dart';

class SearchItem extends StatefulWidget {
  const SearchItem({
    super.key,
    this.onFilterTap,
    this.showMapButton = true,
    this.onSearchChanged,
    this.onSubmitted,
    this.initialQuery,
  });

  final bool showMapButton;
  final VoidCallback? onFilterTap;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSubmitted;
  final String? initialQuery;

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 12.height,
      ),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              isWithTitle: false,
              controller: _controller,
              textInputAction: TextInputAction.search,
              prefixIconPadding: const EdgeInsetsDirectional.fromSTEB(
                18,
                14,
                4,
                14,
              ),
              prefixImage: AppImages.searchIcon,
              hint: AppStrings.searchProperty,
              suffixImage: AppImages.filterImage,
              suffixIconPadding: const EdgeInsetsDirectional.fromSTEB(
                8,
                14,
                14,
                14,
              ),
              onTapSuffixIcon: widget.onFilterTap,
              onChanged: widget.onSearchChanged,
              onSubmitted: widget.onSubmitted,
            ),
          ),
          SizedBox(width: 8.width),
          if (widget.showMapButton)
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                RouterHandler.navigate(
                  context,
                  AppRouterKeys.propertyLocationMap,
                );
              },
              child: Container(
                padding: EdgeInsets.all(14.width),
                decoration: BoxDecoration(
                  color: AppThemeColors.of(context).primaryBrand,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.5.width,
                    color: AppThemeColors.of(context).borderColor,
                  ),
                ),
                child: Icon(
                  Icons.map_outlined,
                  color: AppThemeColors.of(context).onPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
