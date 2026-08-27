import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/router/app_router_keys.dart';
import '../constants/app_enums.dart';
import '../constants/app_strings.dart';
import 'common_fun.dart';

class RouterHandler {
  RouterHandler._();

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
}
