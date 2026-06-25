import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/search_item.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/auction_list_bloc.dart';
import 'auction_card_widget.dart';

class AuctionListContentWidget extends StatelessWidget {
  const AuctionListContentWidget({super.key, required this.isLoading});
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionListBloc, AuctionListState>(
      builder: (context, state) {
        return Column(
          children: [
            const SearchItem(),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(
                  left: 12.width,
                  right: 12.width,
                  bottom: 40.height,
                  top: 8.height,
                ),

                itemCount: isLoading ? 12 : state.filteredItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveUtils.types(
                    context,
                    mobilePortrait: 1,
                    mobileLandscape: 2,
                    tabletPortrait: 2,
                    tabletLandscape: 3,
                  ).toInt(),
                  mainAxisSpacing: 12.height,
                  crossAxisSpacing: 12.width,
                  mainAxisExtent: ResponsiveUtils.types(
                    context,
                    mobilePortrait: 480.height,
                    mobileLandscape: 580.height,
                    tabletPortrait: 580.height,
                    tabletLandscape: 500.height,
                  ),
                ),
                itemBuilder: (_, i) => AuctionCardWidget(
                  item: isLoading ? null : state.filteredItems[i],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
