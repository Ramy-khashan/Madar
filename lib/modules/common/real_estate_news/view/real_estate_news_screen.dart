import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/components/loading_process.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../controller/real_estate_news_bloc.dart';
import 'widgets/real_estate_news_content_widget.dart';

class RealEstateNewsScreen extends StatelessWidget {
  const RealEstateNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppAppbar(title: AppStrings.realEstateNews),
      body: SafeArea(
        child: BlocBuilder<RealEstateNewsBloc, RealEstateNewsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveHorizontalPadding,
                    vertical: 4.height,
                  ),
                  child: Text(
                    AppStrings.realEstateNewsHeaderSubtitle,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(16),
                      fontFamily: AppConstant.appHeaderFont,
                      color: AppThemeColors.of(context).textFieldTitle,
                    ),
                  ),
                ),
                // CategoryTabs(selectedCategory: state.selectedCategory),
                SizedBox(height: 8.height),
                Expanded(
                  child: LoadingProcess(
                    status: state.newsStatus,
                    errorMsg: state.errorMsg,
                    onTapRefresh: () => context.read<RealEstateNewsBloc>().add(
                      const RealEstateNewsLoad(),
                    ),
                    emptyMsg: AppStrings.noNews,
                    isEmptyList: state.items.isEmpty,
                    childIsLoader: true,
                    child: const RealEstateNewsContentWidget(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
