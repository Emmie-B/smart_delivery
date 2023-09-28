import 'package:e_delivery/domain/models/delivery_note_model.dart';
// import 'package:e_delivery/screens/track_screen.dart';
import 'package:e_delivery/service/api_services.dart';
import 'package:e_delivery/widgets/delivery_note_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  APIServices? apiServices;
  bool _isLoading = false;

  List<DeliveryData>? deliveryData;

  @override
  void initState() {
    fetchStaffNote();

    super.initState();
    // deliveryData = DeliveryData();
    apiServices = APIServices();
  }

  fetchStaffNote() async {
    setState(() {
      _isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var staff_id = await prefs.getString('staff_id');
    var client_id = await prefs.getString('client_id');
    var res = await apiServices!.fetchDeliveryNote(client_id, staff_id);
    // set string
    await prefs.setString('note_id', res[0].id);
    print(client_id);

    if (res == 'No Order Found') {
      print('tesrthb');
      print(res);
    } else {
      setState(() {
        deliveryData = res;
        _isLoading = false;
      });
    }
    // List<DeliveryData> deliveryData = res as List<DeliveryData>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 130,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/home',
              );
            },
            icon: Icon(Icons.arrow_back)),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Track Your Orders',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: const CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchableList<DeliveryData>(
                initialList: deliveryData!,
                autoFocusOnSearch: false,
                
                loadingWidget: const Center(
                  child: CircularProgressIndicator(),
                ),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                builder: ((displayedList, itemIndex, item) {
                  return CustomOrderTaskCard(
                    customerName: item.customerName,
                    customerPhone: item.customerPhone,
                    status: item.status,
                    itemType: item.itemType,
                    destination: item.address,
                    itemQuantity: item.itemQuantity,
                    itemDescription: item.itemDescription,
                    noteId: item.id,
                    size: displayedList.length,
                  );
                }),
                filter: (value) => deliveryData!
                    .where((element) =>
                        element.customerName!.toLowerCase().contains(value))
                    .toList(),
                emptyWidget: const Text("Empty"),
                inputDecoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search Client Name",
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
              ),
            ),
    );
  }
}
