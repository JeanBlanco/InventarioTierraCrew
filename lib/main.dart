import 'package:flutter/material.dart';
import 'package:tierra_crew/home_screen.dart';

void main() {
  runApp(const TierraCrewApp());
}

class TierraCrewApp extends StatelessWidget {
  const TierraCrewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tierra Crew',
      theme: ThemeData(
        primaryColor: Colors.yellow[700],
        hintColor: Colors.red[900],
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}
