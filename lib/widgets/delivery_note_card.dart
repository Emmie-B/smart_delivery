import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import '../utilities/argument.dart';
import 'package:flutter/cupertino.dart';

// cupertino  

class CustomOrderTaskCard extends StatelessWidget {
  CustomOrderTaskCard(
      {super.key, required this.customerName, required this.customerPhone});
  String? customerName;
  String? customerPhone;
  Uri? url;

  Future<void> smsLauncher() async {
    final url = Uri(
      scheme: 'sms',
      path: customerPhone!,
    );
    await launchUrl(url);
  }

  Future<void> phoneLauncher() async {
    final url = Uri(
      scheme: 'tel',
      path: customerPhone!,
    );
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/delivery_details',
            arguments: DeliveryDetailArguments(
                customerName: customerName, customerPhone: customerPhone));
      },
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(10).w,
          height: 167,
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            width: 100,
                            height: 25,
                            decoration: BoxDecoration(
                                color: Colors.yellow[50],
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                'PENDING',
                                style: TextStyle(
                                    color: Colors.yellow[600],
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          5.horizontalSpace,
                          Text(
                            'Order: #4916',
                            style: smallText,
                          ),
                        ],
                      ),
                      5.verticalSpace,
                      Row(
                        textBaseline: TextBaseline.ideographic,
                        children: [
                          const Icon(Icons.drive_folder_upload),
                          2.horizontalSpace,
                          Text(
                            "Item Type: ",
                            style: smallText,
                          ),
                          2.horizontalSpace,
                          const Text('Box'),
                        ],
                      ),
                      5.verticalSpace,
                      Row(
                        textBaseline: TextBaseline.ideographic,
                        children: [
                          const Icon(Icons.location_on_outlined),
                          2.horizontalSpace,
                          Text(
                            "Destination: ",
                            style: smallText,
                          ),
                          2.horizontalSpace,
                          const Expanded(
                            flex: 0,
                            child: Text(
                              "7 Malama",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.navigate_next)
                ],
              ),
              Divider(
                height: 20,
                thickness: 1,
                color: Colors.grey[400],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customerName!,
                        style: smallText,
                      ),
                      3.verticalSpace,
                      Text(
                        customerPhone!,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 38,
                        width: 40,
                        decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: IconButton(
                          onPressed: () {
                            smsLauncher();
                          },
                          icon: Icon(
                            Icons.chat_rounded,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(6)),
                        // padding: const EdgeInsets.all(4),

                        child: IconButton(
                          // iconSize: 5,
                          onPressed: () {
                            phoneLauncher();
                            // alunch(url);
                          },
                          icon: const Icon(
                            Icons.phone,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
