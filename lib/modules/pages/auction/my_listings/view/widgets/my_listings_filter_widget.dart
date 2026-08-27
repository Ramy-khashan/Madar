import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/my_listings_bloc.dart'; 
 

class MyListFilterTabBar extends StatelessWidget {
  const MyListFilterTabBar({super.key, required this.activeFilter});
  final String activeFilter;

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 48.height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveHorizontalPadding,
          vertical: 6.height,
        ),
        itemCount: MyListingsBloc.tabs.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.width),
        itemBuilder: (context, i) {
          final isActive = MyListingsBloc.tabs[i].id == activeFilter;
          final colors = AppThemeColors.of(context);
          return GestureDetector(
            onTap: () => context
                .read<MyListingsBloc>()
                .add(MyListingsFilterChanged(MyListingsBloc.tabs[i].id)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                  horizontal: 16.width, vertical: 6.height),
              decoration: BoxDecoration(
                color: isActive ? AppThemeColors.of(context).primaryBrand : colors.cardBackground,
                borderRadius: BorderRadius.circular(20.radius),
                border: Border.all(
                  color:
                      isActive ? AppThemeColors.of(context).primaryBrand : colors.textFieldBorder,
                ),
              ),
              child: Center(
                child: Text(
                  MyListingsBloc.tabs[i].title,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    fontFamily: AppConstant.appFont,
                    fontWeight:
                        isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isActive ? colors.onPrimary : colors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
