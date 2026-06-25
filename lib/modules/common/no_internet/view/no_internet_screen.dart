import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../config/router/app_router_keys.dart';
import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/functions/router_handler.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  Future<void> _retry(BuildContext context) async {
    final results = await Connectivity().checkConnectivity();
    if (!results.contains(ConnectivityResult.none)) {
      if (context.mounted) {
        RouterHandler.navigate(
          context,
          AppRouterKeys.splash,
          routerType: RouterType.pushReplacementNamed,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = AppThemeColors.of(context).primaryBrand;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wifi_off_rounded, size: 80, color: color),
              const SizedBox(height: 24),
              Text(
                'no_internet'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'no_internet_desc'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => _retry(context),
                child: Text('retry'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
