part of '../forget_password_screen.dart';

class ForgetPasswordAction extends StatelessWidget {
  const ForgetPasswordAction({super.key});

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
            AppButton(
              text: AppStrings.confirm,
              onTap: () {
                RouterHandler.navigate(context, AppRouterKeys.otpVerification, extra: '01120103010');
              },
              width: 560.width,
            ),
           
          ],
        ),
      ),
    );
  }
}
