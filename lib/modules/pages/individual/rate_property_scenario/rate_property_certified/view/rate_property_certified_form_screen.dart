import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_appbar.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../widgets/rate_property_form_item.dart';
import '../controller/rate_property_certified_bloc.dart';
import 'widgets/rate_property_certified_success_dialog.dart';

class RatePropertyCertifiedFormScreen extends StatelessWidget {
  final RatePropertyCertifiedBloc bloc;
  const RatePropertyCertifiedFormScreen({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocProvider.value(
      value: bloc,
      child:
          BlocConsumer<RatePropertyCertifiedBloc, RatePropertyCertifiedState>(
            listenWhen: (prev, curr) => prev.submitStatus != curr.submitStatus,
            listener: (ctx, state) {
              if (state.submitStatus == RequestStatus.success) {
                showDialog(
                  context: ctx,
                  builder: (_) => RatePropertyCertifiedSuccessDialog(
                    requestNumber: state.requestNumber,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: colors.backgroundPrimary,
                appBar: AppAppbar(title: AppStrings.ratePropertyCertifiedTitle),
                body: SafeArea(
                  child: Column(
                    children: [
                      StepperHeader(
                        currentStep: state.currentStep,
                        colors: colors,
                      ),
                      Expanded(
                        child: IndexedStack(
                          index: state.currentStep,
                          children: [
                            Step1PropertyData(colors: colors, state: state),
                            Step2Documents(colors: colors, state: state),
                            Step3Companies(colors: colors, state: state),
                          ],
                        ),
                      ),
                      StepFooter(state: state, colors: colors),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}

class StepperHeader extends StatelessWidget {
  const StepperHeader({
    super.key,
    required this.currentStep,
    required this.colors,
  });

  final int currentStep;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    final steps = [
      AppStrings.ratePropertyStep1,
      AppStrings.ratePropertyStep2,
      AppStrings.ratePropertyStep3,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 12.height,
      ),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            final stepIndex = i ~/ 2;
            return Expanded(
              child: Container(
                height: 2,
                color: stepIndex < currentStep
                    ? colors.primaryBrand
                    : colors.borderColor,
              ),
            );
          }
          final stepIndex = i ~/ 2;
          final isDone = stepIndex < currentStep;
          final isActive = stepIndex == currentStep;
          return Column(
            children: [
              Container(
                width: 24.width,
                height: 24.width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone || isActive
                      ? colors.primaryBrand
                      : colors.borderColor,
                ),
                child: isDone
                    ? Icon(Icons.check, color: colors.onPrimary, size: 14.width)
                    : Center(
                        child: Text(
                          '${stepIndex + 1}',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(11),
                            color: isActive
                                ? colors.onPrimary
                                : colors.textSecondary,
                            fontFamily: AppConstant.appFont,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 4.height),
              Text(
                steps[stepIndex],
                style: TextStyle(
                  fontSize: context.responsiveFontScale(10),
                  color: isActive || isDone
                      ? colors.primaryBrand
                      : colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class Step1PropertyData extends StatelessWidget {
  const Step1PropertyData({
    super.key,
    required this.colors,
    required this.state,
  });

  final AppThemeColors colors;
  final RatePropertyCertifiedState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 16.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            AppStrings.propertyType,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontWeight: FontWeight.w600,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
          SizedBox(height: 8.height),
          RatePropertyFormItem(
            ratePropertyArea: RatePropertyCertifiedBloc.get(
              context,
            ).areaController,
            propertyLocation: RatePropertyCertifiedBloc.get(
              context,
            ).locationController,
            propertyAge: state.propertyAge,
            finishingLevel: state.finishingLevel,
            purpose: state.purpose,
            onPropertyAgeChanged: (v) => context
                .read<RatePropertyCertifiedBloc>()
                .add(RatePropertyCertifiedFieldChanged(propertyAge: v)),
            onFinishingLevelChanged: (v) => context
                .read<RatePropertyCertifiedBloc>()
                .add(RatePropertyCertifiedFieldChanged(finishingLevel: v)),
            onPurposeChanged: (v) => context
                .read<RatePropertyCertifiedBloc>()
                .add(RatePropertyCertifiedFieldChanged(purpose: v)),
            selectedType: state.selectedType,

            onTapPropertyType: (String p1) {
              context.read<RatePropertyCertifiedBloc>().add(
                RatePropertyCertifiedTypeSelected(p1),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Step2Documents extends StatelessWidget {
  const Step2Documents({super.key, required this.colors, required this.state});

  final AppThemeColors colors;
  final RatePropertyCertifiedState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 16.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(14.width),
            decoration: BoxDecoration(
              color: colors.primaryBrand.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.radius),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.description_outlined,
                  color: Theme.brightnessOf(context) == Brightness.dark
                      ? colors.onPrimary
                      : colors.primaryBrand,
                  size: 20.width,
                ),
                SizedBox(width: 8.width),

                Expanded(
                  child: Text(
                    AppStrings.ratePropertyDocsNotice,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      color: Theme.brightnessOf(context) == Brightness.dark
                          ? colors.onPrimary
                          : colors.primaryBrand,
                      fontFamily: AppConstant.appFont,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.height),
          Text(
            AppStrings.ratePropertyRequiredDocsLabel,
            style: TextStyle(
              fontSize: context.responsiveFontScale(15),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
          SizedBox(height: 16.height),
          FileUploadItem(
            label: AppStrings.ratePropertyOwnershipDeed,
            fileKey: 'ownership_deed',
            isRequired: true,
            uploadedFile: state.ownershipDeedFile,
            hasError: false,
            colors: colors,
          ),
          SizedBox(height: 16.height),
          FileUploadItem(
            label: AppStrings.ratePropertyOwnerId,
            fileKey: 'owner_id',
            isRequired: true,
            uploadedFile: state.ownerIdFile,
            hasError: state.ownerIdError,
            colors: colors,
          ),
          if (state.ownerIdError)
            Padding(
              padding: EdgeInsets.only(top: 4.height),
              child: Text(
                AppStrings.ratePropertyOwnerIdError,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(12),
                  color: Colors.red,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ),
          SizedBox(height: 16.height),
          FileUploadItem(
            label: AppStrings.ratePropertyPropertyPlan,
            fileKey: 'property_plan',
            isRequired: false,
            uploadedFile: state.propertyPlanFile,
            hasError: false,
            colors: colors,
          ),
          SizedBox(height: 32.height),
        ],
      ),
    );
  }
}

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

class Step3Companies extends StatelessWidget {
  const Step3Companies({super.key, required this.colors, required this.state});

  final AppThemeColors colors;
  final RatePropertyCertifiedState state;

  @override
  Widget build(BuildContext context) {
    if (state.companiesStatus == RequestStatus.loading) {
      return Center(
        child: CircularProgressIndicator(color: colors.primaryBrand),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 16.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(14.width),
            decoration: BoxDecoration(
              color: colors.primaryBrand.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.radius),
              border: Border.all(
                color: colors.primaryBrand.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.shield,
                  color: colors.primaryBrand,
                  size: 20.width,
                ),
                SizedBox(width: 8.width),

                Expanded(
                  child: Text(
                    AppStrings.ratePropertyCompaniesNotice,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      color: colors.primaryBrand,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppConstant.appFont,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.height),
          ...List.generate(state.companies.length, (i) {
            final company = state.companies[i];
            final isSelected = state.selectedCompanyId == company.id;
            return Padding(
              padding: EdgeInsets.only(
                bottom: i == state.companies.length - 1 ? 0 : 12.height,
              ),
              child: GestureDetector(
                onTap: () => context.read<RatePropertyCertifiedBloc>().add(
                  RatePropertyCertifiedCompanySelected(company.id),
                ),
                child: Container(
                  height: 120.height,
                  padding: EdgeInsets.all(16.width),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.primaryBrand.withValues(alpha: 0.05)
                        : colors.cardBackground,
                    borderRadius: BorderRadius.circular(12.radius),
                    border: Border.all(
                      color: isSelected
                          ? colors.primaryBrand
                          : colors.borderColor,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              company.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(16),
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConstant.appHeaderFont,
                                color: colors.textFieldTitle,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.width,
                              vertical: 2.height,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primaryBrand.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.radius),
                            ),
                            child: Text(
                              AppStrings.ratePropertyCertifiedBadge,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(12),
                                color: colors.primaryBrand,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.height),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.rate,
                            size: 16.width,
                          ),

                          Text(
                            '${company.rating}',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              color: colors.textFieldTitle,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                          SizedBox(width: 4.width),

                          Text(
                            '(${company.reviewsCount}+ ${AppStrings.ratePropertyReviewsSuffix})',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              color: colors.textSecondary,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.height),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12.width,
                            color: colors.primaryBrand,
                          ),
                          SizedBox(width: 8.width),

                          Expanded(
                            child: Text(
                              '${company.workDays} ${AppStrings.ratePropertyWorkDaysSuffix}',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                color: colors.textSecondary,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                          ),
                           Text(
                            '${company.price.toInt()} ${AppStrings.currency}',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              color: AppColors.secondBrand,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: 32.height),
        ],
      ),
    );
  }
}

class StepFooter extends StatelessWidget {
  const StepFooter({super.key, required this.state, required this.colors});

  final RatePropertyCertifiedState state;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    final isLastStep = state.currentStep == 2;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 12.height,
      ),
      child: AppButton(
        text: isLastStep ? AppStrings.ratePropertySendBtn : AppStrings.next,
        isLoading: state.submitStatus == RequestStatus.loading,
        onTap: () {
          if (isLastStep) {
            context.read<RatePropertyCertifiedBloc>().add(
              const RatePropertyCertifiedSubmit(),
            );
          } else {
            if (state.currentStep == 1) {
              context.read<RatePropertyCertifiedBloc>().add(
                const RatePropertyCertifiedLoadCompanies(),
              );
            }
            context.read<RatePropertyCertifiedBloc>().add(
              const RatePropertyCertifiedNextStep(),
            );
          }
        },
      ),
    );
  }
}
