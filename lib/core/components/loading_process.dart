import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../utils/constants/app_enums.dart';
import 'failed_shape.dart';

class LoadingProcess extends StatelessWidget {
  const LoadingProcess({
    super.key,
    required this.status,
    required this.child,
    this.loader,
    required this.errorMsg,
    this.emptyWidget,
    this.childIsLoader = false,
    required this.onTapRefresh,
    required this.emptyMsg,
    required this.isEmptyList,
  });
  final RequestStatus status;
  final Widget child;
  final Widget? loader;
  final String errorMsg;
  final String emptyMsg;
  final Widget? emptyWidget;
  final bool isEmptyList;
  final bool childIsLoader;
  final VoidCallback onTapRefresh;
  @override
  Widget build(BuildContext context) {
    return status == RequestStatus.failed
        ? FailedShape(msg: errorMsg, onTapRefresh: onTapRefresh)
        : status == RequestStatus.success && isEmptyList
        ? emptyWidget ?? FailedShape(msg: emptyMsg, onTapRefresh: onTapRefresh)
        : status != RequestStatus.success
        ? Skeletonizer(
            enabled: status == RequestStatus.loading,
            child: childIsLoader ? child : loader!,
          )
        : child;
  }
}
