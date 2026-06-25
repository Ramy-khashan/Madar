import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router_keys.dart';
import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/image_item.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/constants/storage_keys.dart';
import '../../../../core/utils/functions/preference_utils.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../controller/choose_account_bloc.dart';
import '../model/account_model.dart';

part 'widgets/account_shape_card.dart';

class ChooseAccountScreen extends StatelessWidget {
  const ChooseAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.width,
            right: 16.width,
            top: 32.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.chooseAccountTitle,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(28),
                  fontWeight: FontWeight.w600,
                  fontFamily: AppConstant.appHeaderFont,
                  color: AppThemeColors.of(context).textPrimary,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.height, bottom: 32.height),
                child: Text(
                  AppStrings.selectRightOption,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    color: AppThemeColors.of(context).textSecondary,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<ChooseAccountBloc, ChooseAccountState>(
                  builder: (context, state) {
                    final selectedIndex = state is ChooseAccountInitial
                        ? state.selectedIndex
                        : 0;
                    final accounts = ChooseAccountBloc.accounts;
                    return ListView.separated(
                      itemCount: accounts.length,
                      separatorBuilder: (_, _) => SizedBox(height: 16.height),
                      itemBuilder: (context, index) {
                        final account = accounts[index];
                        return AccountShapeCard(
                          account: account,
                          isSelected: selectedIndex == index,
                          onTap: () async {
                            context.read<ChooseAccountBloc>().add(
                              SelectAccountEvent(index),
                            );
                            await PreferenceUtils()
                                .setString(
                                  StorageKeys.accountType,
                                  account.accountType,
                                )
                                .whenComplete(() {
                                  if (context.mounted) {
                                    RouterHandler.navigate(
                                      context,
                                      AppRouterKeys.signIn,
                                    );
                                  }
                                });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

