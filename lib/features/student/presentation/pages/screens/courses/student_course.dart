import 'package:flutter/material.dart';

class StudentCourse extends StatefulWidget {
  const StudentCourse({super.key});

  @override
  State<StudentCourse> createState() => _StudentCourseState();
}

class _StudentCourseState extends State<StudentCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Text('course'))),
    );
  }
}
