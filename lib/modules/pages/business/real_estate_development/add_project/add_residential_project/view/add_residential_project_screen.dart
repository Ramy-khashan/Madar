import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_appbar.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/components/app_textfield.dart';
import '../../../../../../../core/components/property_type_item.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../auth/common/password_item.dart';
import '../../shared/widgets/file_upload_widget.dart';
import '../../shared/widgets/link_sent_success_dialog.dart';
import '../../shared/widgets/project_manager_login_dialog.dart';
import '../controller/add_residential_project_bloc.dart';
import 'widgets/property_details_item.dart';

class AddResidentialProjectScreen extends StatelessWidget {
  const AddResidentialProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddResidentialProjectBloc(),
      child: const _AddResidentialProjectView(),
    );
  }
}

class _AddResidentialProjectView extends StatelessWidget {
  const _AddResidentialProjectView();

  Future<void> _handleDatePick(
    BuildContext context,
    ResidentialDateField field,
  ) async {
    final bloc = context.read<AddResidentialProjectBloc>();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      bloc.add(
        AddResidentialDatePicked(
          field,
          '${picked.day}/${picked.month}/${picked.year}',
        ),
      );
    } else {
      bloc.add(const AddResidentialDatePickCancelled());
    }
  }

  Future<void> _handleManagerLoginDialog(BuildContext context) async {
    final bloc = context.read<AddResidentialProjectBloc>();
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => const ProjectManagerLoginDialog(),
    );
    bloc.add(AddResidentialManagerLoginResult(result ?? false));
  }

  Future<void> _handleSuccessDialog(BuildContext context) async {
    final bloc = context.read<AddResidentialProjectBloc>();
    await showDialog<void>(
      context: context,
      builder: (_) => const LinkSentSuccessDialog(),
    );
    bloc.add(const AddResidentialSuccessDialogDismissed());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddResidentialProjectBloc, AddResidentialProjectState>(
      listenWhen: (prev, curr) =>
          prev.pendingDateField != curr.pendingDateField ||
          prev.dialogAction != curr.dialogAction ||
          prev.submitStatus != curr.submitStatus,
      listener: (context, state) {
        if (state.pendingDateField != ResidentialDateField.none) {
          _handleDatePick(context, state.pendingDateField);
        }
        if (state.dialogAction == ResidentialDialogAction.showManagerLogin) {
          _handleManagerLoginDialog(context);
        } else if (state.dialogAction == ResidentialDialogAction.showSuccess) {
          _handleSuccessDialog(context);
        }
        if (state.submitStatus == RequestStatus.success) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final bloc = context.read<AddResidentialProjectBloc>();
        final colors = AppThemeColors.of(context);

        return Scaffold(
          backgroundColor: colors.backgroundPrimary,
          appBar: AppAppbar(title: AppStrings.addResidentialProjectTitle),
          body: SafeArea(
            child: Form(
              key: bloc.formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.width,
                  vertical: 8.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PropertyTypeSection(
                      selectedItem: state.selectedPropertyType,
                      onTap: (t) =>
                          bloc.add(AddResidentialPropertyTypeChanged(t)),
                    ),
                    AppTextField(
                      isWithTitle: true,
                      title: AppStrings.propertyName,
                      hint: AppStrings.propertyNameHint,
                      textInputType: TextInputType.text,
                    ),
                    AppTextField(
                      isWithTitle: true,
                      title: AppStrings.locationLabel,
                      hint: AppStrings.locationFieldHint,
                      textInputType: TextInputType.text,
                      suffixImage: AppImages.locationIcon,
                    ),
                    AppTextField(
                      isWithTitle: true,
                      title: AppStrings.approximateBudgetLabel,
                      hint: AppStrings.priceFieldHint,
                      textInputType: TextInputType.text,
                      suffixImage: AppImages.rentIcon,
                      suffixIconColor: colors.textSecondary,
                    ),

                    AppTextField(
                      title: AppStrings.startDateLabel,
                      hint: '12/12/2020',
                      controller: bloc.startDateController,
                      isReadOnly: true,
                      onTapField: () => bloc.add(
                        const AddResidentialPickDateRequested(
                          ResidentialDateField.start,
                        ),
                      ),
                    ),
                    AppTextField(
                      title: AppStrings.expectedEndDateLabel,
                      hint: '12/12/2020',
                      controller: bloc.endDateController,
                      isReadOnly: true,
                      onTapField: () => bloc.add(
                        const AddResidentialPickDateRequested(
                          ResidentialDateField.end,
                        ),
                      ),
                    ),
                    SizedBox(height: 14.height),
                    PropertyDetailsItem(counterItems: bloc.counterItems),
                    AppTextField(
                      title: AppStrings.mainPhasesLabel,
                      hint: AppStrings.mainPhasesHint,
                      controller: bloc.phasesController,
                      maxLines: 4,
                      textInputAction: TextInputAction.newline,
                      textInputType: TextInputType.multiline,
                    ),
                    FileUploadWidget(
                      title: AppStrings.otherAttachmentsOptional,
                      onTap: () {},
                    ),
                    SizedBox(height: 20.height),
                    if (!state.showManagerForm)
                      AppButton(
                        text: AppStrings.chooseProjectManager,
                        isOutline: true,
                        height: 52,
                        onTap: () =>
                            bloc.add(const AddResidentialManagerToggled(true)),
                      ),
                    if (state.showManagerForm) ...[
                      _ManagerFormSection(
                        usernameController: bloc.usernameController,
                        passwordController: bloc.passwordController,
                        emailController: bloc.emailController,
                        phoneController: bloc.phoneController,

                        colors: colors,
                      ),
                      SizedBox(height: 12.height),
                      AppButton(
                        text: AppStrings.sendToProjectManager,
                        isOutline: true,
                        onTap: () => bloc.add(
                          const AddResidentialSendToManagerRequested(),
                        ),
                      ),
                    ],
                    SizedBox(height: 12.height),
                    AppButton(
                      text: AppStrings.confirmAddProperty,
                      isLoading: state.submitStatus == RequestStatus.loading,
                      onTap: () => bloc.add(const AddResidentialSubmit()),
                    ),
                    SizedBox(height: 24.height),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ManagerFormSection extends StatelessWidget {
  const _ManagerFormSection({
    required this.usernameController,
    required this.passwordController,
    required this.emailController,
    required this.phoneController,
    required this.colors,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          title: AppStrings.usernameLabel,
          hint: AppStrings.enterIdentityHint,
          controller: usernameController,
          textInputType: TextInputType.number,
        ),
        PasswordItem(
          title: AppStrings.password,
          hint: AppStrings.enterPassword,
          controller: passwordController,
        ),
        SizedBox(height: 10.height),
        Text(
          AppStrings.sendLinkToManagerDesc,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            color: colors.textFieldTitle,
            fontFamily: AppConstant.appFont,
          ),
        ),
        AppTextField(
          title: AppStrings.managerEmailLabel,
          hint: AppStrings.enterEmailHint,
          controller: emailController,
          textInputType: TextInputType.emailAddress,
        ),
        AppTextField(
          title: AppStrings.managerPhoneLabel,
          hint: AppStrings.enterPhoneHint,
          controller: phoneController,
          textInputType: TextInputType.phone,
        ),
      ],
    );
  }
}
