import 'package:e_delivery/constants.dart';
import 'package:e_delivery/screens/settings.dart';
import 'package:e_delivery/widgets/delivery_note_card.dart';
import 'package:e_delivery/widgets/floatingSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:searchable_listview/searchable_listview.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackScreen extends StatefulWidget {
  TrackScreen({super.key});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> data = [
    {
      "id": "1",
      "clientId": "1001",
      "staffId": "S123",
      "customerName": "John Smith",
      "receiversName": "Alice Johnson",
      "address": "123 Main Street, Cityville",
      "itemType": "Electronics",
      "estimatedDateOfDelivery": "2023-09-10",
      "itemDescription": "Smartphone",
      "itemQuantity": "1",
      "customerPhone": "+1 (555) 123-4567",
      "receiversPhone": "+1 (555) 987-6543",
      "otp": "7890",
      "signature": "Signature001.png",
      "photo": "DeliveryPhoto001.jpg",
      "attachment": "Invoice001.pdf",
      "status": "Pending",
      "createdAt": "2023-09-01 08:30:00",
      "updatedAt": "2023-09-01 08:30:00"
    },
    {
      "id": "2",
      "clientId": "1002",
      "staffId": "S124",
      "customerName": "Emily Davis",
      "receiversName": "Mark Wilson",
      "address": "456 Oak Avenue, Townsville",
      "itemType": "Clothing",
      "estimatedDateOfDelivery": "2023-09-12",
      "itemDescription": "Designer Dress",
      "itemQuantity": "2",
      "customerPhone": "+1 (555) 222-3333",
      "receiversPhone": "+1 (555) 777-8888",
      "otp": "4567",
      "signature": "Signature002.png",
      "photo": "DeliveryPhoto002.jpg",
      "attachment": "Receipt002.pdf",
      "status": "Delivered",
      "createdAt": "2023-09-02 10:15:00",
      "updatedAt": "2023-09-02 12:45:00"
    },
    {
      "id": "3",
      "clientId": "1003",
      "staffId": "S125",
      "customerName": "Sarah Brown",
      "receiversName": "Michael Taylor",
      "address": "789 Pine Lane, Villagetown",
      "itemType": "Books",
      "estimatedDateOfDelivery": "2023-09-15",
      "itemDescription": "Fantasy Novels Set",
      "itemQuantity": "5",
      "customerPhone": "+1 (555) 333-4444",
      "receiversPhone": "+1 (555) 999-0000",
      "otp": "1234",
      "signature": "Signature003.png",
      "photo": "DeliveryPhoto003.jpg",
      "attachment": "Invoice003.pdf",
      "status": "Delivered",
      "createdAt": "2023-09-03 09:45:00",
      "updatedAt": "2023-09-03 11:30:00"
    },
    {
      "id": "4",
      "clientId": "1004",
      "staffId": "S126",
      "customerName": "Robert Johnson",
      "receiversName": "Linda Martinez",
      "address": "1010 Elm Street, Suburbia",
      "itemType": "Home Appliances",
      "estimatedDateOfDelivery": "2023-09-20",
      "itemDescription": "Refrigerator",
      "itemQuantity": "1",
      "customerPhone": "+1 (555) 777-6666",
      "receiversPhone": "+1 (555) 222-1111",
      "otp": "5678",
      "signature": "Signature004.png",
      "photo": "DeliveryPhoto004.jpg",
      "attachment": "Receipt004.pdf",
      "status": "In Transit",
      "createdAt": "2023-09-04 14:20:00",
      "updatedAt": "2023-09-04 16:00:00"
    },
    // Add more data entries as needed...
  ];

  List<Map<String, dynamic>> _foundeNotes = [];

  @override
  void initState() {
    super.initState();
    _foundeNotes = data;
  }

  void _runFilter(value) {
    List<Map<String, dynamic>> _result = [];
    if (value.isEmpty) {
      _result = data;
    } else {
      _result = data
          .where((notes) =>
              notes['customerName'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundeNotes = _result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search Client Name",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search),
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
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CustomOrderTaskCard(
                    customerName: _foundeNotes[index]['customerName'],
                    customerPhone: _foundeNotes[index]['customerPhone'],
                  );
                  //
                },
                childCount: _foundeNotes.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
