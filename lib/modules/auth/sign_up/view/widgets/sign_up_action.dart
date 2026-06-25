part of '../sign_up_screen.dart';

class SignUpAction extends StatelessWidget {
  const SignUpAction({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 10.height,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return AppButton(
                  isLoading: state.signUpStatus == RequestStatus.loading,
                  text: AppStrings.signUp,
                  onTap: () {
                    SignUpBloc.get(context).add(SignUpActionEvent());
                  },
                  width: 560.width,
                );
              },
            ),
            SizedBox(height: 16.height),
            Text.rich(
              TextSpan(
                text: AppStrings.alreadyHaveAccount,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  color: AppThemeColors.of(context).textSecondary,
                ),
                children: [
                  TextSpan(
                    text: AppStrings.signIn,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(16),
                      color: AppThemeColors.of(context).textPrimary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        RouterHandler.pop(context);
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
