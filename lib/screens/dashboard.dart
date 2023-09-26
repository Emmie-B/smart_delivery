import 'package:e_delivery/constants.dart';
import 'package:e_delivery/domain/models/delivery_note_model.dart';
import 'package:e_delivery/service/api_services.dart';
import 'package:e_delivery/widgets/delivery_note_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  APIServices? apiServices;
  DeliveryData? deliveryData;
  DeliveryData? completeddeliveryData;
  late Future<List<DeliveryData>>? deliveryDataFuture;
  late Future<List<DeliveryData>>? completedDeliveryDataFuture;
  String? firstname;
  String? lname;
  String? staf_id;
  String? clint_id;
  String? completed;
  String? pending;

  @override
  void initState() {
    super.initState();
    apiServices = APIServices();
    deliveryDataFuture = getDeliveryData();
    completedDeliveryDataFuture = getCompletedDeliveryData();
  }

  Future<List<DeliveryData>> getDeliveryData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var staff_id = prefs.getString('staff_id');
    var client_id = prefs.getString('client_id');
    var fname = prefs.getString('firstname');
    // var lname = prefs.getString('lastname');

    setState(() {
      this.firstname = fname;
      this.staf_id = staff_id;
      this.clint_id = client_id;
    });
    debugPrint(staf_id);
    debugPrint(fname);
    debugPrint(clint_id);
    var res = await apiServices!.fetchDeliveryNote(client_id!, staff_id!);
    if (res == "No Order Found") {
      return Future.error("No Orders Found ");
    } else {
      setState(() {
        this.pending = res.length.toString();
      });
      return res;
    }
  }

  int? index;

  Future<List<DeliveryData>> getCompletedDeliveryData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var staff_id = prefs.getString('staff_id');
    var client_id = prefs.getString('client_id');
    var res =
        await apiServices!.fetchCompletedDeliveryNote(client_id!, staff_id!);

    if (res == "No Order Found") {
      return Future.error("No Completed Orders Yet");
    } else {
      setState(() {
        this.completed = res.length.toString();
      });
      return res;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(staf_id);
    debugPrint(clint_id);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 130,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello ${firstname ?? 'User'}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_outlined),
              ),
            ]),
            10.verticalSpace,
            Container(
              height: 50,
              width: 0.8.sw,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Pending',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      Text(pending ?? '0',
                          style: TextStyle(color: kPrimaryColor)),
                    ],
                  ),
                  VerticalDivider(
                    color: kPrimaryColor,
                  ),
                  Column(
                    children: [
                      Text('Completed', style: TextStyle(color: kPrimaryColor)),
                      Text(completed ?? '0',
                          style: TextStyle(color: kPrimaryColor)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 0.27.sh,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New Orders',
                          style: mediumText,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                // push to track screen
                                Navigator.pushNamed(context, '/order_screen',
                                    arguments: {
                                      index: 1,
                                    });
                              },
                              child: const Text(
                                'See all',
                                style: TextStyle(
                                  color: kPrimeColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: kPrimeColor,
                            )
                          ],
                        )
                      ],
                    ),
                    FutureBuilder(
                        future: deliveryDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.data!.isEmpty ||
                              snapshot.data == null) {
                            return Center(
                              child: Center(
                                child: Text(
                                  'No Orders Found',
                                ),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            return SizedBox(
                              height: 166.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return CustomOrderTaskCard(
                                    customerName:
                                        snapshot.data![index].customerName,
                                    customerPhone:
                                        snapshot.data![index].customerPhone,
                                    status: snapshot.data![index].status,
                                    itemType: snapshot.data![index].itemType,
                                    destination: snapshot.data![index].address,
                                    itemQuantity: snapshot
                                        .data![index].itemQuantity
                                        .toString(),
                                    itemDescription:
                                        snapshot.data![index].itemDescription,
                                    noteId: snapshot.data![index].id,
                                  );
                                },
                                itemCount: snapshot.data!.length,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                snapshot.error.toString(),
                              ),
                            );
                          }
                          return const Text('No orders yet');
                        }),
                    5.verticalSpace
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Delivery History',
                      style: mediumText,
                    ),
                  ),
                  5.verticalSpace,
                  FutureBuilder(
                    future: completedDeliveryDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.data!.isEmpty ||
                          snapshot.data == null) {
                        return Center(
                          child: Text(
                            'No completed orders yet ',
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return SizedBox(
                          height: 0.6.sh,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CustomOrderTaskCard(
                                customerName:
                                    snapshot.data![index].customerName,
                                customerPhone:
                                    snapshot.data![index].customerPhone,
                                status: snapshot.data![index].status,
                                itemType: snapshot.data![index].itemType,
                                destination: snapshot.data![index].address,
                                itemQuantity: snapshot.data![index].itemQuantity
                                    .toString(),
                                itemDescription:
                                    snapshot.data![index].itemDescription,
                                noteId: snapshot.data![index].id,
                              );
                            },
                            itemCount: snapshot.data!.length,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            snapshot.error.toString(),
                          ),
                        );
                      }
                      return Center(child: const CircularProgressIndicator());
                    },
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
