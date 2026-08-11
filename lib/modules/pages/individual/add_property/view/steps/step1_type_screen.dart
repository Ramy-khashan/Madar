import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class AddPropertyStep1Screen extends StatelessWidget {
  const AddPropertyStep1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 8.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.propertyTypeAndOperation,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w700,
                    color: tc.textPrimary,
                  ),
                ),
                6.height.toSizedBox,
                Text(
                  AppStrings.startWithBasicsHint,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    fontWeight: FontWeight.w400,
                    color: tc.textSecondary,
                  ),
                ),
                12.height.toSizedBox,

                Text(
                  AppStrings.doYouWant,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w600,
                    color: tc.primaryBrand,
                  ),
                ),
                6.height.toSizedBox,

                const _OperationToggle(),

                const _PropertyTypeGrid(),
              ],
            ),
          ),
        ),
        _Step1NextButton(tc: tc),
      ],
    );
  }
}

class _OperationToggle extends StatelessWidget {
  const _OperationToggle();

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.operationType != curr.model.operationType,
      builder: (context, state) {
        final isSell = state.model.operationType == 'sell';
        return Container(
          margin: EdgeInsets.symmetric(vertical: 12.height),
          decoration: BoxDecoration(
            color: tc.borderColor.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              _ToggleOption(
                label: AppStrings.sellLabel,
                isActive: isSell,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const SelectOperationTypeEvent('sell')),
                tc: tc,
              ),
              _ToggleOption(
                label: AppStrings.rentLabel,
                isActive: !isSell,
                onTap: () => AddPropertyBloc.get(
                  context,
                ).add(const SelectOperationTypeEvent('rent')),
                tc: tc,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ToggleOption extends StatelessWidget {
  const _ToggleOption({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.tc,
  });
  final String label;
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
          height: 44,
          decoration: BoxDecoration(
            color: isActive ? tc.primaryBrand : Colors.transparent,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(15),
              fontWeight: FontWeight.w700,
              color: isActive ? tc.onPrimary : tc.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _PropertyTypeGrid extends StatelessWidget {
  const _PropertyTypeGrid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.propertyType != curr.model.propertyType,
      builder: (context, state) {
        final items = AddPropertyBloc.propertyTypeItems;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (context, i) {
            final item = items[i];
            return _PropertyTypeCard(
              id: item['id'] as String,
              label: item['label'] as String,
              icon: item['icon'] as String,
              isSelected: state.model.propertyType == item['id'],
              tc: AppThemeColors.of(context),
            );
          },
        );
      },
    );
  }
}

class _PropertyTypeCard extends StatelessWidget {
  const _PropertyTypeCard({
    required this.id,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.tc,
  });
  final String id;
  final String label;
  final String icon;
  final bool isSelected;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          AddPropertyBloc.get(context).add(SelectPropertyTypeEvent(id)),
      child: AnimatedContainer(
        padding: const EdgeInsets.all(12),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? tc.primaryBrand : tc.borderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.width,
              height: 40.width,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? tc.primaryBrand
                    : tc.textFieldHint.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ImageItem(
                icon,
                width: 24.width,
                color: isSelected ? tc.onPrimary : tc.primaryBrand,
              ),
            ),
            6.height.toSizedBox,
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.w600,
                color: isSelected ? tc.primaryBrand : tc.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Step1NextButton extends StatelessWidget {
  const _Step1NextButton({required this.tc});
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.propertyType != curr.model.propertyType,
      builder: (context, state) {
        final enabled = state.model.propertyType != null;
        return Padding(
          padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
          child: AppButton(
            text: AppStrings.next,
            onTap: enabled
                ? () => AddPropertyBloc.get(context).add(const NextStepEvent())
                : null,
            colorBG: enabled ? tc.primaryBrand : tc.borderColor,
            textColor: enabled ? tc.onPrimary : tc.textSecondary,
          ),
        );
      },
    );
  }
}

extension on num {
  SizedBox get toSizedBox => SizedBox(height: toDouble());
}
