import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/components/app_button.dart';
import '../../../../core/components/loading_process.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../controller/real_estate_news_details_bloc.dart';
import 'widgets/real_estate_news_details_content_widget.dart';

class RealEstateNewsDetailsScreen extends StatelessWidget {
  const RealEstateNewsDetailsScreen({super.key, required this.newsId});
  final String newsId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RealEstateNewsDetailsBloc, RealEstateNewsDetailsState>(
      builder: (context, state) {
        final colors = AppThemeColors.of(context);
        return Scaffold(
          backgroundColor: colors.backgroundPrimary,
      appBar: AppAppbar(title: AppStrings.realEstateNews),
          body: SafeArea(
            child: LoadingProcess(
              status: state.status,
              errorMsg: state.errorMsg,
              onTapRefresh: () => context
                  .read<RealEstateNewsDetailsBloc>()
                  .add(RealEstateNewsDetailsLoad(newsId)),
              emptyMsg: AppStrings.noNews,
              isEmptyList:
                  state.status == RequestStatus.success &&
                  state.article == null,
              childIsLoader: true,
              child: RealEstateNewsDetailsContentWidget(item: state.article),
            ),
          ),
          bottomNavigationBar:  SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.height,
                horizontal: 12.width,
              ),
              child: AppButton(onTap: () {}, text: AppStrings.readMoreNewsBtn),
            ),
          ),
        );
      },
    );
  }
}
