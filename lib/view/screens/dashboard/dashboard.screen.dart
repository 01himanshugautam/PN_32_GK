// ignore_for_file: avoid_print

import 'package:gk/data/repository/auth.repository.dart';
import 'package:gk/view/basewidget/custom-button.widget.dart';
import 'package:gk/view/basewidget/custom-text-field.widget.dart';
import 'package:flutter/material.dart';
import 'package:gk/utils/constants/colors.constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _roomId = TextEditingController();
  final TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'App',
                style: TextStyle(
                  fontSize: 5.h,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
