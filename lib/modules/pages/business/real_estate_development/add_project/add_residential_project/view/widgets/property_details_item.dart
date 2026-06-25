import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../../core/components/app_textfield.dart';
import '../../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../auction/add_auction_property/model/property_details.dart';
 
class PropertyDetailsItem extends StatelessWidget {
  const PropertyDetailsItem({super.key, required this.counterItems});
  final List<CounterItemModel> counterItems;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.height),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.width,
          mainAxisExtent: 100.height,
        ),
        itemCount: counterItems.length,
        itemBuilder: (_, i) => AppTextField(
          borderRadius: 14,
          controller: counterItems[i].controller,
          title: counterItems[i].label,
          hint: counterItems[i].suffix ?? '0',
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          suffixImage: counterItems[i].icon,
          suffixIconColor: AppThemeColors.of(context).textSecondary,
        ),
      ),
    );
  }
}
