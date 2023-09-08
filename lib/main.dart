import 'package:dependencies/dimensions_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Brightness brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dimensions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: brightness,
        ),
        useMaterial3: true,
      ),
      home: DimensionsPage(
        initialDimensions: 1,
        onToggleBrightness: () {
          setState(() {
            brightness = brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light;
          });
        },
      ),
    );
  }
}
