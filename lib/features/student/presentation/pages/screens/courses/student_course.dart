import 'package:flutter/material.dart';
import 'package:hitam_app/core/constants/app_colors.dart';

class StudentCourse extends StatefulWidget {
  const StudentCourse({super.key});

  @override
  State<StudentCourse> createState() => _StudentCourseState();
}

class _StudentCourseState extends State<StudentCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        title: const Text(
          "Learning Hub",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
                 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
