import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_textfield.dart';
import '../../../../../core/components/image_item.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/image_picker_helper.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/validate.dart';
import '../../controller/sign_up_bloc.dart';

class BusinessValPart extends StatelessWidget {
  const BusinessValPart({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = SignUpBloc.get(context);
    final colors = AppThemeColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextField(
          title: AppStrings.valLicenseNumber,
          hint: AppStrings.enterValLicenseNumber,
          textInputType: TextInputType.text,
          isWithTitle: true,
          controller: bloc.falLicenseController,
          validator: (value) => Validate.notEmpty(value ?? ''),
        ),
        SizedBox(height: 12.height),
        Text(
          AppStrings.falLicenseFile,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            color: colors.textFieldTitle,
            fontFamily: AppConstant.appFont,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.height),
        BlocBuilder<SignUpBloc, SignUpState>(
          buildWhen: (prev, curr) =>
              prev.falLicenseFilePath != curr.falLicenseFilePath ||
              prev.autoValidateMode != curr.autoValidateMode,
          builder: (context, state) {
            final hasFile = state.falLicenseFilePath.isNotEmpty;
            final showError =
                !hasFile && state.autoValidateMode == AutovalidateMode.always;
            final fileName = hasFile
                ? state.falLicenseFilePath.split('/').last
                : AppStrings.clickToUploadAttachment;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    final path = await pickSingleImage();
                    if (path == null || path.isEmpty) return;
                    bloc.add(SignUpLicenseFilePicked(path));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.width,
                      vertical: 14.height,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.radius),
                      border: Border.all(
                        color: showError
                            ? AppColors.errorColor
                            : colors.textFieldBorder,
                      ),
                    ),
                    child: Row(
                      children: [
                        ImageItem(
                          AppImages.chooseDocumentIcon,
                          width: 22.width,
                          height: 22.width,
                          color: colors.primaryBrand,
                        ),
                        SizedBox(width: 10.width),
                        Expanded(
                          child: Text(
                            fileName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              color: hasFile
                                  ? colors.textFieldTitle
                                  : colors.textSecondary,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                        ),
                        if (hasFile)
                          GestureDetector(
                            onTap: () =>
                                bloc.add(const SignUpLicenseFileCleared()),
                            child: Icon(
                              Icons.close,
                              size: 18.width,
                              color: colors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (showError) ...[
                  SizedBox(height: 6.height),
                  Text(
                    AppStrings.pleaseAttachFalLicense,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      color: AppColors.errorColor,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
        SizedBox(height: 8.height),
      ],
    );
  }
}
