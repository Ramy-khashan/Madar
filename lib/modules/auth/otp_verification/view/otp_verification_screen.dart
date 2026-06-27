import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/components/app_button.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../controller/otp_verification_bloc.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String phoneNumber;
  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    final bloc = OtpVerificationBloc.get(context);

    final defaultTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: context.responsiveFontScale(22),
        fontWeight: FontWeight.w700,
        color: tc.textPrimary,
        fontFamily: AppConstant.appHeaderFont,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: tc.textFieldBorder),
        borderRadius: BorderRadius.circular(16),
        color: tc.textFieldFill,
      ),
    );

    final focusedTheme = defaultTheme.copyWith(
      decoration: defaultTheme.decoration!.copyWith(
        border: Border.all(color: tc.primaryBrand, width: 1.5),
      ),
    );

    return BlocListener<OtpVerificationBloc, OtpVerificationState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppAppbar(title: AppStrings.changePassword),
        body: Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: SizedBox(
              width: 560.width,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.width),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.height),

                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Container(
                        width: 48.width,
                        height: 48.width,
                        decoration: BoxDecoration(
                          color: tc.primaryBrand.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          Icons.phone_outlined,
                          color: tc.textPrimary,
                          size: 22,
                        ),
                      ),
                    ),

                    SizedBox(height: 24.height),

                    Text(
                      AppStrings.otpVerificationTitle,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(24),
                        fontWeight: FontWeight.w800,
                        color: tc.textPrimary,
                        fontFamily: AppConstant.appHeaderFont,
                      ),
                    ),

                    SizedBox(height: 10.height),

                    Text(
                      '${AppStrings.otpVerificationSubtitle}\n$phoneNumber',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        fontWeight: FontWeight.w400,
                        color: tc.textSecondary,
                        fontFamily: AppConstant.appFont,
                        height: 1.6,
                      ),
                    ),

                    SizedBox(height: 32.height),

                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: bloc.pinController,
                        length: 4,
                        defaultPinTheme: defaultTheme,
                        focusedPinTheme: focusedTheme,
                        keyboardType: TextInputType.number,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        onChanged: (pin) => bloc.add(OtpChangedEvent(pin)),
                        onCompleted: (_) => bloc.add(const OtpSubmittedEvent()),
                      ),
                    ),

                    SizedBox(height: 32.height),

                    BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
                      builder: (context, state) {
                        return AppButton(
                          text: AppStrings.confirm,
                          isLoading: state is OtpVerificationLoading,
                          onTap: () => bloc.add(const OtpSubmittedEvent()),
                        );
                      },
                    ),

                    SizedBox(height: 20.height),

                    BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
                      builder: (context, state) {
                        return Center(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                fontFamily: AppConstant.appFont,
                                color: tc.textSecondary,
                              ),
                              children: [
                                TextSpan(text: AppStrings.didNotReceiveCode),
                                TextSpan(
                                  text: state is OtpResendLoading
                                      ? '...'
                                      : AppStrings.resendCode,
                                  style: TextStyle(
                                    color: tc.primaryBrand,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = state is OtpResendLoading
                                        ? null
                                        : () =>
                                              bloc.add(const OtpResendEvent()),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
