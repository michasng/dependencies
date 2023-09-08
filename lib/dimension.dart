import 'package:dependencies/unbound_controller_exception.dart';
import 'package:flutter/material.dart';

class DimensionController {
  final _key = GlobalKey<_DimensionState>();

  void move({required double diff}) {
    if (_key.currentState == null) throw UnboundControllerException();

    final unboundNewValue = _key.currentState!._value + diff;
    _key.currentState!.value = unboundNewValue.clamp(0, 1);
  }
}

class Dimension extends StatefulWidget {
  static const double defaultValue = 0.5;

  final double initialValue;
  final DimensionController? controller;
  final void Function({
    required double oldValue,
    required double newValue,
  })? onChanged;

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
            final oldValue = _value;
            this.value = value;
            if (widget.onChanged != null) {
              widget.onChanged!(
                oldValue: oldValue,
                newValue: value,
              );
            }
          },
        ),
      ),
    );
  }
}
