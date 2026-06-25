import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/image_item.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../controller/auction_navbar_bloc.dart';

class AuctionNavbarScreen extends StatelessWidget {
  const AuctionNavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionNavbarBloc, AuctionNavbarState>(
      builder: (context, state) {
        return Scaffold(
          body: AuctionNavbarBloc.get(
            context,
          ).navbarItems[state.selectedIndex].page,
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            backgroundColor: AppThemeColors.of(context).primaryBrand,
            onPressed: () {
              AuctionNavbarBloc.get(context).add(const ChangePageEvent(2));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.radius),
            ),
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              border: Border.all(color: AppThemeColors.of(context).borderColor),
              color: AppThemeColors.of(context).primaryBrand,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.radius),
                topRight: Radius.circular(30.radius),
              ),

              boxShadow: [
                BoxShadow(
                  color: AppThemeColors.of(
                    context,
                  ).textSecondary.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: BottomNavigationBar(
              onTap: (value) {
                AuctionNavbarBloc.get(context).add(ChangePageEvent(value));
              },
              currentIndex: state.selectedIndex,
              selectedItemColor: AppThemeColors.of(context).primaryBrand,
              unselectedItemColor: AppThemeColors.of(context).textSecondary,
              selectedIconTheme: IconThemeData(
                size: 24.width,
                color: AppThemeColors.of(context).primaryBrand,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: context.responsiveFontScale(12),
                fontWeight: FontWeight.w400,
              ),
              selectedLabelStyle: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w600,
              ),
              type: BottomNavigationBarType.fixed,
              items: List.generate(
                AuctionNavbarBloc.get(context).navbarItems.length,
                (index) {
                  final item = AuctionNavbarBloc.get(
                    context,
                  ).navbarItems[index];
                  return BottomNavigationBarItem(
                    icon: item.iconPath.isEmpty
                        ? const Text('')
                        : ImageItem(
                            item.iconPath,
                            color: state.selectedIndex == index
                                ? AppThemeColors.of(context).primaryBrand
                                : AppThemeColors.of(context).textSecondary,
                          ),
                    label: item.title,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
