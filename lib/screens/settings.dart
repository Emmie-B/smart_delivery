import 'package:e_delivery/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SizedBox(
              width: 1.sw,
              child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12).w)),
                  child: Text('Logout', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    SharedPreferences.getInstance().then((prefs) {
                      prefs.remove('phone');
                      prefs.remove('password');
                    });
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login', (Route route) => false);
                    // Navigator.pushNamed(context, '/login');
                  }),
            ),
          ),
        )
        // body: Padding(
        //   padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
        //   child: Column(
        //     children: [
        //       Stack(children: [
        //         const CircleAvatar(
        //           radius: 50,
        //           child: Text('AC'),
        //           backgroundImage: const AssetImage('assets/images/user.png'),
        //         ),
        //         Positioned(
        //           child: TextButton(
        //             onPressed: () {},
        //             child: Text('Edit', style: TextStyle(color: Colors.grey)),
        //           ),
        //           left: 0,
        //           bottom: 0,
        //           right: 0,
        //         ),
        //       ]),
        //       5.verticalSpace,
        //       Center(
        //         child: Column(
        //           children: [
        //             Text('Amie Collier'),
        //             Text('amiecollier03@gmail.com'),
        //           ],
        //         ),
        //       ),
        //       5.verticalSpace,
        //       Container(
        //         decoration: BoxDecoration(
        //           border: Border.all(color: Colors.grey.shade300),
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.all(7.0),
        //           child: Column(children: [
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text('Phone number, Email'),
        //                 IconButton(
        //                     onPressed: () {},
        //                     icon: const Icon(Icons.arrow_forward_ios_outlined))
        //               ],
        //             ),
        //             Divider(
        //               color: Colors.grey.shade300,
        //               thickness: 2,
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text('Password'),
        //                 IconButton(
        //                     onPressed: () {},
        //                     icon: const Icon(Icons.arrow_forward_ios_outlined))
        //               ],
        //             ),
        //             Divider(
        //               color: Colors.grey.shade300,
        //               thickness: 2,
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text('Help & Support'),
        //                 IconButton(
        //                     onPressed: () {},
        //                     icon: const Icon(Icons.arrow_forward_ios_outlined))
        //               ],
        //             ),
        //           ]),
        //         ),
        //       ),
        // 10.verticalSpace,
        // Spacer(),

        );
  }
}
