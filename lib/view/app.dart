import 'package:gk/provider/auth.provider.dart';
import 'package:gk/view/screens/auth/login.screen.dart';
import 'package:flutter/material.dart';
import 'package:gk/view/screens/dashboard/dashboard.screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLogin;
  login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool('is_login');
    setState(() {
      this.isLogin = isLogin;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => AuthProvider(),
            ),
          ],
          child: MaterialApp(
              title: 'GK',
              home: isLogin != null ? DashboardScreen() : LoginScreen()),
        );
      },
    );
  }
}
