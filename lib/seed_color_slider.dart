import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<Color> seedColorWheel = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
];

final seedColorProvider =
    StateNotifierProvider<SeedColorNotifier, Color>((ref) {
  return SeedColorNotifier();
});

class SeedColorNotifier extends StateNotifier<Color> {
  SeedColorNotifier() : super(seedColorWheel.first);
  set seedColor(Color value) => state = value;
}

class SeedColorSlider extends ConsumerStatefulWidget {
  const SeedColorSlider({super.key});

  @override
  ConsumerState<SeedColorSlider> createState() => _SeedColorSliderState();
}

class _SeedColorSliderState extends ConsumerState<SeedColorSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();

    final seedColor = ref.read(seedColorProvider);
    final currentIndex = seedColorWheel.indexOf(seedColor);
    _value = currentIndex / seedColorWheel.length;
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _value,
      divisions: seedColorWheel.length - 1,
      onChanged: (double value) {
        setState(() {
          _value = value;
        });
        final newIndex = ((seedColorWheel.length - 1) * value).toInt();
        ref.read(seedColorProvider.notifier).seedColor =
            seedColorWheel[newIndex];
      },
    );
  }
}
