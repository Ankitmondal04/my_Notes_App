import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_notes/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset(
            'assets/images/My Notes.png',
            width: 350,
            height: 350,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, size: 150, color: Colors.red);
            },
          ),
        ),
      ),
    );
  }
}
