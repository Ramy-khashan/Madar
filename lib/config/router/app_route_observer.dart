import 'package:flutter/material.dart';

/// Observes full-screen [PageRoute]s only, so dialogs and sheets do not
/// trigger navbar reloads.
final RouteObserver<PageRoute<dynamic>> appRouteObserver =
    RouteObserver<PageRoute<dynamic>>();
