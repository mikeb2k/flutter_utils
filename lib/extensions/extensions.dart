import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String lastN(int n) {
    try {
      return substring(length - n);
    } catch (e) {
      return this;
    }
  }
}

extension TargetPlatformExtension on TargetPlatform {
  bool get isMobile => this == TargetPlatform.iOS || this == TargetPlatform.android;
  bool get isAndroid => this == TargetPlatform.android;
  bool get isIOS => this == TargetPlatform.iOS;
}

extension DateTimeExtension on DateTime {
  bool get isToday {
    DateTime now = DateTime.now();
    return (now.day == day && now.month == month && now.year == year);
  }

  DateTime get nextDay => DateTime(year, month, day + 1);
  DateTime get withoutTime => DateTime(year, month, day);
}

extension ColorExtension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}

extension DoubleExtension on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension ListExtension on Iterable {
  bool get hasEqualElements => Set.from(this).length <= 1 ? true : false;

  bool checkContainsN(List<String> listB, int n) {
    Set<String> setB = listB.toSet();
    int matchCount = 0;

    for (String item in this) {
      if (setB.contains(item)) {
        matchCount++;
        if (matchCount >= n) {
          return true;
        }
      }
    }

    return false;
  }
}

extension GoRouterLocation on GoRouter {
  String get location {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}

extension BuildContextExtension on BuildContext {
  bool get isLight => Theme.of(this).brightness == Brightness.light;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  ProviderContainer get container => ProviderScope.containerOf(this);
  T read<T>(ProviderBase<T> provider) => container.read(provider);
}

extension KeyExtension on GlobalKey {
  Offset get position {
    final RenderBox? renderBox = currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return Offset.zero;

    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    return Offset(offset.dx - (size.width * 6), offset.dy + size.height + 6);
  }

  Size get size {
    final RenderBox? renderBox = currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return Size.zero;

    final Size size = renderBox.size;
    return size;
  }
}
