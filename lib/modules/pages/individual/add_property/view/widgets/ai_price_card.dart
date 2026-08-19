import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';

class AiPriceCard extends StatelessWidget {
  const AiPriceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Container(
      height: 170,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: tc.primaryBrand,
        gradient: LinearGradient(
          colors: [tc.primaryBrand, AppColors.darkSurface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          const PositionedDirectional(
            end: 0,
            bottom: 0,
            child: ImageItem(
              AppImages.splashBg,
              width: 120,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.width),
            child: BlocBuilder<AddPropertyBloc, AddPropertyState>(
              buildWhen: (prev, curr) =>
                  prev.isPreviewLoading != curr.isPreviewLoading ||
                  prev.hasMarketData != curr.hasMarketData ||
                  prev.suggestedMin != curr.suggestedMin ||
                  prev.suggestedMax != curr.suggestedMax,
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.auto_awesome_rounded,
                          color: Color(0xFFFBBF24),
                          size: 14,
                        ),
                        SizedBox(width: 6.width),
                        Text(
                          AppStrings.aiSmartSuggestion,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(11),
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.height),
                    Text(
                      AppStrings.suggestedPrice,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (state.isPreviewLoading)
                      const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    else
                      Text(
                        _rangeLabel(state),
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(22),
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    SizedBox(height: 4.height),
                    Text(
                      state.hasMarketData
                          ? AppStrings.basedOnTransactions
                          : AppStrings.noMarketData,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(11),
                        color: Colors.white70,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _rangeLabel(AddPropertyState state) {
    if (!state.hasMarketData ||
        state.suggestedMin == null ||
        state.suggestedMax == null) {
      return '—';
    }
    return '${_formatPrice(state.suggestedMin!)} - ${_formatPrice(state.suggestedMax!)} ${AppStrings.currency}';
  }

  String _formatPrice(num value) {
    final text = value.round().toString();
    final buffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      final reverseIndex = text.length - i;
      buffer.write(text[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) buffer.write(',');
    }
    return buffer.toString();
  }
}
