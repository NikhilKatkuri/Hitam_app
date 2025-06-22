import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hitam_app/core/constants/app_colors.dart';
import 'package:hitam_app/core/utils/app_vectors.dart';

class StudentChat extends StatefulWidget {
  const StudentChat({super.key});

  @override
  State<StudentChat> createState() => _StudentChatState();
}

class _StudentChatState extends State<StudentChat> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        title: Text('Chats', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
        actions: [IconButton(onPressed: () {}, icon: SvgPicture.asset(AppVectors.notification))],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  TextField(
                    focusNode: _focusNode,
                    selectionHeightStyle: BoxHeightStyle.max,
                    style: TextStyle(color: AppColors.dark),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                      filled: true, // enable background color
                      // ignore: deprecated_member_use
                      fillColor: AppColors.lightestGray.withOpacity(0.6),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(AppVectors.search, height: 20, width: 20),
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: _focusNode.hasFocus ? AppColors.dark : AppColors.mediumGray,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
