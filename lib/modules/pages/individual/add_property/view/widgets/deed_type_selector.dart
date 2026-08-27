import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class DeedTypeSelector extends StatelessWidget {
  const DeedTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) => prev.model.deedType != curr.model.deedType,
      builder: (context, state) {
        final deedTypes = AddPropertyBloc.deedTypes;
        return Column(
          spacing: 8,
          children: deedTypes.map((deed) {
            final isSelected = state.model.deedType == deed['id'];
            return GestureDetector(
              onTap: () => AddPropertyBloc.get(
                context,
              ).add(SelectDeedTypeEvent(deed['id']!)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.width,
                  vertical: 12.height,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? tc.primaryBrand : tc.borderColor,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40.width,
                      height: 40.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ImageItem(
                        deed['icon'] as String,
                        width: 40,
                        height: 40,
                      ),
                    ),
                    10.width.toSizedBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            deed['label']!,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(13),
                              fontWeight: FontWeight.w700,
                              color: tc.primaryBrand,
                            ),
                          ),
                          4.height.toSizedBox,
                          Text(
                            deed['hint']!,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(10),
                              fontWeight: FontWeight.w400,
                              color: tc.primaryBrand,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
