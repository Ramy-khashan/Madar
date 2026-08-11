import 'dart:io';

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
import '../../../../../../../core/utils/functions/image_picker_helper.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../auth/common/password_item.dart';
import '../../shared/widgets/file_upload_widget.dart';
import '../../shared/widgets/link_sent_success_dialog.dart';
import '../../shared/widgets/project_phases_checklist_widget.dart';
import '../controller/add_residential_project_bloc.dart';

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
          '${picked.year}-${picked.month}-${picked.day}',
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
          prev.submitStatus != curr.submitStatus ||
          prev.submitErrorMessage != curr.submitErrorMessage,
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
        if (state.submitErrorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.submitErrorMessage!),
              backgroundColor: Colors.red,
            ),
          );
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
                      stages: state.stages,
                      isLoading: state.stagesFetchStatus == RequestStatus.loading,
                      selectedStageIds: state.selectedStageIds,
                      selectedSubStageIds: state.selectedSubStageIds,
                      onStageToggled: (stageId) =>
                          bloc.add(AddResidentialStageToggled(stageId)),
                      onSubStageToggled: (stageId, subStageId) => bloc.add(
                        AddResidentialSubStageToggled(stageId, subStageId),
                      ),
                    ),
                    FileUploadWidget(
                      title: AppStrings.images,
                      onTap: () async {
                        final paths = await pickImages();
                        if (paths != null && paths.isNotEmpty) {
                          bloc.add(AddResidentialImagesSelected(paths));
                        }
                      },
                    ),
                    if (state.selectedImages.isNotEmpty) ...[
                      SizedBox(height: 12.height),
                      SizedBox(
                        height: 100.height,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.selectedImages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 8.width),
                              width: 100.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.radius),
                                border: Border.all(color: colors.borderColor),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(8.radius),
                                    child: Image.file(
                                      File(state.selectedImages[index]),
                                      width: 100.width,
                                      height: 100.height,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () => bloc.add(
                                        AddResidentialImageRemoved(index),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(4.width),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          size: 16.width,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
