import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/app_controller/app_controller_bloc.dart';
import 'config/router/app_router.dart';
import 'config/theme/theme.dart';
import 'core/utils/constants/app_constant.dart';
import 'core/utils/functions/responsive.dart';
import 'core/utils/functions/service_locator.dart';
import 'core/utils/functions/translation.dart';

class MadarApp extends StatelessWidget {
  const MadarApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
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
