import 'package:flutter/material.dart';

import '../../../../../core/components/image_item.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/functions/guest_mode.dart';
import '../../../../../core/utils/functions/translation.dart';
import '../../controller/navbar_bloc.dart';

class NavbarBottomBar extends StatelessWidget {
  const NavbarBottomBar({super.key, required this.state});

  final NavbarState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            children: List.generate(state.navbarItems.length, (index) {
              if (index == 2) {
                return const Expanded(child: SizedBox.shrink());
              }
              final isSelected = state.selectedItem == index;
              return Expanded(
                child: InkWell(
                  onTap: () {
                    if (index == 1 &&
                        !GuestMode.requireAuth(
                          context,
                          prompt: GuestAuthPrompt.toast,
                        )) {
                      return;
                    }
                    NavbarBloc.get(context).add(NavbarItemSelected(index));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        width: 40,
                        height: 3,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary300
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                      ImageItem(
                        state.navbarItems[index].icon,
                        width: 24,
                        height: 24,
                        color: AppColors.grey700,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        (state.navbarItems[index].title).trans,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
