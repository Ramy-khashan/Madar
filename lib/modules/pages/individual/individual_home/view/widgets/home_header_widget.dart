import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key, required this.userLocation});

  final String userLocation;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 16.height),

      child: Row(
        children: [
          CircleAvatar(
            radius: 24.width,
            backgroundColor: colors.primaryBrand,
            child: Padding(
              padding: EdgeInsets.all(7.width),
              child: Icon(
                Icons.person_outline,
                 color: colors.onPrimary,
               ),
            ),
          ),
         SizedBox(width: 8.width),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.welcomeToMadar,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.textFieldTitle,
                  ),
                ),
                SizedBox(height: 4.height),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 20.width,
                      color: colors.primaryBrand,
                    ),
                    SizedBox(width: 8.width),

                    Text(
                      userLocation,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(12),
                        fontFamily: AppConstant.appHeaderFont,

                        color:AppColors.grey900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              RouterHandler.navigate(context, AppRouterKeys.notification);
            },
            icon: const Icon(CupertinoIcons.bell),
          ),
        ],
      ),
    );
  }
}
