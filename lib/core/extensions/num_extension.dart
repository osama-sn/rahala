import 'package:flutter/material.dart';

extension NumExtension on num {
  /// Short alias for horizontal space (SizedBox with width)
  Widget get hSpace => SizedBox(width: toDouble());

  /// Short alias for vertical space (SizedBox with height)
  Widget get vSpace => SizedBox(height: toDouble());

  /// Returns a [SizedBox] with width equal to this number
  Widget get widthBox => SizedBox(width: toDouble());

  /// Returns a [SizedBox] with height equal to this number
  Widget get heightBox => SizedBox(height: toDouble());
}
