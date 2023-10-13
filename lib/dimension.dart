import 'package:flutter/material.dart';

class Dimension extends StatelessWidget {
  final double value;
  final void Function(double value)? onChanged;

  const Dimension({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: RotatedBox(
        quarterTurns: 3,
        child: Slider(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
