import 'package:flutter/material.dart';
import 'package:gk/helper/common-function.dart';
import 'package:gk/provider/auth.provider.dart';
import 'package:gk/utils/constants/colors.constant.dart';
import 'package:gk/view/basewidget/custom-button.widget.dart';
import 'package:gk/view/basewidget/custom-text-field.widget.dart';
import 'package:gk/view/screens/dashboard/dashboard.screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 10.h,
            ),
            SizedBox(height: 2.h),
            Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 4.h,
                color: AppColors.defaultTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            CustomTextField(
                width: 80.w,
                controller: _username,
                hintText: 'Username',
                icon: const Icon(Icons.mail),
                hintColor: AppColors.appColor),
            CustomTextField(
                icon: const Icon(
                  Icons.key,
                ),
                width: 80.w,
                controller: _password,
                hintText: 'Password',
                backgroundColor: Colors.white,
                hintColor: AppColors.appColor),
            SizedBox(height: 3.h),
            CustomButton(
              width: 80.w,
              height: 6.h,
              text: 'Login',
              color: AppColors.appColor,
              onPressed: () async {
                var response =
                    await Provider.of<AuthProvider>(context, listen: false)
                        .login(
                  _username.text,
                  _password.text,
                );
                if (response.data['status'] == 1) {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('is_login', true);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardScreen()));
                } else if (response.data['status'] == 0) {
                  CommonFunctions.showSuccessToast(response.data['msg']);
                }
                debugPrint("Login Response $response");
              },
            ),
          ],
        ),
      ),
    );
  }
}
