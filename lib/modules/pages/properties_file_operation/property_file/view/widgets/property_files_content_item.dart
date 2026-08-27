import 'package:flutter/material.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/constants/storage_keys.dart';
import '../../../../../../core/utils/functions/image_picker_helper.dart';
import '../../../../../../core/utils/functions/preference_utils.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../../individual/my_property_details/view/widgets/contracts_section_widget.dart';
import '../../../../individual/my_property_details/view/widgets/related_services_section_widget.dart';
import '../../controller/property_file_bloc.dart';
import '../../model/property_file_model.dart';
import 'owner_financial_section.dart';
import 'owner_property_expenses.dart';
import 'property_file_header_widget.dart';
import 'unit_card.dart';

class PropertyFileContentItem extends StatelessWidget {
  const PropertyFileContentItem({
    super.key,
    required this.property,
    required this.colors,
    required this.state,
    required this.bloc,
  });

  final PropertyFileModel? property;
  final AppThemeColors colors;
  final PropertyFileState state;
  final PropertyFileBloc bloc;

  bool get _canEdit =>
      PreferenceUtils().getString(StorageKeys.accountType) ==
      AppConstant.business;

  @override
  Widget build(BuildContext context) {
    final units = state.property?.units ?? [];
    final hasSold = units.any((u) => u.status == UnitStatus.sold);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.width, 16.height, 16.width, 0),
          sliver: SliverToBoxAdapter(
            child: PropertyFileHeaderWidget(
              property: property,
              colors: colors,
              onBookmarkTap: () => bloc.add(const PropertyFileToggleBookmark()),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.width, 20.height, 16.width, 8.height),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  AppStrings.apartments,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w700,
                    color: colors.textFieldTitle,
                  ),
                ),
                Text(
                  AppStrings.rentedFromTotal(
                    property?.rentedCount??0,
                    property?.totalUnits??0,
                  ),
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    color: colors.textSecondary,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8.0, end: 4),
                  child: CircleAvatar(
                    radius: 4.width,
                    backgroundColor: AppColors.lightSuccessColor,
                  ),
                ),
                Text(
                  AppStrings.rentedStatus,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: colors.textFieldBorder,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8.0, end: 4),
                  child: CircleAvatar(
                    radius: 4.width,
                    backgroundColor: colors.textFieldBorder,
                  ),
                ),
                Text(
                  AppStrings.vacantStatus,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: colors.textFieldBorder,
                  ),
                ),
                if (hasSold) ...[
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 8.0,
                      end: 4,
                    ),
                    child: CircleAvatar(
                      radius: 4.width,
                      backgroundColor: AppColors.errorColor,
                    ),
                  ),
                  Text(
                    AppStrings.soldStatus,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      color: colors.textFieldBorder,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.width, 0, 16.width, 16.height),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              final unit = units[index];
              return UnitCard(
                unit: unit,
                colors: colors,
                onTap: () => RouterHandler.navigate(
                  context,
                  AppRouterKeys.unitDetailsScreen,
                  extra: {'unit': unit, 'propertyName': property?.name??''},
                ),
              );
            }, childCount: units.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              mainAxisExtent: ResponsiveUtils.types(
                context,
                mobilePortrait: 150.height,
                mobileLandscape: 150.height,
                tabletPortrait: 180.height,
                tabletLandscape: 200.height,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.width, 0, 16.width, 24.height),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                ContractsSectionWidget(
                  contracts: state.details?.contracts ?? [],
                ),
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
                OwnerFinancialSection(property: state.details),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
