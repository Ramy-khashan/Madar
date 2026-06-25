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
import '../controller/add_commercial_project_bloc.dart';

const _commercialPhases = [
  ProjectPhaseEntry(
    title: 'المرحلة الأولى: التخطيط والترخيص التجاري',
    subtitle: 'استخراج رخصة البناء التجاري',
    tasks: [
      'اعداد المخططات الهندسية',
      'اعتماد المخططات الانشائية',
      'اعداد مخططات الكهرباء والتكييف',
      'فتح قسم تجاري',
      'التعاقد مع شركة إشراف هندسي',
    ],
  ),
  ProjectPhaseEntry(
    title: 'المرحلة الثانية: الاعمال الاساسية',
    subtitle: 'تمهيد الأرض وإنشاء الأساسات',
  ),
  ProjectPhaseEntry(
    title: 'المرحلة الثالثة: الاعمال الانشائية',
    subtitle: 'تنفيذ الهيكل الخرساني والجدران',
  ),
  ProjectPhaseEntry(
    title: 'المرحلة الرابعة: التشطيبات والتجهيزات',
    subtitle: 'أعمال التشطيب الداخلي والخارجي',
  ),
  ProjectPhaseEntry(
    title: 'المرحلة الخامسة: التسليم والتشغيل',
    subtitle: 'اختبار الأنظمة وتجهيز المشروع',
  ),
  ProjectPhaseEntry(
    title: 'المرحلة السادسة: الفحص والتسليم',
    subtitle: 'الفحوصات النهائية والتسليم الرسمي',
  ),
];

class AddCommercialProjectScreen extends StatelessWidget {
  const AddCommercialProjectScreen({super.key});

  Future<void> _handleDatePick(
    BuildContext context,
    CommercialDateField field,
  ) async {
    final bloc = context.read<AddCommercialProjectBloc>();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      bloc.add(
        AddCommercialDatePicked(
          field,
          '${picked.day}/${picked.month}/${picked.year}',
        ),
      );
    } else {
      bloc.add(const AddCommercialDatePickCancelled());
    }
  }

  Future<void> _handleManagerLoginDialog(BuildContext context) async {
    final bloc = context.read<AddCommercialProjectBloc>();
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => const ProjectManagerLoginDialog(),
    );
    bloc.add(AddCommercialManagerLoginResult(result ?? false));
  }

  Future<void> _handleSuccessDialog(BuildContext context) async {
    final bloc = context.read<AddCommercialProjectBloc>();
    await showDialog<void>(
      context: context,
      builder: (_) => const LinkSentSuccessDialog(),
    );
    bloc.add(const AddCommercialSuccessDialogDismissed());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCommercialProjectBloc, AddCommercialProjectState>(
      listenWhen: (prev, curr) =>
          prev.pendingDateField != curr.pendingDateField ||
          prev.dialogAction != curr.dialogAction ||
          prev.submitStatus != curr.submitStatus,
      listener: (context, state) {
        if (state.pendingDateField != CommercialDateField.none) {
          _handleDatePick(context, state.pendingDateField);
        }
        if (state.dialogAction == CommercialDialogAction.showManagerLogin) {
          _handleManagerLoginDialog(context);
        } else if (state.dialogAction == CommercialDialogAction.showSuccess) {
          _handleSuccessDialog(context);
        }
        if (state.submitStatus == RequestStatus.success) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final bloc = context.read<AddCommercialProjectBloc>();
        final colors = AppThemeColors.of(context);

        return Scaffold(
          backgroundColor: colors.backgroundPrimary,
          appBar: AppAppbar(title: AppStrings.addCommercialProjectTitle),
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
                              const AddCommercialPickDateRequested(
                                CommercialDateField.start,
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
                              const AddCommercialPickDateRequested(
                                CommercialDateField.end,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppTextField(
                      isWithTitle: true,
                      title: AppStrings.approximateBudgetLabel,
                      hint: AppStrings.priceFieldHint,
                      controller: bloc.budgetController,
                      textInputType: TextInputType.number,
                      prefixIconWidget: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.width),
                        child: Text(
                          'ر.س',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            color: colors.textSecondary,
                            fontFamily: AppConstant.appFont,
                          ),
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 40.width,
                        minHeight: 44.width,
                      ),
                    ),
                    ProjectPhasesChecklistWidget(
                      label: AppStrings.mainPhasesLabel,
                      subtitle: 'يمكنك بدء البناء من أي مرحلة تريدها',
                      phases: _commercialPhases,
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
                        onTap: () => bloc.add(
                          const AddCommercialManagerToggled(true),
                        ),
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
                          const AddCommercialSendToManagerRequested(),
                        ),
                      ),
                    ],
                    SizedBox(height: 12.height),
                    AppButton(
                      text: AppStrings.confirmAddProperty,
                      height: 52,
                      isLoading: state.submitStatus == RequestStatus.loading,
                      onTap: () => bloc.add(const AddCommercialSubmit()),
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
