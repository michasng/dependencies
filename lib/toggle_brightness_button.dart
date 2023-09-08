import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final brightnessProvider =
    StateNotifierProvider<BrightnessNotifier, Brightness>((ref) {
  return BrightnessNotifier();
});

class BrightnessNotifier extends StateNotifier<Brightness> {
  BrightnessNotifier() : super(Brightness.light);
  void toggle() =>
      state = state == Brightness.light ? Brightness.dark : Brightness.light;
}

class ToggleBrightnessButton extends ConsumerWidget {
  const ToggleBrightnessButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = ref.watch(brightnessProvider);
    return IconButton(
      onPressed: ref.read(brightnessProvider.notifier).toggle,
      tooltip: 'Toggle dark mode',
      icon: Icon(
        brightness == Brightness.light ? Icons.dark_mode : Icons.light_mode,
      ),
    );
  }
}
