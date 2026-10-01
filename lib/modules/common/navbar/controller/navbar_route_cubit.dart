import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_route_observer.dart';

class NavbarRouteCubit extends Cubit<int> with RouteAware {
  NavbarRouteCubit(PageRoute<dynamic>? route, this.onPopNext) : super(0) {
    if (route != null) {
      _subscribed = true;
      appRouteObserver.subscribe(this, route);
    }
  }

  final VoidCallback onPopNext;
  bool _subscribed = false;

  @override
  void didPopNext() => onPopNext();

  @override
  Future<void> close() {
    if (_subscribed) appRouteObserver.unsubscribe(this);
    return super.close();
  }
}
