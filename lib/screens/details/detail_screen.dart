import 'package:e_delivery/utilities/argument.dart';
import 'package:e_delivery/widgets/major_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, this.args}) : super(key: key);

  final DeliveryDetailArguments? args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Delivery For: ${args?.customerName ?? ""}', // Use null safety
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildStatusWidget(
                      "Item Type", args?.itemType ?? "", kPrimaryColor),
                  const VerticalDivider(color: kPrimaryColor),
                  _buildStatusWidget(
                    "Quantity",
                    args?.itemQuantity ?? "",
                    kPrimaryColor,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                // color: kPrimeColor,
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: const Text(
                        'Delivery Details',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    16.verticalSpace,
                    // Modify with actual quantity
                    _buildDetailRow("Client Name", args?.customerName ?? ""),
                    _buildDetailRow("Client Number", args?.customerPhone ?? ""),
                    _buildDetailRow("Address", args?.destination ?? ""),
                    _buildDetailRow("Description", args?.itemDescription ?? ""),
                    // Modify with actual description
                    // 16.verticalSpace,

                    Spacer(),

                    args?.status == "Completed"
                        ? SizedBox()
                        : CustomMajorButton(
                            text: 'Confirm Delivery Details',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/confirm_delivery_details',
                                arguments: ConfirmDeliveryArguments(
                                  customerName: args?.customerName,
                                  customerPhone: args?.customerPhone,
                                  noteId: args?.noteId,
                                ),
                              );
                            })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusWidget(String title, String value, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          // style: TextStyle(color: color),
          style: mediumText.copyWith(color: color),
        ),
        Text(
          value,
          style: TextStyle(color: color),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
          ),
          maxLines:
              4, // Set the maximum number of lines before applying ellipsis
          // overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// class DeliveryDetailArguments {
//   final String? itemType;
//   final String? customerName;
//   final String? customerPhone;
//   final String? destination;

//   DeliveryDetailArguments(
//       {this.itemType, this.customerName, this.customerPhone, this.destination});
// }
