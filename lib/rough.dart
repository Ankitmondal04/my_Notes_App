import 'package:flutter/material.dart';
import 'package:my_notes/screens/todo_screen.dart';

class RoughScreen extends StatefulWidget {
  const RoughScreen({super.key});

  @override
  State<RoughScreen> createState() => _RoughScreenState();
}

class _RoughScreenState extends State<RoughScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(title: Text("Rough Screen")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TodoScreen()),
          );
        },
        child: Icon(Icons.fork_right_rounded),
      ),
    );
  }
}
