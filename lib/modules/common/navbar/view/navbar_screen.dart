import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router_keys.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../controller/navbar_bloc.dart';
import 'widgets/bottom_nav_widget.dart';

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      builder: (context, state) {
        if (state.navbarItems.isEmpty) {
          return const Scaffold();
        }
        return Scaffold(
          body: state.navbarItems[state.selectedItem].screen,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.white, width: 2.5),
            ),
            onPressed: () {
              RouterHandler.navigate(context, AppRouterKeys.addProperty);
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: NavbarBottomBar(state: state),
        );
      },
    );
  }
}
