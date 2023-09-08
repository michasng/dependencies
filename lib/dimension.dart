import 'package:flutter/material.dart';

class DimensionController {
  final _key = GlobalKey<_DimensionState>();

  set value(double value) => _key.currentState?.value = value;
}

class Dimension extends StatefulWidget {
  final double initialValue;
  final DimensionController? controller;
  final void Function(double value)? onChanged;

  Dimension({
    this.initialValue = .5,
    this.controller,
    this.onChanged,
  }) : super(key: controller?._key);

  @override
  State<Dimension> createState() => _DimensionState();
}

class _DimensionState extends State<Dimension> {
  late double _value;
  set value(double value) => setState(() => _value = value);

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: RotatedBox(
        quarterTurns: 3,
        child: Slider(
          value: _value,
          onChanged: (value) {
            this.value = value;
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
        ),
      ),
    );
  }
}
