import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_enums.dart';

 
class RouterHandler {
  RouterHandler._();

  static Future<dynamic> navigate(
    BuildContext context,
    String routerName, {
    RouterType routerType = RouterType.pushName,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
  }) async {
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
