import 'package:dependencies/dimension.dart';
import 'package:flutter/material.dart';

class DimensionsPage extends StatefulWidget {
  final int initialDimensions;

  const DimensionsPage({
    super.key,
    this.initialDimensions = 1,
  });

  @override
  State<DimensionsPage> createState() => _DimensionsPageState();
}

class _DimensionsPageState extends State<DimensionsPage> {
  final List<DimensionController> _dimensionControllers = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.initialDimensions; i++) {
      _dimensionControllers.add(DimensionController());
    }
  }

  void _addDimension() {
    setState(() {
      _dimensionControllers.add(DimensionController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              for (final controller in _dimensionControllers)
                Dimension(
                  controller: controller,
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDimension,
        tooltip: 'Add dimension',
        child: const Icon(Icons.add),
      ),
    );
  }
}
