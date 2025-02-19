import 'package:flutter/material.dart';

class DropdownList<T> extends StatefulWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final TextStyle? style;
  final Color? backgroundColor;
  final ValueChanged<T?>? onChanged;
  final double radius;
  final Color borderColor;
  final double borderWidth;

  const DropdownList({
    super.key,
    required this.value,
    required this.items,
    this.style,
    this.backgroundColor,
    this.onChanged,
    this.radius = 10.0,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
  });

  @override
  State<DropdownList<T>> createState() => _DropdownListState<T>();
}

class _DropdownListState<T> extends State<DropdownList<T>> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: widget.backgroundColor),
      child: DropdownButtonFormField(
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(
              color: widget.borderColor,
              width: widget.borderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(
              color: widget.borderColor,
              width: widget.borderWidth,
            ),
          ),
        ),
        value: widget.value,
        onChanged: widget.onChanged,
        style: widget.style,
        items: widget.items,
      ),
    );
  }
}
