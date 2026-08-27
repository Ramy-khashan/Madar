import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/app_controller/app_controller_bloc.dart';
import 'config/router/app_router.dart';
import 'config/router/app_router_keys.dart';
import 'config/theme/theme.dart';
import 'core/components/guest_auth_sheet.dart';
import 'core/utils/constants/app_constant.dart';
import 'core/utils/functions/fcm_token_service.dart';
import 'core/utils/functions/guest_mode.dart';
import 'core/utils/functions/responsive.dart';
import 'core/utils/functions/router_handler.dart';
import 'core/utils/functions/service_locator.dart';
import 'core/utils/functions/translation.dart';

class MadarApp extends StatefulWidget {
  const MadarApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MadarApp> createState() => _MadarAppState();
}

class _MadarAppState extends State<MadarApp> {
  void _openFromNotification(Map<String, dynamic> data) {
    final context = MadarApp.navigatorKey.currentContext;
    if (context == null || !context.mounted) return;
    final propertyId = '${data['propertyId'] ?? ''}'.trim();
    if (GuestMode.isGuest) {
      if (propertyId.isNotEmpty) {
        RouterHandler.navigate(
          context,
          AppRouterKeys.propertyDetails,
          extra: propertyId,
        );
        return;
      }
      showGuestAuthSheet(context);
      return;
    }
    final contractId = '${data['contractId'] ?? ''}'.trim();
    if (contractId.isNotEmpty) {
      RouterHandler.navigate(
        context,
        AppRouterKeys.contractDetails,
        extra: contractId,
      );
      return;
    }
    if (propertyId.isNotEmpty) {
      RouterHandler.navigate(
        context,
        AppRouterKeys.propertyDetails,
        extra: propertyId,
      );
      return;
    }
    RouterHandler.navigate(context, AppRouterKeys.notification);
  }

  @override
  void initState() {
    super.initState();
    FcmTokenService.instance.onOpened = _openFromNotification;
    FcmTokenService.instance.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<AppControllerBloc>()..add(const AppControllerInit()),
      child: BlocBuilder<AppControllerBloc, AppControllerState>(
        buildWhen: (p, c) => p.themeMode != c.themeMode,
        builder: (context, appState) {
          return ScreenUtilWrapper(
            child: MaterialApp.router(
              theme: AppTheme.light(),
              localizationsDelegates: localizationDelegates(context),
              supportedLocales: supportedLocales(context),
              locale: locale(context),
              darkTheme: AppTheme.dark(),
              themeMode: appState.themeMode,
              title: AppConstant.appName,
              routerConfig: appRouter,
              debugShowCheckedModeBanner: true,
            ),
          );
        },
      ),
    );
  }
}
