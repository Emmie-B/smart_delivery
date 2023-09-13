import 'package:e_delivery/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SizedBox(
              height: 1.sh,
              child: Image.asset('assets/images/e-delivery_bg.jpeg',
                  fit: BoxFit.cover,
                  // color: Color.fromRGBO(255, 230, 179, 1.0).withOpacity(1),
                  color: Color.fromRGBO(255, 230, 179, 1.0).withOpacity(1),
                  colorBlendMode: BlendMode
                      .modulate // Adjust the image fitting as per your requirement
                  ),
            ),
            Container(
              decoration: const BoxDecoration(
                // color: kPrimaryColor,
                gradient: LinearGradient(
                  colors: [Colors.transparent, Color.fromARGB(255, 23, 20, 20)],
                  stops: [0.05, 0.9],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Text("teeh"),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Smart Delivery",
                      style: headingText,
                    ),
                    10.verticalSpace,
                    const Text(
                      "Effortlessly Track, Manage, Ensure and Show proof of your delivery services with ease.",
                      style: TextStyle(color: Colors.white54, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    40.verticalSpace,
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12).w)),
                        child: Text(
                          'Log In',
                          style: buttonText,
                        ),
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
