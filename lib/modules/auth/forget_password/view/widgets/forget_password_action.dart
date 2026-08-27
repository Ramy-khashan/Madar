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
            BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
              builder: (context, state) {
                return AppButton(
                  text: AppStrings.confirm,
                  isLoading: state.sendStatus == RequestStatus.loading,
                  onTap: () => ForgetPasswordBloc.get(
                    context,
                  ).add(const ForgetPasswordSendOtp()),
                  width: 560.width,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
