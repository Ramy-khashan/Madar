import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_route_observer.dart';
import '../../../../config/router/app_router_keys.dart';
import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../controller/navbar_bloc.dart';
import 'widgets/bottom_nav_widget.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      appRouteObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    appRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      NavbarBloc.get(context).add(const NavbarReload());
    });
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
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
