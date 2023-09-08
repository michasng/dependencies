import 'package:dependencies/dimensions_page.dart';
import 'package:dependencies/seed_color_slider.dart';
import 'package:dependencies/toggle_brightness_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedColor = ref.watch(seedColorProvider);
    final brightness = ref.watch(brightnessProvider);

    return MaterialApp(
      title: 'Dimensions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: brightness,
        ),
        useMaterial3: true,
      ),
      home: const DimensionsPage(
        initialDimensions: 1,
      ),
    );
  }
}
