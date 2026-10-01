import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/router/app_router_keys.dart';
import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_images.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
import '../utils/functions/router_handler.dart';
import 'app_textfield.dart';
import 'search_query_cubit.dart';

class SearchItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchQueryCubit(initialQuery),
      child: BlocBuilder<SearchQueryCubit, int>(
        builder: (context, _) {
          final controller = context.read<SearchQueryCubit>().controller;
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
                    controller: controller,
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
                    onTapSuffixIcon: onFilterTap,
                    onChanged: onSearchChanged,
                    onSubmitted: onSubmitted,
                  ),
                ),
                SizedBox(width: 8.width),
                if (showMapButton)
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
        },
      ),
    );
  }
}
