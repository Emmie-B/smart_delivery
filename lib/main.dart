import 'package:e_delivery/constants.dart';
import 'package:e_delivery/screens/details/detail_screen.dart';
import 'package:e_delivery/screens/login.dart';
import 'package:e_delivery/screens/orders.dart';
import 'package:e_delivery/screens/track_screen.dart';
import 'package:e_delivery/screens/welcome_screen.dart';
import 'package:e_delivery/utilities/argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/confirmDelivery/confirm_delivery_process.dart';
import 'screens/home_screen.dart';

// import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var phone = await prefs.getString('phone');
  // var password = await prefs.getString('password');
  await ScreenUtil.ensureScreenSize();
  runApp(ProviderScope(
      child: MyApp(
    phone: phone,
  )));
  // getVlidationData();
}

final isUserSavedProvide = StateProvider<bool>((ref) {
  return false;
});

// remove splash screen

// void checkConnectivity() async {
//   bool result = await InternetConnectionChecker().hasConnection;
//   if (result == true) {
//     print('YAY! Free cute dog pics!');
//     FlutterNativeSplash.remove();
//   } else {
//     print('No internet :( Reason:');
//     // showSnackBar(context, "Please connect to the internet to continue",
//     //     Colors.redAccent);
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.phone});
  final phone;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // precached images
  bool isUserSaved = false;
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

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
        home: (widget.phone != null) ? HomeScreen() : WelcomeScreen(),
        // initialRoute: '/',
        routes: {
          // '/': (context) => WelcomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => HomeScreen(
                args: ModalRoute.of(context)!.settings.arguments,
              ),
          '/delivery_details': (context) => DetailScreen(
                args: ModalRoute.of(context)!.settings.arguments
                    as DeliveryDetailArguments,
              ),
          '/confirm_delivery_details': (context) => ConfirmDeliveryProcess(
                args: ModalRoute.of(context)!.settings.arguments
                    as ConfirmDeliveryArguments,
              ),
          '/track_screen': (context) => TrackScreen(),
          '/order_screen': (context) => OrderScreen(),
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
