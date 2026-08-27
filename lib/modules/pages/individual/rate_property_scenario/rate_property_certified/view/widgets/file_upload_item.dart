import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/image_item.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../controller/rate_property_certified_bloc.dart';

class FileUploadItem extends StatelessWidget {
  const FileUploadItem({
    super.key,
    required this.label,
    required this.fileKey,
    required this.isRequired,
    required this.uploadedFile,
    required this.hasError,
    required this.colors,
  });

  final String label;
  final String fileKey;
  final bool isRequired;
  final dynamic uploadedFile;
  final bool hasError;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.w600,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
            if (isRequired)
              Text(
                ' * ',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: context.responsiveFontScale(16),
                ),
              ),
          ],
        ),
        SizedBox(height: 8.height),
        if (uploadedFile != null)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 12.height,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.radius),
              border: Border.all(color: colors.primaryBrand),
            ),
            child: Row(
              children: [
                ImageItem(AppImages.doneIcon, color: colors.primaryBrand),
                SizedBox(width: 8.width),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        uploadedFile.name ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          color: colors.textFieldTitle,
                          fontFamily: AppConstant.appFont,
                        ),
                      ),
                      Text(
                        '${uploadedFile.sizeKb.toInt()} KB',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(11),
                          color: colors.textSecondary,
                          fontFamily: AppConstant.appFont,
                        ),
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () => context.read<RatePropertyCertifiedBloc>().add(
                    RatePropertyCertifiedFileRemoved(fileKey),
                  ),
                  child: const Icon(Icons.close, color: AppColors.errorColor),
                ),
              ],
            ),
          )
        else
          GestureDetector(
            onTap: () => context.read<RatePropertyCertifiedBloc>().add(
              RatePropertyCertifiedFileAdded(
                fileKey: fileKey,
                fileName: 'analog-landscape-city-with-22',
                sizeKb: 16738,
              ),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.height),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.radius),
                border: Border.all(
                  color: hasError ? Colors.red : colors.borderColor,
                  width: hasError ? 1.5 : 1,
                ),
                color: hasError
                    ? Colors.red.withValues(alpha: 0.05)
                    : colors.cardBackground,
              ),
              child: Column(
                children: [
                  ImageItem(
                    AppImages.uploadIcon,
                    color: hasError ? Colors.red : colors.textSecondary,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.height),
                    child: Text(
                      AppStrings.ratePropertyUploadHint,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        fontWeight: FontWeight.w600,
                        color: hasError ? Colors.red : colors.textFieldTitle,
                        fontFamily: AppConstant.appFont,
                      ),
                    ),
                  ),
                  Text(
                    AppStrings.ratePropertyFileTypes,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(11),
                      color: colors.textSecondary,
                      fontFamily: AppConstant.appFont,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
