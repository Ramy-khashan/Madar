import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/router/app_router_keys.dart';
import '../../../modules/common/navbar/controller/navbar_refresh.dart';
import '../constants/app_enums.dart';
import '../constants/app_strings.dart';
import 'common_fun.dart';

class RouterHandler {
  RouterHandler._();

  static bool _navbarRestoreScheduled = false;

  static const _comingSoonRoutes = {
    AppRouterKeys.auctionNavbar,
    AppRouterKeys.auctionList,
    AppRouterKeys.auctionDetails,
    AppRouterKeys.auctionDeposit,
    AppRouterKeys.auctionBidResult,
    AppRouterKeys.myBids,
    AppRouterKeys.addAuctionProperty,
    AppRouterKeys.myListings,
  };

  static Future<dynamic> navigate(
    BuildContext context,
    String routerName, {
    RouterType routerType = RouterType.pushName,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
  }) async {
    if (_comingSoonRoutes.contains(routerName)) {
      AppToast(AppStrings.comingSoon);
      return null;
    }
    switch (routerType) {
      case RouterType.goName:
        if (routerName == AppRouterKeys.navbar) {
          goToNavbar(context);
          return null;
        }
        context.goNamed(
          routerName,
          extra: extra,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
        );
        return null;
      case RouterType.pushName:
        return await context.pushNamed(
          routerName,
          extra: extra,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
        );
      case RouterType.relacementName:
        context.replaceNamed(
          routerName,
          extra: extra,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
        );
      case RouterType.pushReplacementNamed:
        context.pushReplacementNamed(
          routerName,
          extra: extra,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
        );
    }
  }

  static bool canPop(BuildContext context) => context.canPop();
  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    context.pop<T>(result);
  }

  /// Clears the stack like `goNamed` / pushAndRemoveUntil, then refreshes
  /// navbar tabs after the route settles so mid-flow navigation is not interrupted.
  static void goToNavbar(BuildContext context, {bool resetToHome = true}) {
    if (!context.mounted || _navbarRestoreScheduled) return;
    _navbarRestoreScheduled = true;
    try {
      context.goNamed(AppRouterKeys.navbar);
    } catch (_) {
      _navbarRestoreScheduled = false;
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navbarRestoreScheduled = false;
      NavbarRefresh.reload(resetToHome: resetToHome);
    });
  }
}
