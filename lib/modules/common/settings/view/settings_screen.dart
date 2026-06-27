import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/is_scrollable_widget.dart';
import '../../../../../core/components/responsive_row_column.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../config/router/app_router_keys.dart';
import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/image_item.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_images.dart';
import '../../../../core/utils/constants/storage_keys.dart';
import '../../../../core/utils/functions/preference_utils.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../controller/settings_bloc.dart';
import 'widgets/business_subscription_item.dart';
import 'widgets/change_account_item.dart';
import 'widgets/general_settings_section_widget.dart';
import 'widgets/language_bottom_sheet_widget.dart';
import 'widgets/logout_button_widget.dart';
import 'widgets/logout_dialog.dart';
import 'widgets/personal_info_section_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppAppbar(isWithBack: false, title: AppStrings.account),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return IsScrollableWidget(
                    isScroll: !isTablet,
                    padding: EdgeInsets.only(bottom: 24.height),
                    child: ResponsiveRowColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      isTablet: isTablet,
                      children: [
                        Expanded(
                          flex: isTablet ? 1 : 0,
                          child: IsScrollableWidget(
                            isScroll: isTablet,
                            padding: EdgeInsets.zero,
                            child: Padding(
                              padding: EdgeInsets.all(16.width),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Center(
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsetsDirectional.only(
                                            bottom: 16.height,
                                          ),
                                          width: 120.width,
                                          height: 120.width,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: ImageItem(
                                            AppImages.botIntroImage,

                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        PositionedDirectional(
                                          bottom: 12.height,
                                          start: 0,
                                          child: IconButton(
                                            style: IconButton.styleFrom(
                                              backgroundColor:
                                                  AppThemeColors.of(
                                                    context,
                                                  ).primaryBrand,
                                              shape: const CircleBorder(),
                                            ),
                                            icon: Icon(
                                              Icons.edit,
                                              color: AppThemeColors.of(
                                                context,
                                              ).onPrimary,
                                              size: 16.width,
                                            ),
                                            onPressed: () {
                                              // Handle edit button press
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PersonalInfoSectionWidget(
                                    profile: state.profile,
                                    onEditName: () {},
                                    onEditPhone: () {},
                                  ),
                                  if (PreferenceUtils().getString(
                                        StorageKeys.accountType,
                                      ) ==
                                      AppConstant.business)
                                    BusinessSubscriptionItem(onTap: () {}),
                                  Text(
                                    AppStrings.saved,
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(16),
                                      fontWeight: FontWeight.w700,
                                      color: AppThemeColors.of(
                                        context,
                                      ).textFieldTitle,
                                    ),
                                  ),
                                  SizedBox(height: 8.height),
                                  SettingsActionRow(
                                    image: AppImages.savedIcon,
                                    trailing: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                            end: 8.width,
                                          ),
                                          child: Text(
                                            "12",
                                            style: TextStyle(
                                              fontSize: context
                                                  .responsiveFontScale(14),
                                              fontWeight: FontWeight.w500,
                                              color: AppThemeColors.of(
                                                context,
                                              ).textFieldTitle,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16.width,
                                          color: AppThemeColors.of(
                                            context,
                                          ).textFieldTitle,
                                        ),
                                      ],
                                    ),
                                    label: AppStrings.saved,
                                    colors: AppThemeColors.of(context),
                                    onTap: () {
                                      RouterHandler.navigate(
                                        context,
                                        AppRouterKeys.myWishlist,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          flex: isTablet ? 1 : 0,
                          child: IsScrollableWidget(
                            isScroll: isTablet,
                            padding: EdgeInsets.zero,
                            child: Column(
                              children: [
                                GeneralSettingsSectionWidget(
                                  selectedLanguage: state.selectedLanguage,
                                  darkModeEnabled: state.darkModeEnabled,
                                  onDarkModeToggled: () => SettingsBloc.get(
                                    context,
                                  ).add(const SettingsDarkModeToggled()),
                                  notificationsEnabled:
                                      state.notificationsEnabled,
                                  onNotificationsToggled: () =>
                                      SettingsBloc.get(context).add(
                                        const SettingsNotificationsToggled(),
                                      ),
                                  onLanguageTap: () =>
                                      showLanguageBottomSheet(context),
                                  onTermsTap: () {
                                    RouterHandler.navigate(
                                      context,
                                      AppRouterKeys.termsAndConditionScreen,
                                    );
                                  },
                                  onHelpTap: () {
                                    RouterHandler.navigate(
                                      context,
                                      AppRouterKeys.supportAndHelpScreen,
                                    );
                                  },
                                ),
                                ChangeAccountItem(),
                                LogoutButtonWidget(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const LogoutDialog();
                                    },
                                  ),
                                ),

                                TextButton.icon(
                                  onPressed: () {
                                    RouterHandler.navigate(
                                      context,
                                      AppRouterKeys.deleteAccountScreen,
                                    );
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.trash,
                                    color: AppColors.errorColor,
                                  ),
                                  label: Text(
                                    AppStrings.deleteAccount,
                                    style: TextStyle(
                                      color: AppColors.errorColor,
                                      fontSize: context.responsiveFontScale(14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:   EdgeInsets.symmetric(horizontal: 16.width),
                                  child: Text(
                                    AppStrings.deleteAccountHint,
                                    style: TextStyle(
                                      color: AppThemeColors.of(
                                        context,
                                      ).textFieldTitle,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 22.height),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
