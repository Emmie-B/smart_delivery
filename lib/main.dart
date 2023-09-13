import 'package:e_delivery/constants.dart';
import 'package:e_delivery/screens/details/detail_screen.dart';
import 'package:e_delivery/screens/login.dart';
import 'package:e_delivery/screens/welcome_screen.dart';
import 'package:e_delivery/utilities/argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/confirmDelivery/confirm_delivery_process.dart';
import 'screens/home_screen.dart';
// import 'package:flutter/cupertino.dart';

void main() async {
  // Add this line
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // precached images
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
        const AssetImage('assets/images/e-delivery_bg.jpeg'), context);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: Size(screenWidth, screenHeight),
      minTextAdapt: true,
      ensureScreenSize: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const WelcomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/delivery_details': (context) => DetailScreen(
                args: ModalRoute.of(context)!.settings.arguments
                    as DeliveryDetailArguments,
              ),
          '/confirm_delivery_details': (context) => ConfirmDeliveryProcess(
                args: ModalRoute.of(context)!.settings.arguments
                    as ConfirmDeliveryArguments,
              ),
        },
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primaryColor: kPrimaryColor,
          // useMaterial3: true,
          appBarTheme: const AppBarTheme(backgroundColor: kTextColor),
        ),
      ),
    );
  }
}
