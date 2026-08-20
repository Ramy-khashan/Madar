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
import '../../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../../core/utils/functions/image_picker_helper.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/utils/functions/validate.dart';
import '../../shared/project_form_helpers.dart';
import '../../shared/widgets/file_upload_widget.dart';
import '../../shared/widgets/project_manager_fields.dart';
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
          ProjectFormHelpers.formatApiDate(picked),
        ),
      );
    } else {
      bloc.add(const AddResidentialDatePickCancelled());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddResidentialProjectBloc, AddResidentialProjectState>(
      listenWhen: (prev, curr) =>
          prev.pendingDateField != curr.pendingDateField,
      listener: (context, state) {
        if (state.pendingDateField != ResidentialDateField.none) {
          _handleDatePick(context, state.pendingDateField);
        }
      },
      child:
          BlocConsumer<AddResidentialProjectBloc, AddResidentialProjectState>(
            listenWhen: (prev, curr) => prev.submitStatus != curr.submitStatus,
            listener: (context, state) {
              if (state.submitStatus == RequestStatus.success) {
                Navigator.of(context).pop();
              } else if (state.submitStatus == RequestStatus.failed &&
                  (state.submitErrorMessage ?? '').isNotEmpty) {
                AppToast(state.submitErrorMessage!, isError: true);
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
                            validator: (value) =>
                                Validate.notEmpty(value ?? ''),
                          ),
                          AppTextField(
                            isWithTitle: true,
                            title: AppStrings.locationLabel,
                            hint: AppStrings.locationFieldHint,
                            controller: bloc.locationController,
                            textInputType: TextInputType.text,
                            suffixImage: AppImages.locationIcon,
                            validator: (value) =>
                                Validate.notEmpty(value ?? ''),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  title: AppStrings.startDateLabel,
                                  hint: 'yyyy-MM-dd',
                                  controller: bloc.startDateController,
                                  isReadOnly: true,
                                  validator: (value) =>
                                      Validate.notEmpty(value ?? ''),
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
                                  hint: 'yyyy-MM-dd',
                                  controller: bloc.endDateController,
                                  isReadOnly: true,
                                  validator: (value) =>
                                      Validate.notEmpty(value ?? ''),
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
                            validator: (value) =>
                                Validate.notEmpty(value ?? ''),
                            suffixImage: AppImages.rentIcon,
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 40.width,
                              minHeight: 44.width,
                            ),
                          ),
                          if (state.stagesFetchStatus == RequestStatus.failed)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 16.height,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    AppStrings.somethingWentWrong,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(14),
                                      color: colors.textSecondary,
                                      fontFamily: AppConstant.appFont,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => bloc.add(
                                      const AddResidentialFetchStages(),
                                    ),
                                    child: Text(AppStrings.retry),
                                  ),
                                ],
                              ),
                            )
                          else
                            ProjectPhasesChecklistWidget(
                              label: AppStrings.mainPhasesLabel,
                              subtitle: AppStrings.startFromAnyPhase,
                              stages: state.stages,
                              isLoading:
                                  state.stagesFetchStatus ==
                                  RequestStatus.loading,
                              selectedStageIds: state.selectedStageIds,
                              selectedSubStageIds: state.selectedSubStageIds,
                              customSubStages: state.customSubStages,
                              onStageToggled: (stageId) =>
                                  bloc.add(AddResidentialStageToggled(stageId)),
                              onSubStageToggled: (stageId, subStageId) =>
                                  bloc.add(
                                    AddResidentialSubStageToggled(
                                      stageId,
                                      subStageId,
                                    ),
                                  ),
                              onCustomSubStageAdded: (stageId, name) =>
                                  bloc.add(
                                    AddResidentialCustomSubStageAdded(
                                      stageId,
                                      name,
                                    ),
                                  ),
                              onCustomSubStageRemoved: (stageId, index) =>
                                  bloc.add(
                                    AddResidentialCustomSubStageRemoved(
                                      stageId,
                                      index,
                                    ),
                                  ),
                            ),
                          FileUploadWidget(
                            title: AppStrings.attachmentsSection,
                            isRequired: true,
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
                                      borderRadius: BorderRadius.circular(
                                        8.radius,
                                      ),
                                      border: Border.all(
                                        color: colors.borderColor,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8.radius,
                                          ),
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
                                              decoration: const BoxDecoration(
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
                          ProjectManagerFields(
                            nameController: bloc.usernameController,
                            passwordController: bloc.passwordController,
                            phoneController: bloc.phoneController,
                          ),
                          SizedBox(height: 12.height),
                          AppButton(
                            text: AppStrings.confirmAddProperty,
                            isLoading:
                                state.submitStatus == RequestStatus.loading,
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
          ),
    );
  }
}
