import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const PageViewDemo();
}
}
class PageViewDemo extends StatelessWidget {
  const PageViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageView(
        children: const [
          FadingTextAnimation(
            title: 'Fast Fade',
            duration: Duration(seconds: 1),
          ),
          FadingTextAnimation(
            title: 'Slow Fade',
            duration: Duration(seconds: 3),
          ),
        ],
      ),
    );
  }
}




class FadingTextAnimation extends StatefulWidget {
  final String title;
  final Duration duration;

  const FadingTextAnimation({
    super.key,
    required this.title,
    required this.duration,
  });

  @override

  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  ThemeMode _themeMode = ThemeMode.light;
  bool darkMode = false;

  bool _isVisible = true;
  bool _showFrame = false;

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: widget.duration,
            child:   Text(widget.title, 
            style: TextStyle(fontSize: 24),
          ),
        ),
        const SizedBox(height: 40),
        Container(
         decoration: _showFrame ? BoxDecoration(
          border: Border.all(color: Colors.blue, width: 4),
          borderRadius: BorderRadius.circular(16),
        ) 
        : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://plus.unsplash.com/premium_photo-1698405316329-fd9c43d7e11c?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        ),
        const SizedBox(height: 20),

        SwitchListTile(
          title: const Text('Show Frame'),
          value: _showFrame,
          onChanged: (bool value) {
            setState(() {
              _showFrame = value;
            });
          },
        ),
      ],
      ),

      floatingActionButton : FloatingActionButton(
        onPressed: toggleVisibility,
        child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}