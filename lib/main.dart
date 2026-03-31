import 'package:flutter/material.dart';
import 'ui/home_screen.dart';

void main() {
  runApp(const VideokeApp());
}

class VideokeApp extends StatelessWidget {
  const VideokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Videokê',
      debugShowCheckedModeBanner:
          false, // Tira a faixa de "Debug" (mais profissional)
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(),
    );
  }
}
