import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_model.dart';

class MediaPickerCard extends StatelessWidget {
  const MediaPickerCard({
    super.key,
    required this.label,
    required this.hint,
    required this.emptyHint,
    required this.icon,
    required this.pathSelector,
    required this.onPick,
    required this.onClear,
  });

  final String label;
  final String hint;
  final String emptyHint;
  final IconData icon;
  final String? Function(AddPropertyModel) pathSelector;
  final VoidCallback onPick;
  final VoidCallback onClear;

  String _fileName(String path) {
    final parts = path.split(RegExp(r'[/\\]'));
    return parts.isEmpty ? path : parts.last;
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          pathSelector(prev.model) != pathSelector(curr.model),
      builder: (context, state) {
        final path = pathSelector(state.model);
        final hasFile = path != null && path.isNotEmpty;
        return GestureDetector(
          onTap: onPick,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 12.height,
            ),
            decoration: BoxDecoration(
              color: tc.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasFile ? tc.primaryBrand : tc.borderColor,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: hasFile ? tc.primaryBrand : tc.textSecondary,
                  size: 28.width,
                ),
                6.height.toSizedBox,
                Text(
                  label,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontWeight: FontWeight.w600,
                    color: tc.primaryBrand,
                  ),
                ),
                8.height.toSizedBox,
                Text(
                  hasFile ? _fileName(path) : emptyHint,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    fontWeight: FontWeight.w500,
                    color: hasFile ? tc.textPrimary : tc.textFieldBorder,
                  ),
                ),
                4.height.toSizedBox,
                Text(
                  hasFile ? AppStrings.changeFile : hint,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(11),
                    color: tc.textSecondary,
                  ),
                ),
                if (hasFile) ...[
                  8.height.toSizedBox,
                  GestureDetector(
                    onTap: onClear,
                    child: Text(
                      AppStrings.removeFile,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(12),
                        fontWeight: FontWeight.w600,
                        color: AppColors.errorColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
