import 'package:flutter/material.dart';
import 'package:wifi_picker/features/features.dart';
import 'package:wifi_picker/theme/app_theme.dart';

import 'features/home/presentation/screens/splash.dart';

///
class WifiPickerApp extends StatelessWidget {
  ///
  const WifiPickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      home: SplashScreen(),
    );
  }
}
