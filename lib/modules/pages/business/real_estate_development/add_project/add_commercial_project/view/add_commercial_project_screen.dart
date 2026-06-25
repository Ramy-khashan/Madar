import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_appbar.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/components/app_drop_down.dart';
import '../../../../../../../core/components/app_textfield.dart';
import '../../../../../../../core/components/property_type_item.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../shared/widgets/file_upload_widget.dart';
import '../../shared/widgets/link_sent_success_dialog.dart';
import '../../shared/widgets/project_manager_login_dialog.dart';
import '../controller/add_commercial_project_bloc.dart';

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
                   
                    PropertyTypeSection(
                     
                      selectedItem: state.selectedPropertyType,
                      onTap: (t) => bloc
                          .add(AddCommercialPropertyTypeChanged(t)),
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
                    AppDropDownItem(
                      title: AppStrings.areaTypeLabel,
                      value: state.selectedAreaType,
                      items:[],
                      hintText: AppStrings.chooseAreaType,
                       onChanged: (v) =>
                          bloc.add(AddCommercialAreaTypeChanged(v)) ,
                     
                    ),
                    AppTextField(
                      title: AppStrings.unitsCountLabel,
                      hint: '5',
                      controller: bloc.unitsController,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    AppTextField(
                      title: AppStrings.parkingLabel,
                      hint: '5',
                      controller: bloc.parkingController,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    AppTextField(
                      title: AppStrings.approximateBudgetLabel,
                      hint: AppStrings.priceFieldHint,
                      controller: bloc.budgetController,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      prefixIconWidget: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.width),
                        child: Text(
                          '\$',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(18),
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
                    AppTextField(
                      title: AppStrings.startDateLabel,
                      hint: '12/12/2020',
                      controller: bloc.startDateController,
                      isReadOnly: true,
                      onTapField: () => bloc.add(
                        const AddCommercialPickDateRequested(
                          CommercialDateField.start,
                        ),
                      ),
                    ),
                    AppTextField(
                      title: AppStrings.expectedEndDateLabel,
                      hint: '12/12/2020',
                      controller: bloc.endDateController,
                      isReadOnly: true,
                      onTapField: () => bloc.add(
                        const AddCommercialPickDateRequested(
                          CommercialDateField.end,
                        ),
                      ),
                    ),
                    AppTextField(
                      title: AppStrings.mainTenantsActivitiesLabel,
                      hint: AppStrings.mainTenantsActivitiesHint,
                      controller: bloc.tenantsController,
                      maxLines: 4,
                      textInputAction: TextInputAction.newline,
                      textInputType: TextInputType.multiline,
                    ),
                    FileUploadWidget(
                      title: AppStrings.otherAttachmentsOptional,
                      onTap: () {},
                    ),
                    SizedBox(height: 20.height),
                    AppButton(
                      text: AppStrings.chooseProjectManager,
                      isOutline: true,
                      height: 52,
                      onTap: () => bloc.add(
                        const AddCommercialSendToManagerRequested(),
                      ),
                    ),
                    SizedBox(height: 12.height),
                    AppButton(
                      text: AppStrings.confirmAddProperty,
                      height: 52,
                      isLoading:
                          state.submitStatus == RequestStatus.loading,
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
