import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/add_auction_property_bloc.dart';
import 'widgets/add_auction_property_content_widget.dart';

class AddAuctionPropertyScreen extends StatelessWidget {
  const AddAuctionPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddAuctionPropertyBloc, AddAuctionPropertyState>(
      listenWhen: (prev, curr) => prev.submitStatus != curr.submitStatus,
      listener: (ctx, state) {
        if (state.submitStatus == RequestStatus.success) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
              content: Text(AppStrings.submitAuctionBtn),
              backgroundColor: AppThemeColors.of(ctx).primaryBrand,
            ),
          );
        }
      },
      child: Scaffold(
       appBar: AppAppbar(title: AppStrings.addAuctionPropertyTitle),
       body: const SafeArea(
         child: AddAuctionPropertyContentWidget(),
       ),
      
                ),
    );
  }
}
