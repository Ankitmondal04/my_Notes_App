import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/firebase_options.dart';
import 'package:my_notes/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5DEB3),
        fontFamily: 'Tinos',

        appBarTheme: Theme.of(context).appBarTheme.copyWith(
          backgroundColor: Colors.amberAccent[400],
          titleTextStyle: TextStyle(
            fontFamily: 'Capriola',
            fontSize: 28,
            color: Color(0xFF4E342E),
            fontWeight: FontWeight.w700,
          ),
          centerTitle: false,
          elevation: 8.0,
          shadowColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.amberAccent[400],
        ),
        iconTheme: IconThemeData(color: Color(0xFF4E342E)),
      ),
      home: SplashScreen(),
    );
  }
}
