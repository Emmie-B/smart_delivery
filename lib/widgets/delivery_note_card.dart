import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import '../utilities/argument.dart';

// cupertino

class CustomOrderTaskCard extends StatelessWidget {
  CustomOrderTaskCard({
    super.key,
    required this.customerName,
    required this.customerPhone,
    this.status,
    this.itemType,
    this.destination,
    this.itemQuantity,
    this.itemDescription,
    this.noteId,
  });
  String? customerName;
  String? customerPhone;
  Uri? url;
  String? status;
  String? itemType;
  String? destination;
  String? itemQuantity;
  String? itemDescription;
  String? noteId;

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
              customerName: customerName,
              customerPhone: customerPhone,
              itemType: itemType,
              destination: destination,
              itemQuantity: itemQuantity,
              // estimatedDateOfDelivery: '2023-09-04 14:20:00',
              itemDescription: itemDescription,
              noteId: noteId,
              status: status
            ));
      },
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(10).w,
          height: 165.h,
          width: 0.9.sw,
          constraints: BoxConstraints(
            minHeight: 165.h,
            minWidth: 0.9.sw,
          ),
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
                            height: 24,
                            decoration: BoxDecoration(
                              color: status == 'Pending'
                                  ? Colors.yellow[50]
                                  : Colors.green[50],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                status!,
                                style: TextStyle(
                                    color: status == 'Pending'
                                        ? Colors.yellow[600]
                                        : Colors.green[600],
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          5.horizontalSpace,
                          Text(
                            'Order: #$noteId',
                            style: smallText,
                          ),
                        ],
                      ),
                      3.verticalSpace,
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
                          Text(itemType!),
                        ],
                      ),
                      3.verticalSpace,
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
                          Expanded(
                            flex: 0,
                            child: Text(
                              destination!,
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
                          icon: const Icon(
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
