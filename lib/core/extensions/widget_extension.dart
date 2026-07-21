import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  /// Wraps the widget in a [Padding] widget with custom [EdgeInsetsGeometry].
  Widget padding(EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  /// Wraps the widget in a [Padding] widget with equal padding on all sides.
  Widget paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  /// Wraps the widget in a [Padding] widget with symmetric padding.
  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Wraps the widget in a [Padding] widget with specified offsets.
  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
      child: this,
    );
  }

  /// Wraps the widget in a [Padding] widget with directional offsets.
  Widget paddingDirectional({
    double start = 0.0,
    double top = 0.0,
    double end = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: start, top: top, end: end, bottom: bottom),
      child: this,
    );
  }

  /// Wraps the widget in a [Container] with margin.
  Widget margin(EdgeInsetsGeometry margin) {
    return Container(
      margin: margin,
      child: this,
    );
  }

  /// Wraps the widget in a [Center] widget.
  Widget center() {
    return Center(
      child: this,
    );
  }

  /// Wraps the widget in an [Expanded] widget.
  Widget expanded({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }
}
