import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageScaffold extends StatelessWidget with SU {
  const HomePageScaffold({Key? key, this.title = ''}) : super(key: key);

  void printScreenInformation(BuildContext context) {
    print('Device Size:${Size(1.sw, 1.sh)}');
    print('Device pixel density:${ScreenUtil().pixelRatio}');
    print('Bottom safe zone distance dp:${ScreenUtil().bottomBarHeight}dp');
    print('Status bar height dp:${ScreenUtil().statusBarHeight}dp');
    print('The ratio of actual width to UI design:${ScreenUtil().scaleWidth}');
    print(
        'The ratio of actual height to UI design:${ScreenUtil().scaleHeight}');
    print('System font scaling:${ScreenUtil().textScaleFactor}');
    print('0.5 times the screen width:${0.5.sw}dp');
    print('0.5 times the screen height:${0.5.sh}dp');
    print('Screen orientation:${ScreenUtil().orientation}');
  }

  @override
  Widget build(BuildContext context) {
    printScreenInformation(context);

    /// Uncomment if you wanna force current widget to be rebuilt with updated values
    /// Must use it if you use the second method, or if you use ScreenUtilInit's child.
    /// Note: don't use it along with ScreenUtil.init()
    // ScreenUtil.registerToBuild(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const RSizedBox.square(dimension: 20),
            Row(
              children: <Widget>[
                // Using Extensions
                Container(
                  padding: EdgeInsets.all(10.w),
                  width: 0.5.sw,
                  height: 200.h,
                  color: Colors.red,
                  child: Text(
                    'My actual width: ${0.5.sw}dp \n\n'
                    'My actual height: ${200.h}dp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                // Without using Extensions
                Container(
                  width: 0.5.sw,
                  height: 20.h,
                  color: Colors.blue,
                  // constraints: BoxConstraints(maxWidth: 180, minHeight: 200).hw,
                  padding: EdgeInsets.all(10.w),
                  child: Text(
                    'My design draft width: 180dp\n\n'
                    'My design draft height: 200dp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(12),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10).w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(const Radius.circular(16).w),
                color: Colors.green,
              ),
              width: 100.r,
              height: 100.r,
              child: Text(
                'I am a square with a side length of 100',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            child: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: const Column(
                                children: [
                                  Text('Dialog'),
                                  Spacer(),
                                  TextField(),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Show Dialog'),
                  ),
                  18.verticalSpace,
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return const HomePageScaffold();
                        }),
                      );
                    },
                    child: const Text('Go to next page'),
                  ),
                  18.verticalSpace,
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200.w +
                                MediaQuery.of(context).viewInsets.bottom,
                            color: Colors.amber,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text('Modal BottomSheet'),
                                  const Spacer(),
                                  const TextField(),
                                  ElevatedButton(
                                    onPressed: Navigator.of(context).pop,
                                    child: const Text('Close BottomSheet'),
                                  ),
                                  SizedBox(
                                      height: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Open BottomSheet'),
                  ),
                  18.verticalSpace,
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  18.verticalSpace,
                  Text('Device width:${ScreenUtil().screenWidth}dp'),
                  Text('Device height:${ScreenUtil().screenHeight}dp'),
                  Text('Device pixel density:${ScreenUtil().pixelRatio}'),
                  Text(
                      'Bottom safe zone distance:${ScreenUtil().bottomBarHeight}dp'),
                  Text('Status bar height:${ScreenUtil().statusBarHeight}dp'),
                  Text(
                      'The ratio of actual width to UI design:${ScreenUtil().scaleWidth}'),
                  Text(
                      'The ratio of actual height to UI design:${ScreenUtil().scaleHeight}'),
                  10.verticalSpace,
                  Text(
                      'System font scaling factor:${ScreenUtil().textScaleFactor}'),
                  5.verticalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        '16sp, will not change with the system.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                        textScaleFactor: 1.0,
                      ),
                      Text(
                        '16sp,if data is not set in MediaQuery,my font size will change with the system.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                        textScaleFactor: 1.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          SystemChrome.setPreferredOrientations([
            MediaQuery.of(context).orientation == Orientation.portrait
                ? DeviceOrientation.landscapeRight
                : DeviceOrientation.portraitUp,
          ]);
          //  setState(() {});
        },
        label: const Text('Rotate'),
      ),
    );
  }

  final String title;
}
