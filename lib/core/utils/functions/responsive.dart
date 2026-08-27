import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum DeviceType { mobilePortrait, mobileLandscape, tablet }

enum OrientationType { portrait, landscape }

class ResponsiveUtils {
  const ResponsiveUtils._();

  static DeviceType getDeviceType(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final orientation = MediaQuery.orientationOf(context);

    if (size.width < 660) {
      return orientation == Orientation.portrait
          ? DeviceType.mobilePortrait
          : DeviceType.mobileLandscape;
    }
    return DeviceType.tablet;
  }

  static OrientationType getOrientation(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.portrait
      ? OrientationType.portrait
      : OrientationType.landscape;

  static bool isMobilePortrait(BuildContext context) =>
      getDeviceType(context) == DeviceType.mobilePortrait;

  static bool isMobileLandscape(BuildContext context) =>
      getDeviceType(context) == DeviceType.mobileLandscape;

  static bool isTablet(BuildContext context) =>
      getDeviceType(context) == DeviceType.tablet;

  static bool isPortrait(BuildContext context) =>
      getOrientation(context) == OrientationType.portrait;

  static bool isLandscape(BuildContext context) =>
      getOrientation(context) == OrientationType.landscape;

  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static EdgeInsets safeAreaPadding(BuildContext context) =>
      MediaQuery.paddingOf(context);
  static double types(
    BuildContext context, {
    required double mobilePortrait,
    required double mobileLandscape,
    required double tabletPortrait,
    required double tabletLandscape,
  }) => context.screenHeight < 700
      ? mobileLandscape
      : context.isTablet && context.isPortrait
      ? tabletPortrait
      : context.isLandscape
      ? tabletLandscape
      : mobilePortrait;
  static T valueByDevice<T>({
    required BuildContext context,
    required T mobilePortrait,
    required T mobileLandscape,
    required T tablet,
  }) => switch (getDeviceType(context)) {
    DeviceType.mobilePortrait => mobilePortrait,
    DeviceType.mobileLandscape => mobileLandscape,
    DeviceType.tablet => tablet,
  };

  static T valueByOrientation<T>({
    required BuildContext context,
    required T portrait,
    required T landscape,
  }) => isPortrait(context) ? portrait : landscape;

  static double responsiveFontScale(BuildContext context, double fontSize) =>
      valueByDevice(
        context: context,
        mobilePortrait: fontSize,
        mobileLandscape: fontSize * 1.1,
        tablet: fontSize * 1.3,
      );

  static double responsiveAspectRatio(
    BuildContext context, {
    double baseHeight = 110,
  }) {
    final size = MediaQuery.sizeOf(context);
    final deviceIsTablet = size.shortestSide >= 600;
    final deviceIsLandscape = size.width > size.height;

    final crossAxisCount = deviceIsTablet ? 2 : 1;

    double itemHeight = baseHeight;
    if (deviceIsTablet) {
      itemHeight *= 1.2;
    } else if (deviceIsLandscape) {
      itemHeight *= 1.7;
    }

    final itemWidth = size.width / crossAxisCount;
    return itemWidth / itemHeight;
  }

  static double responsiveHorizontalPadding(BuildContext context) =>
      valueByDevice(
        context: context,
        mobilePortrait: 16,
        mobileLandscape: 20,
        tablet: 32,
      );

  static EdgeInsets responsivePadding(BuildContext context) => valueByDevice(
    context: context,
    mobilePortrait: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    mobileLandscape: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    tablet: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
  );
  static int gridColumns(BuildContext context) {
    return valueByDevice<int>(
      context: context,
      mobilePortrait: 1,
      mobileLandscape: 2,
      tablet: 2,
    );
  }
}

extension ResponsiveContext on BuildContext {
  DeviceType get deviceType => ResponsiveUtils.getDeviceType(this);

  OrientationType get orientationType => ResponsiveUtils.getOrientation(this);

  bool get isMobilePortrait => ResponsiveUtils.isMobilePortrait(this);

  bool get isMobileLandscape => ResponsiveUtils.isMobileLandscape(this);

  bool get isTablet => ResponsiveUtils.isTablet(this);

  bool get isPortrait => ResponsiveUtils.isPortrait(this);

  bool get isLandscape => ResponsiveUtils.isLandscape(this);

  double get screenWidth => ResponsiveUtils.screenWidth(this);

  double get screenHeight => ResponsiveUtils.screenHeight(this);

  EdgeInsets get responsivePadding => ResponsiveUtils.responsivePadding(this);

  double get responsiveHorizontalPadding =>
      ResponsiveUtils.responsiveHorizontalPadding(this);

  double responsiveFontScale(double size) =>
      ResponsiveUtils.responsiveFontScale(this, size).fontSize;

  T byDevice<T>({
    required T mobilePortrait,
    required T mobileLandscape,
    required T tablet,
  }) => ResponsiveUtils.valueByDevice(
    context: this,
    mobilePortrait: mobilePortrait,
    mobileLandscape: mobileLandscape,
    tablet: tablet,
  );

  T byOrientation<T>({required T portrait, required T landscape}) =>
      ResponsiveUtils.valueByOrientation(
        context: this,
        portrait: portrait,
        landscape: landscape,
      );
}

class ScreenUtilWrapper extends StatelessWidget {
  const ScreenUtilWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final orientation = MediaQuery.orientationOf(context);

    final Size designSize;
    if (size.width < 660) {
      designSize = orientation == Orientation.portrait
          ? const Size(375, 812)
          : const Size(812, 375);
    } else {
      designSize = const Size(1280, 800);
    }

    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      child: child,
      builder: (context, child) => child!,
    );
  }
}

Future<void> initScreenUtils() => ScreenUtil.ensureScreenSize();

extension SizeExtension on num {
  double get width => w;

  double get height => h;

  double get fontSize => sp;

  double get radius => r;

  EdgeInsets get edgeInsets => EdgeInsets.all(r);

  SizedBox get toSizedBox => SizedBox(height: toDouble(), width: toDouble());
}
