import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/image_item.dart';
import '../../../../../core/components/responsive_row_column.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../controller/smart_assistant_intro_bloc.dart';

part 'widgets/toggle_item.dart';

class SmartAssistantIntroScreen extends StatelessWidget {
  const SmartAssistantIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final isTablet = context.isTablet;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppThemeColors.of(context).textSecondary.withValues(alpha: 0.01),
              AppThemeColors.of(context).backgroundSecondary,
            ],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<SmartAssistantIntroBloc, SmartAssistantIntroState>(
            builder: (context, state) {
              final isMicMode = state is SmartAssistantIntroReady
                  ? state.isMicMode
                  : true;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.width,
                      right: 16.width,
                      top: 26.height,
                      bottom: 35.height,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).maybePop(),
                          child: Icon(
                            Icons.chevron_left_rounded,
                            size: 30.fontSize,
                            color: colors.textFieldTitle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            AppStrings.smartAssistant,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colors.textFieldTitle,
                              fontSize: context.responsiveFontScale(20),
                              fontWeight: FontWeight.w600,
                              fontFamily: AppConstant.appHeaderFont,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ResponsiveRowColumn(
                      isTablet: isTablet,
                      children: [
                        Expanded(
                          flex: isTablet ? 7 : 0,
                          child: Stack(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 20.height,
                                  ),
                                  child: const ImageItem(
                                    AppImages.botIntroImage,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                              ),
                              PositionedDirectional(
                                top: 60.height,
                                start: 20.width,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 16.width,
                                    vertical: 16.height,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.width,
                                    vertical: 12.height,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(149, 172, 255, 0.57),
                                        Color.fromRGBO(254, 213, 255, 0.37),
                                        Color(0xFFD0CAFF),
                                      ],
                                      stops: [0.0, 0.5079, 0.9792],
                                      begin: AlignmentDirectional.centerEnd,
                                      end: AlignmentDirectional.centerStart,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF3E62CB,
                                        ).withValues(alpha: 0.2),
                                        blurRadius: 8.radius,
                                        offset: Offset(0, 4.height),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${AppStrings.hi}Ramy',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: context.responsiveFontScale(16),
                                      fontFamily: AppConstant.appFont,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: isTablet ? 10 : 0,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  AppStrings.smartAssistantGreeting,
                                  style: TextStyle(
                                    color: colors.textFieldTitle,
                                    fontSize: context.responsiveFontScale(26),
                                    fontFamily: AppConstant.appHeaderFont,
                                  ),
                                ),
                                SizedBox(height: 36.height),
                                ModeToggle(
                                  isMicMode: isMicMode,
                                  onToggle: () => SmartAssistantIntroBloc.get(
                                    context,
                                  ).add(const SmartAssistantIntroModeToggled()),
                                ),
                                SizedBox(height: 18.height),
                                InkWell(
                                  onTap: () {
                                    RouterHandler.navigate(
                                      context,
                                      AppRouterKeys.smartAssistantChat,
                                    );
                                  },
                                  child: Text(
                                    isMicMode
                                        ? AppStrings.pressToTalk
                                        : AppStrings.typeYourMessage,
                                    style: TextStyle(
                                      color: colors.textSecondary,
                                      fontSize: context.responsiveFontScale(16),
                                      fontFamily: AppConstant.appFont,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
