import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../../../business/business_home/model/business_portfolio_property_model.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/property_enums.dart';

class ParentBuildingPicker extends StatelessWidget {
  const ParentBuildingPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.propertyType != curr.model.propertyType ||
          prev.model.propertyParentId != curr.model.propertyParentId ||
          prev.model.propertyParentTitle != curr.model.propertyParentTitle ||
          prev.parentCandidatesStatus != curr.parentCandidatesStatus ||
          prev.parentCandidates != curr.parentCandidates,
      builder: (context, state) {
        if (state.model.propertyType != PropertyApiEnums.typeApartment) {
          return const SizedBox.shrink();
        }
        final tc = AppThemeColors.of(context);
        final selectedTitle = state.model.propertyParentTitle;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppStrings.selectParentBuilding,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w700,
                color: tc.textPrimary,
              ),
            ),
            SizedBox(height: 4.height),
            Text(
              AppStrings.selectParentBuildingHint,
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                color: tc.textSecondary,
              ),
            ),
            SizedBox(height: 10.height),
            InkWell(
              onTap: () => _openSheet(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.width,
                  vertical: 14.height,
                ),
                decoration: BoxDecoration(
                  color: tc.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: tc.borderColor),
                ),
                child: Row(
                  children: [
                    ImageItem(
                      AppImages.building,
                      color: tc.primaryBrand,
                      width: 22.width,
                      height: 22.width,
                    ),
                    SizedBox(width: 12.width),
                    Expanded(
                      child: Text(
                        selectedTitle.isNotEmpty
                            ? selectedTitle
                            : AppStrings.selectParentBuilding,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: selectedTitle.isNotEmpty
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: selectedTitle.isNotEmpty
                              ? tc.textPrimary
                              : tc.textSecondary,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: tc.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
            if (state.model.hasParentProperty)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  onPressed: () => AddPropertyBloc.get(
                    context,
                  ).add(const ClearParentPropertyEvent()),
                  child: Text(AppStrings.clearParentSelection),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _openSheet(BuildContext context) async {
    final bloc = AddPropertyBloc.get(context);
    if (bloc.state.parentCandidatesStatus != RequestStatus.success &&
        bloc.state.parentCandidatesStatus != RequestStatus.loading) {
      bloc.add(const LoadParentCandidatesEvent());
    }
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: const _ParentCandidatesSheet(),
      ),
    );
  }
}

class _ParentCandidatesSheet extends StatelessWidget {
  const _ParentCandidatesSheet();

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      decoration: BoxDecoration(
        color: tc.backgroundPrimary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(16.width, 12.height, 16.width, 24.height),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: tc.borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 16.height),
          Text(
            AppStrings.selectParentBuilding,
            style: TextStyle(
              fontSize: context.responsiveFontScale(18),
              fontWeight: FontWeight.w700,
              color: tc.textPrimary,
            ),
          ),
          SizedBox(height: 12.height),
          Flexible(
            child: BlocBuilder<AddPropertyBloc, AddPropertyState>(
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
                    padding: EdgeInsets.symmetric(vertical: 32.height),
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
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.parentCandidates.length,
                  separatorBuilder: (_, _) => SizedBox(height: 8.height),
                  itemBuilder: (context, index) {
                    final item = state.parentCandidates[index];
                    return _ParentCandidateTile(
                      item: item,
                      isSelected: item.id == state.model.propertyParentId,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ParentCandidateTile extends StatelessWidget {
  const _ParentCandidateTile({required this.item, required this.isSelected});

  final MyPropertiesModel item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return InkWell(
      onTap: () {
        AddPropertyBloc.get(context).add(
          SelectParentPropertyEvent(id: item.id, title: item.title),
        );
        RouterHandler.pop(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 14.height,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? tc.primaryBrand.withValues(alpha: 0.08)
              : tc.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? tc.primaryBrand : tc.borderColor,
          ),
        ),
        child: Row(
          children: [
            ImageItem(
              item.type.toUpperCase() == PropertyApiEnums.typeTower
                  ? AppImages.tower
                  : AppImages.building,
              color: tc.primaryBrand,
              width: 22.width,
              height: 22.width,
            ),
            SizedBox(width: 12.width),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontWeight: FontWeight.w600,
                      color: tc.textPrimary,
                    ),
                  ),
                  if (item.location.isNotEmpty)
                    Text(
                      item.location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(12),
                        color: tc.textSecondary,
                      ),
                    ),
                  Text(
                    item.type.transIfExists,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      fontWeight: FontWeight.w600,
                      color: tc.primaryBrand,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: tc.primaryBrand, size: 20),
          ],
        ),
      ),
    );
  }
}
