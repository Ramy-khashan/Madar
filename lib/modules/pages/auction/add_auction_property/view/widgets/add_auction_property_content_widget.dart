import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/app_textfield.dart';
import '../../../../../../core/components/is_scrollable_widget.dart';
import '../../../../../../core/components/property_type_item.dart';
import '../../../../../../core/components/responsive_row_column.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_auction_property_bloc.dart';
import 'auction_date_time_item.dart';
import 'auction_doc_item.dart';

class AddAuctionPropertyContentWidget extends StatelessWidget {
  const AddAuctionPropertyContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    return BlocBuilder<AddAuctionPropertyBloc, AddAuctionPropertyState>(
      builder: (context, state) {
        final colors = AppThemeColors.of(context);
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
              flex: isTablet?1:0,
               child: IsScrollableWidget(
                isScroll: isTablet,
                 child:  Column(children: [
                    Center(
                    child: PropertyTypeSection(
                      selectedItem: state.form.propertyTypeId,
                      onTap: (val) => context.read<AddAuctionPropertyBloc>().add(
                        AddAuctionPropertyTypeSelected(val),
                      ),
                    ),
                  ),
              
                  AppTextField(
                    isWithTitle: true,
                    title: AppStrings.locationLabel,
                    hint: AppStrings.locationFieldHint,
                    textInputType: TextInputType.text,
                    suffixImage: AppImages.locationIcon,
                    onChanged: (v) => context.read<AddAuctionPropertyBloc>().add(
                      AddAuctionPropertyFieldChanged(location: v),
                    ),
                  ),
              
                  AppTextField(
                    isWithTitle: true,
                    title: AppStrings.startingPriceLabel,
                    hint: AppStrings.startingPriceHint,
                    textInputType: TextInputType.number,
                    isPrice: true,
                    suffixImage: AppImages.rentIcon,
                    suffixIconColor: colors.textSecondary,
                    onChanged: (v) => context.read<AddAuctionPropertyBloc>().add(
                      AddAuctionPropertyFieldChanged(
                        startingPrice: digitsOnly(v),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.height),
              
                  Row(
                    children: [
                      Expanded(
                        child: AuctionDateTimeItem(
                          title: AppStrings.startDateLabel,
                          value: state.form.startDate.isEmpty
                              ? '12/1/2020'
                              : state.form.startDate,
                          icon: Icons.calendar_today_outlined,
                          colors: colors,
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (picked != null && context.mounted) {
                              context.read<AddAuctionPropertyBloc>().add(
                                AddAuctionPropertyFieldChanged(
                                  startDate:
                                      '${picked.day}/${picked.month}/${picked.year}',
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10.width),
                      Expanded(
                        child: AuctionDateTimeItem(
                          title: AppStrings.startTimeLabel,
                          value: state.form.startTime.isEmpty
                              ? '12:00 am'
                              : state.form.startTime,
                          icon: Icons.access_time_outlined,
                          colors: colors,
                          onTap: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null && context.mounted) {
                              context.read<AddAuctionPropertyBloc>().add(
                                AddAuctionPropertyFieldChanged(
                                  startTime: picked.format(context),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.height),
                  Row(
                    children: [
                      Expanded(
                        child: AuctionDateTimeItem(
                          title: AppStrings.endDateLabel,
                          value: state.form.endDate.isEmpty
                              ? '12/1/2020'
                              : state.form.endDate,
                          icon: Icons.calendar_today_outlined,
                          colors: colors,
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (picked != null && context.mounted) {
                              context.read<AddAuctionPropertyBloc>().add(
                                AddAuctionPropertyFieldChanged(
                                  endDate:
                                      '${picked.day}/${picked.month}/${picked.year}',
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10.width),
                      Expanded(
                        child: AuctionDateTimeItem(
                          title: AppStrings.endTimeLabel,
                          value: state.form.endTime.isEmpty
                              ? '12:00 am'
                              : state.form.endTime,
                          icon: Icons.access_time_outlined,
                          colors: colors,
                          onTap: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null && context.mounted) {
                              context.read<AddAuctionPropertyBloc>().add(
                                AddAuctionPropertyFieldChanged(
                                  endTime: picked.format(context),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                 if(isTablet)
                 SizedBox(height:35.height),
              ],),
            ),
          ),
             Expanded(
              flex: isTablet?1:0,
               child: IsScrollableWidget(
                isScroll: isTablet,
                 child: Column(children: [
                 Padding(
                    padding: EdgeInsets.only(top: 12.height),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.width,
                        mainAxisSpacing: 8.height,
                        mainAxisExtent: 120.height,
                      ),
                      itemCount: AddAuctionPropertyBloc.get(
                        context,
                      ).counterItems.length,
                      itemBuilder: (_, i) => AppTextField(
                        borderRadius: 14,
                        controller: AddAuctionPropertyBloc.get(
                          context,
                        ).counterItems[i].controller,
                        title: AddAuctionPropertyBloc.get(
                          context,
                        ).counterItems[i].label,
                        hint:
                            AddAuctionPropertyBloc.get(
                              context,
                            ).counterItems[i].suffix ??
                            '0',
                        textInputType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        suffixImage: AddAuctionPropertyBloc.get(
                          context,
                        ).counterItems[i].icon,
                        suffixIconColor: AppThemeColors.of(context).textSecondary,
                      ),
                    ),
                  ),
                 
                  SizedBox(height: 8.height),
                 
                  AppTextField(
                    isWithTitle: true,
                    title: AppStrings.descriptionLabel,
                    hint: AppStrings.descriptionHint,
                    maxLines: 5,
                    textInputType: TextInputType.multiline,
                    onChanged: (v) => context.read<AddAuctionPropertyBloc>().add(
                      AddAuctionPropertyFieldChanged(description: v),
                    ),
                  ),
                 
                  AuctionDocItem(colors: colors),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.height),
                    child: AppButton(
                      text: AppStrings.submitAuctionBtn,
                      isLoading: state.submitStatus == RequestStatus.loading,
                      onTap: () => context.read<AddAuctionPropertyBloc>().add(
                        const AddAuctionPropertySubmit(),
                      ),
                    ),
                  ),
                             
                 ],),
               ),
             )],
          ),
        );
      },
    );
  }
}
