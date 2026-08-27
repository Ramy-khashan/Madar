import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../widgets/ad_summary_table.dart';
import '../widgets/ai_generate_button.dart';
import '../widgets/ai_price_card.dart';
import '../widgets/description_field.dart';
import '../widgets/price_input_section.dart';
import '../widgets/save_portfolio_sheet.dart';
import '../widgets/service_cards_row.dart';
import '../widgets/step6_buttons.dart';
import '../widgets/title_section.dart';

class AddPropertyStep6Screen extends StatelessWidget {
  const AddPropertyStep6Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    final bloc = AddPropertyBloc.get(context);
    return BlocListener<AddPropertyBloc, AddPropertyState>(
      listenWhen: (prev, curr) =>
          prev.showPortfolioSheet != curr.showPortfolioSheet,
      listener: (context, state) {
        if (state.showPortfolioSheet) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) =>
                BlocProvider.value(value: bloc, child: const SavePortfolioSheet()),
          ).whenComplete(() {
            if (bloc.state.showPortfolioSheet) {
              bloc.add(const HidePortfolioSheetEvent());
            }
          });
        }
      },
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 16.width,
                vertical: 8.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.priceAndReview,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(16),
                      fontWeight: FontWeight.w700,
                      color: tc.textPrimary,
                    ),
                  ),
                  4.height.toSizedBox,
                  Text(
                    AppStrings.setPriceAiHint,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      color: tc.textSecondary,
                    ),
                  ),
                  16.height.toSizedBox,
                  const AiPriceCard(),
                  16.height.toSizedBox,
                  PriceInputSection(controller: bloc.priceController, tc: tc),
                  20.height.toSizedBox,
                  TitleSection(controller: bloc.titleController, tc: tc),
                  20.height.toSizedBox,
                  const ServiceCardsRow(),
                  16.height.toSizedBox,
                  AiGenerateButton(
                    onTap: () => AddPropertyBloc.get(
                      context,
                    ).add(const ApplyAiDescriptionEvent()),
                    tc: tc,
                  ),
                  12.height.toSizedBox,
                  DescriptionField(controller: bloc.descriptionController),
                  20.height.toSizedBox,
                  const AdSummaryTable(),
                  32.height.toSizedBox,
                ],
              ),
            ),
          ),
          Step6Buttons(tc: tc),
        ],
      ),
    );
  }
}
