import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FadingTextAnimation());
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  ThemeMode _themeMode = ThemeMode.light;
  bool darkMode = false;

  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,

      home: Scaffold(
        appBar: AppBar(
          title: Text('Fading Text Animation'),
          actions: <Widget>[
            IconButton(
              // if dark mode, show sun; if light mode, show moon
              icon: darkMode
                  ? const Icon(Icons.sunny)
                  : const Icon(Icons.mode_night),
              // same idea for the tooltip text
              tooltip: darkMode ? 'Light Mode' : 'Dark Mode',
              onPressed: () {
                setState(() {
                  // if on, switch to light mode; if off, switch to dark mode
                  _themeMode = darkMode ? ThemeMode.light : ThemeMode.dark;
                  darkMode = !darkMode;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(seconds: 1),
            child: Text('Hello, Flutter!', style: TextStyle(fontSize: 24)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: toggleVisibility,
          child: Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
