import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final double radius;
  final EdgeInsetsGeometry? padding;
  final double borderWidth;
  final Color borderColor;
  final Color? color;
  final Widget child;

  const RoundedContainer({
    super.key,
    this.radius = 10.0,
    this.padding,
    this.borderWidth = 1.0,
    this.borderColor = Colors.black,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: color,
      ),
      child: child,
    );
  }
}
