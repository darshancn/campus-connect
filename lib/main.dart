import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campus_connect/screens/authentication/screens/login_screen.dart';
import 'package:campus_connect/screens/splash_screen.dart';
import 'package:campus_connect/theme/app_theme.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Hive.initFlutter(); // Initialize Hive
  await Hive.openBox('chats'); // Open the 'chats' box

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _showSplash = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeData,
          home: _showSplash ? const SplashScreen() : const LoginScreen(),
        );
      },
    );
  }
}









// -------------------- i-phone view code ---------------------------







// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:campus_connect/screens/login_screen.dart';
// import 'package:campus_connect/screens/splash_screen.dart';
// import 'package:campus_connect/theme/app_theme.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:device_preview/device_preview.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   await Hive.openBox('chats');
//
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode, // Only enable in debug mode
//       builder: (context) => const MyApp(), // Wrap your app here
//     ),
//   );
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   bool _showSplash = true;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Future.delayed(const Duration(seconds: 5), () {
//         if (mounted) {
//           setState(() {
//             _showSplash = false;
//           });
//         }
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       builder: (context, child) {
//         return MaterialApp(
//           useInheritedMediaQuery: true,
//           // 👈 required for DevicePreview
//           locale: DevicePreview.locale(context),
//           // 👈 required
//           builder: DevicePreview.appBuilder,
//           // 👈 required
//           debugShowCheckedModeBanner: false,
//           theme: AppTheme.themeData,
//           home: _showSplash ? const SplashScreen() : const LoginScreen(),
//         );
//       },
//     );
//   }
// }
