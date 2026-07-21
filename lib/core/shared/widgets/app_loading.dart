import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  final double size;
  final Color? color;

  const AppLoading({
    super.key,
    this.size = 40.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
