import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_button.dart';
import '../../../../core/components/app_textfield.dart';
import '../../../../core/model/property_filter_model.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../controller/filter_bloc.dart';
import 'widgets/filter_dropdown.dart';
import 'widgets/filter_price_range.dart';
import 'widgets/filter_sale_toggle.dart';
import 'widgets/filter_section_label.dart';
import 'widgets/filter_type_chips.dart';

Future<void> showFilterSheet(
  BuildContext context, {
  PropertyFilterModel? initialFilter,
  required void Function(PropertyFilterModel filter) onApply,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider(
      create: (_) =>
          FilterBloc()..add(FilterInitialised(initialFilter: initialFilter)),
      child: FilterSheetView(onApply: onApply),
    ),
  );
}

class FilterSheetView extends StatelessWidget {
  const FilterSheetView({super.key, required this.onApply});

  final void Function(PropertyFilterModel filter) onApply;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FilterBloc, FilterState>(
      listener: (context, state) {
        if (state is FilterApplyRequested) {
          RouterHandler.pop(context);
          onApply(state.filter);
        }
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, scrollController) {
          final colors = AppThemeColors.of(context);
          return Container(
            decoration: BoxDecoration(
              color: colors.backgroundPrimary,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24.radius),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      padding: EdgeInsetsDirectional.only(end: 16.width,top: 16.height,),
                     minimumSize: Size.zero,),
                    icon: Icon(
                      Icons.close,
                      color: colors.textFieldTitle,
                      size: 22.fontSize,
                    ),
                    onPressed: () => RouterHandler.pop(context),
                  ),
                ),

 
                Expanded(
                  child: BlocBuilder<FilterBloc, FilterState>(
                    builder: (context, state) {
                      final s = state is FilterUpdated
                          ? state
                          : const FilterUpdated(
                              isForSale: true,
                              typeId: null,
                              minPrice: PropertyFilterModel.kMinPrice,
                              maxPrice: PropertyFilterModel.kMaxPrice,
                              paymentSystem: null,
                              duration: null,
                              city: null,
                            );

                      return SingleChildScrollView(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.width,
                          vertical: 6.height,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FilterSectionLabel(AppStrings.filterSection),
                            SizedBox(height: 12.height),
                            FilterSaleToggle(
                              isForSale: s.isForSale,
                              onChanged: (v) => context.read<FilterBloc>().add(
                                FilterSaleTypeChanged(isForSale: v),
                              ),
                            ),
                            SizedBox(height: 20.height),

                            FilterSectionLabel(AppStrings.filterPropertyType),
                            SizedBox(height: 12.height),
                            FilterTypeChips(
                              selected: s.typeId,
                              onChanged: (id) => context.read<FilterBloc>().add(
                                FilterPropertyTypeChanged(
                                  typeId: id == s.typeId ? null : id,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.height),

                            FilterSectionLabel(AppStrings.city),
                            SizedBox(height: 12.height),
                            AppTextField(
                              isWithTitle: false,
                              hint: AppStrings.enterCity,
                              controller: context
                                  .read<FilterBloc>()
                                  .cityController,
                              onChanged: (value) =>
                                  context.read<FilterBloc>().add(
                                    FilterCityChanged(city: value),
                                  ),
                            ),
                            SizedBox(height: 20.height),

                            FilterSectionLabel(AppStrings.filterPrice),
                            SizedBox(height: 4.height),
                            FilterPriceRange(
                              minPrice: s.minPrice,
                              maxPrice: s.maxPrice,
                              onChanged: (range) =>
                                  context.read<FilterBloc>().add(
                                    FilterPriceRangeChanged(
                                      minPrice: range.start,
                                      maxPrice: range.end,
                                    ),
                                  ),
                            ),
                            SizedBox(height: 20.height),

                            FilterSectionLabel(AppStrings.filterPaymentSystem),
                            SizedBox(height: 12.height),
                            FilterDropdown(
                              hint: AppStrings.filterAnySystem,
                              value: s.paymentSystem,
                              items: AppConstant.paymentSystems,
                              onChanged: (v) => context.read<FilterBloc>().add(
                                FilterPaymentSystemChanged(paymentSystem: v),
                              ),
                            ),
                            if (!s.isForSale) ...[
                              SizedBox(height: 20.height),
                              FilterSectionLabel(AppStrings.filterDuration),
                              SizedBox(height: 12.height),
                              FilterDropdown(
                                hint: AppStrings.filterAnyDuration,
                                value: s.duration,
                                items: AppConstant.durations,
                                onChanged: (v) =>
                                    context.read<FilterBloc>().add(
                                      FilterDurationChanged(duration: v),
                                    ),
                              ),
                            ],
                            SizedBox(height: 28.height),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(
                    20.width,
                    8.height,
                    20.width,
                    24.height,
                  ),
                  child: AppButton(
                    text: AppStrings.filterApply,
                    onTap: () =>
                        context.read<FilterBloc>().add(const FilterApplied()),
                    width: double.infinity,
                    colorBG: AppColors.secondBrand,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
