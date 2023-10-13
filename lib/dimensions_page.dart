import 'dart:math';

import 'package:collection/collection.dart';
import 'package:dependencies/dimension.dart';
import 'package:dependencies/seed_color_slider.dart';
import 'package:dependencies/toggle_brightness_button.dart';
import 'package:flutter/material.dart';

class DimensionsPage extends StatefulWidget {
  static const floodCount = 100;

  final int initialDimensions;

  const DimensionsPage({
    super.key,
    this.initialDimensions = 1,
  });

  @override
  State<DimensionsPage> createState() => _DimensionsPageState();
}

class _DimensionsPageState extends State<DimensionsPage> {
  final randomNumberGenerator = Random();
  final List<double> _values = [];
  final List<List<double>> _dependencies = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.initialDimensions; i++) {
      _addDimension();
    }
  }

  void _addDimension() {
    double randomFactor() {
      return randomNumberGenerator.nextDouble() * 2 - 1;
    }

    int otherDimensionsCount = _values.length;
    _values.add(randomNumberGenerator.nextDouble());

    _dependencies.add(
      List.generate(otherDimensionsCount, (_) => randomFactor()) + [0],
    );
    for (int i = 0; i < otherDimensionsCount; i++) {
      _dependencies[i].add(randomFactor());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Expanded(child: SeedColorSlider()),
          const ToggleBrightnessButton(),
          IconButton(
            onPressed: () {
              setState(() {
                _values.clear();
                _dependencies.clear();
                _addDimension();
              });
            },
            tooltip: 'Reset',
            icon: const Icon(Icons.restart_alt_rounded),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              for (int i = 0; i < _values.length; i++)
                Dimension(
                  value: _values[i],
                  onChanged: (double newValue) {
                    final diff = newValue - _values[i];
                    setState(() {
                      _values[i] = newValue;
                      _dependencies[i]
                          .forEachIndexed((dependencyIndex, factor) {
                        final unboundNewValue =
                            _values[dependencyIndex] + diff * factor;
                        _values[dependencyIndex] = unboundNewValue.clamp(0, 1);
                      });
                    });
                  },
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            onPressed: () {
              setState(() {
                for (int i = 0; i < DimensionsPage.floodCount; i++) {
                  _addDimension();
                }
              });
            },
            tooltip: 'Add ${DimensionsPage.floodCount} dimensions',
            child: const Icon(Icons.flood_outlined),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _addDimension();
              });
            },
            tooltip: 'Add dimension',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
