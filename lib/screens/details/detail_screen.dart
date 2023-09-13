import 'package:e_delivery/utilities/argument.dart';
import 'package:e_delivery/widgets/major_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.args});
  final DeliveryDetailArguments? args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 0,
        elevation: 0,
        title: Text(
          'Delivery For: ${args!.customerName!}',
          style: TextStyle(fontSize: 15.sp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                height: 250.w,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text('Delivery Details'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Item Type',
                            style: kdeliveryDetailText,
                          ),
                          Text(
                            // args!.customerName!,
                            'Box',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                      3.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity',
                            style: kdeliveryDetailText,
                          ),
                          Text(
                            // args!.customerName!,
                            '1',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                      3.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Client Name',
                            style: kdeliveryDetailText,
                          ),
                          Text(
                            args!.customerName!,
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Client Number',
                            style: kdeliveryDetailText,
                          ),
                          Text(
                            args!.customerPhone!,
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Address',
                            style: kdeliveryDetailText,
                          ),
                          Text(
                            // args!.customerPhone!,
                            '7 Malama Thomas Street',
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Description',
                            style: kdeliveryDetailText,
                          ),
                          Text(
                            // args!.customerPhone!,
                            'This is a description for the delivery note. Please',
                            softWrap: true,
                            maxLines: 2,

                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),

                      TextButton(
                          onPressed: () {}, child: const Text('Share with Client'))
                      // Text(
                      //   'Customer Address: ${args!.customerAddress!}',
                      //   style: TextStyle(fontSize: 15.sp),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            CustomMajorButton(
              text: "Confirm Delivery Details",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/confirm_delivery_details',
                  arguments: ConfirmDeliveryArguments(
                    customerName: args!.customerName,
                    customerPhone: args!.customerPhone,
                    // customerAddress: args!.customerAddress,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
