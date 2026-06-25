import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/portfolio_card_widget.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../controller/my_properties_bloc.dart';

class MyPropertiesScreen extends StatelessWidget {
  const MyPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: AppStrings.myProperties),
      body: SafeArea(
        child: Column(
          children: [
            // BlocBuilder<MyPropertiesBloc, MyPropertiesState>(
            //   builder: (context, state) {
            //     final filter = state is MyPropertiesLoaded
            //         ? state.filter
            //         : null;
            //     return SearchItem(
            //       onFilterTap: () {
            //         showFilterSheet(
            //           context,
            //           initialFilter: filter,
            //           onApply: (result) {
            //             context.read<MyPropertiesBloc>().add(
            //               MyPropertiesFilterApplied(result),
            //             );
            //           },
            //         );
            //       },
            //     );
            //   },
            // ),
            Expanded(
              child: BlocBuilder<MyPropertiesBloc, MyPropertiesState>(
                builder: (context, state) {
                  final items = state is MyPropertiesLoaded
                      ? state.properties
                      : MyPropertiesBloc.myPropertiesItems;
                  return GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.width,
                      vertical: 12.height,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 1,
                        mobileLandscape: 2,
                        tabletPortrait: 2,
                        tabletLandscape: 3,
                      ).toInt(),
                      crossAxisSpacing: 12.width,
                      mainAxisSpacing: 12.height,
                      mainAxisExtent: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 170.height,
                        mobileLandscape: 200.height,
                        tabletPortrait: 200.height,
                        tabletLandscape: 240.height,
                      ).toDouble(),
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return PortfolioCardWidget(portfolio: items[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
