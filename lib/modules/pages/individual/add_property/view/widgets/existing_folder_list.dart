import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../business/business_home/model/business_portfolio_property_model.dart';
import '../../controller/add_property_bloc.dart';

class ExistingFolderList extends StatelessWidget {
  const ExistingFolderList({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.parentCandidates != curr.parentCandidates ||
          prev.parentCandidatesStatus != curr.parentCandidatesStatus ||
          prev.model.propertyParentId != curr.model.propertyParentId,
      builder: (context, state) {
        if (state.parentCandidatesStatus == RequestStatus.loading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state.parentCandidates.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 24.height),
            child: Text(
              AppStrings.noParentBuildings,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                color: tc.textSecondary,
              ),
            ),
          );
        }
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 240.height),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: tc.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: tc.borderColor),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 4.height),
              itemCount: state.parentCandidates.length,
              separatorBuilder: (_, _) => Divider(
                height: 1,
                color: tc.borderColor,
              ),
              itemBuilder: (context, index) {
                final item = state.parentCandidates[index];
                return _FolderTile(
                  item: item,
                  isSelected: item.id == state.model.propertyParentId,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _FolderTile extends StatelessWidget {
  const _FolderTile({required this.item, required this.isSelected});

  final MyPropertiesModel item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    final subtitle = _subtitle(item);
    return InkWell(
      onTap: () {
        AddPropertyBloc.get(context).add(
          SelectParentPropertyEvent(id: item.id, title: item.title),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 14.height,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.width),
              decoration: BoxDecoration(
                color: tc.borderColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ImageItem(
                AppImages.apartment,
                color: tc.textSecondary,
                width: 18.width,
                height: 18.width,
              ),
            ),
            12.width.toSizedBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: tc.textPrimary,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        color: tc.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: isSelected ? tc.primaryBrand : tc.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  String _subtitle(MyPropertiesModel item) {
    final parts = <String>[];
    if (item.unitsCount > 0) {
      parts.add('${item.unitsCount} ${AppStrings.apartments}');
    }
    if (item.location.isNotEmpty) {
      parts.add(item.location);
    }
    return parts.join(' - ');
  }
}
