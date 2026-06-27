part of '../sign_in_screen.dart';

class SignInAction extends StatelessWidget {
  const SignInAction({super.key});

  @override
  Widget build(BuildContext context) {
    final accountType = PreferenceUtils().getString(StorageKeys.accountType);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 10.height,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                return AppButton(
                  // isLoading: state.signInStatus == RequestStatus.loading,
                  text: AppStrings.signIn,
                  onTap: () {
                       if (PreferenceUtils().getString(StorageKeys.accountType) ==
                  AppConstant.developer) {
                RouterHandler.navigate(
                  context,
                  AppRouterKeys.projectManagerHome,
                  routerType: RouterType.goName,
                );
              } else {
                RouterHandler.navigate(
                  context,
                  AppRouterKeys.navbar,
                  routerType: RouterType.goName,
                );
              }
                    // SignInBloc.get(context).add(const SignInActionEvent());
                    // if (accountType == AppConstant.developer) {
                    //   RouterHandler.navigate(
                    //     context,
                    //     AppRouterKeys.realEstateDevelopmentList,
                    //     routerType: RouterType.goName,
                    //   );
                    // } else {
                    //   RouterHandler.navigate(
                    //     context,
                    //     AppRouterKeys.navbar,
                    //     routerType: RouterType.goName,
                    //   );
                    // }
                  },
                  width: 560.width,
                );
              },
            ),
            if (accountType != AppConstant.developer) ...[
              SizedBox(height: 16.height),
              Text.rich(
                TextSpan(
                  text: AppStrings.dontHaveAccount,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    color: AppThemeColors.of(context).textSecondary,
                  ),
                  children: [
                    TextSpan(
                      text: AppStrings.signUp,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
                        color: AppThemeColors.of(context).textPrimary,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          RouterHandler.navigate(context, AppRouterKeys.signUp);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
