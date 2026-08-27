import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class PortfolioModeToggle extends StatelessWidget {
  const PortfolioModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.isNewFolder != curr.isNewFolder ||
          prev.hasPortfolioMode != curr.hasPortfolioMode ||
          prev.model.propertyType != curr.model.propertyType,
      builder: (context, state) {
        if (!state.model.isApartment) {
          return const SizedBox.shrink();
        }
        return Row(
          children: [
            _ModeOption(
              label: AppStrings.saveToExistingFile,
              image: AppImages.instrument,
              hint: AppStrings.addToExistingFileHint,
              isActive: state.hasPortfolioMode && !state.isNewFolder,
              onTap: () => AddPropertyBloc.get(
                context,
              ).add(const SelectPortfolioModeEvent(false)),
              tc: tc,
            ),
            12.width.toSizedBox,
            _ModeOption(
              label: AppStrings.saveAsNewFile,
              image: AppImages.addIcon,
              hint: AppStrings.createNewPropertyFile,
              isActive: state.hasPortfolioMode && state.isNewFolder,
              onTap: () => AddPropertyBloc.get(
                context,
              ).add(const SelectPortfolioModeEvent(true)),
              tc: tc,
            ),
          ],
        );
      },
    );
  }
}

class _ModeOption extends StatelessWidget {
  const _ModeOption({
    required this.label,
    required this.hint,
    required this.image,
    required this.isActive,
    required this.onTap,
    required this.tc,
  });
  final String label;
  final String hint;
  final String image;
  final bool isActive;
  final VoidCallback onTap;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12.height),
          decoration: BoxDecoration(
            color: isActive
                ? tc.primaryBrand.withValues(alpha: 0.1)
                : tc.cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? tc.primaryBrand : tc.borderColor,
              width: isActive ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.height),
                padding: EdgeInsets.all(12.width),
                decoration: BoxDecoration(
                  color: tc.primaryBrand.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ImageItem(image),
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? tc.primaryBrand : tc.textPrimary,
                ),
              ),
              6.height.toSizedBox,
              Text(
                hint,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  fontWeight: FontWeight.w500,
                  color: tc.textFieldTitle.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
