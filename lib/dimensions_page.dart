import 'dart:math';

import 'package:collection/collection.dart';
import 'package:dependencies/dimension.dart';
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
  final List<DimensionController> _dimensionControllers = [];
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

    int otherDimensionsCount = _dimensionControllers.length;
    _dimensionControllers.add(
      DimensionController(initialValue: randomNumberGenerator.nextDouble()),
    );

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
          const ToggleBrightnessButton(),
          IconButton(
            onPressed: () {
              setState(() {
                _dimensionControllers.clear();
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
              for (final controller in _dimensionControllers)
                Dimension(
                  controller: controller,
                  onChanged: ({
                    required double oldValue,
                    required double newValue,
                  }) {
                    final diff = newValue - oldValue;
                    final dimensionIndex =
                        _dimensionControllers.indexOf(controller);
                    _dependencies[dimensionIndex]
                        .forEachIndexed((dependencyIndex, factor) {
                      final dependency = _dimensionControllers[dependencyIndex];
                      dependency.move(diff: diff * factor);
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
