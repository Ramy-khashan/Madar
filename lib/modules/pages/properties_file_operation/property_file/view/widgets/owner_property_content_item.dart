import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/is_scrollable_widget.dart';
import '../../../../../../core/components/responsive_row_column.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/constants/storage_keys.dart';
import '../../../../../../core/utils/functions/image_picker_helper.dart';
import '../../../../../../core/utils/functions/preference_utils.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../individual/my_property_details/view/widgets/contracts_section_widget.dart';
import '../../../../individual/my_property_details/view/widgets/related_services_section_widget.dart';
import '../../../../individual/property_details/view/widgets/features_part.dart';
import '../../../../individual/property_details/view/widgets/property_description_section_widget.dart';
import '../../../../individual/property_details/view/widgets/property_details_header_section_widget.dart';
import '../../../../individual/property_details/view/widgets/property_details_info_card_widget.dart';
import '../../../../individual/property_details/view/widgets/property_location_section_widget.dart';
import '../../controller/property_file_bloc.dart';
import '../../../unit_details/view/widgets/unit_info_row.dart';
import 'owner_financial_section.dart';
import 'owner_property_expenses.dart';
import 'owner_property_images.dart';

class OwnerPropertyContentItem extends StatelessWidget {
  const OwnerPropertyContentItem({
    super.key,
    required this.bloc,
    required this.state,
    required this.colors,
  });

  final PropertyFileBloc bloc;
  final PropertyFileState state;
  final AppThemeColors colors;

  bool get _canEdit =>
      PreferenceUtils().getString(StorageKeys.accountType) ==
      AppConstant.business;

  @override
  Widget build(BuildContext context) {
    final property = state.details;
    final isTablet = context.isTablet;
    final parentTitle = property?.parentProperty?.title ?? '';
    return IsScrollableWidget(
      isScroll: !isTablet,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 16.height,
      ),
      child: ResponsiveRowColumn(
        isTablet: isTablet,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: isTablet ? 1 : 0,
            child: IsScrollableWidget(
              isScroll: isTablet,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OwnerPropertyImages(property: property),
                  SizedBox(height: 16.height),
                  if (parentTitle.isNotEmpty) ...[
                    Text(
                      parentTitle,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        color: colors.textSecondary,
                        fontFamily: AppConstant.appFont,
                      ),
                    ),
                    SizedBox(height: 8.height),
                  ],
                  PropertyDetailsHeaderSectionWidget(property: property),
                  if (_canEdit) ...[
                    SizedBox(height: 16.height),
                    UnitInfoRow(
                      label: AppStrings.propertyName,
                      value: property?.title ?? bloc.titleController.text,
                      leadingImage: AppImages.propertyShapeIcon,
                      colors: colors,
                      controller: bloc.titleController,
                      isEditable: true,
                    ),
                    SizedBox(height: 10.height),
                    UnitInfoRow(
                      label: AppStrings.projectName,
                      value:
                          property?.projectName ??
                          bloc.projectNameController.text,
                      leadingImage: AppImages.propertyShapeIcon,
                      colors: colors,
                      controller: bloc.projectNameController,
                      isEditable: true,
                    ),
                  ],
                  if ((property?.description ?? '').trim().isNotEmpty) ...[
                    SizedBox(height: 16.height),
                    PropertyDescriptionSectionWidget(
                      description: property?.description,
                    ),
                  ],
                  SizedBox(height: 16.height),
                  PropertyDetailsInfoCardWidget(property: property),
                  SizedBox(height: 16.height),
                  PropertyFeaturesWidget(
                    features: property?.features?.features,
                  ),
                  SizedBox(height: 16.height),
                  PropertyLocationSectionWidget(property: property),
                ],
              ),
            ),
          ),
          Expanded(
            flex: isTablet ? 1 : 0,
            child: IsScrollableWidget(
              isScroll: isTablet,
              child: Column(
                children: [
                  SizedBox(height: isTablet ? 0 : 16.height),
                  ContractsSectionWidget(
                    contracts: property?.contracts ?? [],
                  ),
                  SizedBox(height: 16.height),
                  OwnerPropertyExpenses(
                    expenses: state.expenses,
                    fileCount: state.expenseFiles.length,
                    colors: colors,
                    canEdit: _canEdit,
                    descController: bloc.expenseDescController,
                    amountController: bloc.expenseAmountController,
                    onAdd: () => bloc.add(const PropertyFileExpenseAdded()),
                    onRemove: (i) => bloc.add(PropertyFileExpenseRemoved(i)),
                    onPickFiles: () async {
                      final files = await pickImages();
                      if (files == null || files.isEmpty) return;
                      bloc.add(PropertyFileExpenseFilesPicked(files));
                    },
                  ),
                  SizedBox(height: 16.height),
                  OwnerFinancialSection(property: property),
                  SizedBox(height: 16.height),
                  const RelatedServicesSectionWidget(),
                  if (_canEdit) ...[
                    SizedBox(height: 16.height),
                    AppButton(
                      onTap: () => bloc.add(const PropertyFileSaveChanges()),
                      text: AppStrings.saveChanges,
                      isLoading: state.saveStatus == RequestStatus.loading,
                    ),
                  ],
                  SizedBox(height: 24.height),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
