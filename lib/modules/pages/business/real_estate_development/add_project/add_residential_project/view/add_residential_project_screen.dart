import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_appbar.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/components/app_textfield.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../auth/common/password_item.dart';
import '../../shared/widgets/file_upload_widget.dart';
import '../../shared/widgets/link_sent_success_dialog.dart';
import '../../shared/widgets/project_manager_login_dialog.dart';
import '../../shared/widgets/project_phases_checklist_widget.dart';
import '../controller/add_residential_project_bloc.dart';

List<ProjectPhaseEntry> _residentialPhases() => [
  ProjectPhaseEntry(
    title: AppStrings.resPhase1Title,
    subtitle: AppStrings.resPhase1Subtitle,
    tasks: [
      AppStrings.resPhase1Item1,
      AppStrings.resPhase1Item2,
      AppStrings.resPhase1Item3,
      AppStrings.resPhase1Item4,
      AppStrings.resPhase1Item5,
      AppStrings.resPhase1Item6,
      AppStrings.resPhase1Item7,
    ],
  ),
  ProjectPhaseEntry(
    title: AppStrings.resPhase2Title,
    subtitle: AppStrings.resPhase2Subtitle,
  ),
  ProjectPhaseEntry(
    title: AppStrings.resPhase3Title,
    subtitle: AppStrings.resPhase3Subtitle,
  ),
  ProjectPhaseEntry(
    title: AppStrings.resPhase4Title,
    subtitle: AppStrings.resPhase4Subtitle,
  ),
  ProjectPhaseEntry(
    title: AppStrings.resPhase5Title,
    subtitle: AppStrings.resPhase5Subtitle,
  ),
];

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

  // Future<void> _handleManagerLoginDialog(BuildContext context) async {
  //   final bloc = context.read<AddResidentialProjectBloc>();
  //   final result = await showDialog<bool>(
  //     context: context,
  //     builder: (_) => const ProjectManagerLoginDialog(),
  //   );
  //   bloc.add(AddResidentialManagerLoginResult(result ?? false));
  // }

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
          // _handleManagerLoginDialog(context);
        }
         else if (state.dialogAction == ResidentialDialogAction.showSuccess) {
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
                    AppTextField(
                      isWithTitle: true,
                      title: AppStrings.propertyName,
                      hint: AppStrings.propertyNameHint,
                      controller: bloc.nameController,
                      textInputType: TextInputType.text,
                    ),
                    AppTextField(
                      isWithTitle: true,
                      title: AppStrings.locationLabel,
                      hint: AppStrings.locationFieldHint,
                      controller: bloc.locationController,
                      textInputType: TextInputType.text,
                      suffixImage: AppImages.locationIcon,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            title: AppStrings.startDateLabel,
                            hint: 'MM/YY',
                            controller: bloc.startDateController,
                            isReadOnly: true,
                            onTapField: () => bloc.add(
                              const AddResidentialPickDateRequested(
                                ResidentialDateField.start,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.width),
                        Expanded(
                          child: AppTextField(
                            title: AppStrings.expectedEndDateLabel,
                            hint: 'MM/YY',
                            controller: bloc.endDateController,
                            isReadOnly: true,
                            onTapField: () => bloc.add(
                              const AddResidentialPickDateRequested(
                                ResidentialDateField.end,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppTextField(
                      isWithTitle: true,
                      title: AppStrings.totalBudgetLabel,
                      hint: AppStrings.priceFieldHint,
                      controller: bloc.budgetController,
                      textInputType: TextInputType.number,
                      suffixImage: AppImages.rentIcon,
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 40.width,
                        minHeight: 44.width,
                      ),
                    ),
                    ProjectPhasesChecklistWidget(
                      label: AppStrings.mainPhasesLabel,
                      subtitle: AppStrings.startFromAnyPhase,
                      phases: _residentialPhases(),
                    ),
                    FileUploadWidget(
                      title: AppStrings.images,
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
                        phoneController: bloc.phoneController,
                        colors: colors,
                      ),
                      SizedBox(height: 12.height),
                      AppButton(
                        text: AppStrings.chooseProjectManager,
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
    required this.phoneController,
    required this.colors,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          title: AppStrings.usernameLabel,
          hint: AppStrings.usernameLabel,
          controller: usernameController,
          textInputType: TextInputType.text,
        ),
        PasswordItem(
          title: AppStrings.password,
          hint: AppStrings.password,
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
          title: AppStrings.managerPhoneLabel,
          hint: AppStrings.enterPhoneHint,
          controller: phoneController,
          textInputType: TextInputType.phone,
        ),
      ],
    );
  }
}
