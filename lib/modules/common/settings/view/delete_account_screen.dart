import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/app_appbar.dart';
import '../../../../core/repository/apis/auth_apis.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/common_fun.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../../../../config/router/app_router_keys.dart';
import '../../../../config/theme/app_theme_colors.dart';
import '../controller/delete_account_cubit.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  Future<void> _confirmDelete(BuildContext context) async {
    final cubit = context.read<DeleteAccountCubit>();
    if (cubit.state.isDeleting) return;
    cubit.setDeleting(true);
    final reason = AuthApis.deleteAccountReasons[cubit.state.selectedReason];
    final result = await AuthApis.deleteAccount(reason: reason);
    if (!context.mounted) return;
    await result.fold(
      (error) async {
        cubit.setDeleting(false);
        AppToast(error, isError: true);
      },
      (_) async {
        await AuthApis.clearSession();
        if (!context.mounted) return;
        RouterHandler.navigate(
          context,
          AppRouterKeys.chooseAccount,
          routerType: RouterType.pushReplacementNamed,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeleteAccountCubit(),
      child: BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
        builder: (context, state) {
          final colors = AppThemeColors.of(context);

          final List<String> reasons = [
            AppStrings.deleteAccountReason1,
            AppStrings.deleteAccountReason2,
            AppStrings.deleteAccountReason3,
            AppStrings.deleteAccountReason4,
            AppStrings.deleteAccountReason5,
            AppStrings.deleteAccountReason6,
          ];

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppAppbar(
              isWithBack: true,
              title: AppStrings.deleteAccount,
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.width,
                        vertical: 24.height,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.deleteAccountReasonTitle,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              fontWeight: FontWeight.w600,
                              color: colors.textFieldTitle,
                            ),
                          ),
                          SizedBox(height: 16.height),
                          ...List.generate(reasons.length, (index) {
                            return RadioGroup(
                              groupValue: state.selectedReason,
                              onChanged: (int? value) {
                                if (value == null) return;
                                context.read<DeleteAccountCubit>().selectReason(
                                  value,
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 12.height),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: state.selectedReason == index
                                        ? AppColors.primary300
                                        : colors.borderColor,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: RadioListTile<int>(
                                  value: index,
                                  activeColor: AppColors.primary300,
                                  title: Text(
                                    reasons[index],
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(14),
                                      color: colors.textFieldTitle,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12.width,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      20.width,
                      0,
                      20.width,
                      24.height,
                    ),
                    child: ElevatedButton(
                      onPressed: state.isDeleting
                          ? null
                          : () => _confirmDelete(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary300,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: AppColors.primary300
                            .withValues(alpha: 0.6),
                        minimumSize: Size(double.infinity, 52.height),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: state.isDeleting
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              AppStrings.confirmDelete,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
