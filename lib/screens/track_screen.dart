import 'package:e_delivery/domain/models/delivery_note_model.dart';
import 'package:e_delivery/service/api_services.dart';
import 'package:e_delivery/widgets/delivery_note_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:searchable_listview/searchable_listview.dart';

class TrackScreen extends ConsumerStatefulWidget {
  const TrackScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrackScreenState();
}

class _TrackScreenState extends ConsumerState<TrackScreen> {
  // final TextEditingController _searchController = TextEditingController();
  APIServices? apiServices;

  List<DeliveryData>? deliveryData;
  bool _isLoading = false;

  // Add more data entries as needed...

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
        toolbarHeight: 130,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello,',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Track Your Delivery',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0,
                floating: true,
                expandedHeight: 20.h,
                backgroundColor: Colors.transparent,
                flexibleSpace: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Search Client Name",
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 20.w),
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
              ),
              _isLoading
                  ? const SliverToBoxAdapter(
                      child: Center(
                      child: CircularProgressIndicator(),
                    ))
                  : SliverList.builder(
                      itemBuilder: (context, index) {
                        return CustomOrderTaskCard(
                          customerName: deliveryData![index].customerName,
                          customerPhone: deliveryData![index].customerPhone,
                          status: deliveryData![index].status,
                          itemType: deliveryData![index].itemType,
                          destination: deliveryData![index].address,
                          itemQuantity: deliveryData![index].itemQuantity,
                          itemDescription: deliveryData![index].itemDescription,
                          noteId: deliveryData![index].id,
                        );
                      },
                      itemCount: deliveryData!.length,
                    ),
              // notes.when(data: (data) {
              //   return SliverList.builder(
              //     itemCount: deliveryData!.length,
              //     itemBuilder: ((context, index) {
              //       return CustomOrderTaskCard(
              //         customerName: deliveryData![index].customerName,
              //         customerPhone: deliveryData![index].customerPhone,
              //         status: deliveryData![index].status,
              //         itemType: deliveryData![index].itemType,
              //         destination: deliveryData![index].address,
              //       );
              //     }),
              //   );
              // }, error: (e, s) {
              //   return SliverToBoxAdapter(
              //     child: Center(
              //       child: Text(e.toString() + 'ehte'),
              //     ),
              //   );
              // }, loading: () {
              //   return
              //   );
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
