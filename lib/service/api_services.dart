import 'dart:convert';
import 'dart:io';

import 'package:e_delivery/domain/models/delivery_note_model.dart';
import 'package:e_delivery/domain/models/staff_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
// import '../domain/models/staff_model.dart';

final repositoryProvider = Provider((ref) {
  return APIServices();
});

class APIServices {
  Future loginStaff(email, password) async {
    Data staffData = Data(email: email, password: password);
    try {
      var post = await http.post(
          Uri.parse('https://emmanuelosmanbangra.link/e-delivery/login.php'),
          body: jsonEncode(staffData.toJson()),
          headers: {
            'Content-Type': 'application/json', // Set content type to JSON
            'Accept': 'application/json', // Set accept type to JSON
          });
      if (post.statusCode == 200) {
        var res = post.body;
        var de = jsonDecode(res);
        if (de['response'] == 'Successfully') {
          var data = de['data'] as List;
          List<Data> staff = data.map((e) => Data.fromJson(e)).toList();
          return staff;
        } else {
          return "Invalid Credentials";
        }
      } else {
        return post.statusCode;
      }
    } catch (e) {
      print(e.toString());
    }
    // return res;
  }

  Future fetchDeliveryNote(clientId, staffId) async {
    Data staffData = Data(clintId: clientId.toString(), id: staffId.toString());

    try {
      var post = await http.post(
          Uri.parse(
              'https://emmanuelosmanbangra.link/e-delivery/delivery_note.php'),
          body: jsonEncode(staffData.toJson()),
          headers: {
            'Content-Type': 'application/json', // Set content type to JSON
            'Accept': 'application/json', // Set accept type to JSON
          });
      if (post.statusCode == 200) {
        var res = post.body;
        var de = jsonDecode(res);
        if (de['response'] == 'Successfully') {
          var data = de['data'] as List;
          List<DeliveryData> deliveryData =
              data.map((e) => DeliveryData.fromJson(e)).toList();
          // return deliveryData;
          if (deliveryData.isNotEmpty) {
            return deliveryData
                .where((element) => element.status == 'Pending')
                .toList();
          }
        } else {
          return "No Order Found";
        }
      } else {
        return post.statusCode;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future fetchCompletedDeliveryNote(clientId, staffId) async {
    Data staffData = Data(clintId: clientId.toString(), id: staffId.toString());

    try {
      var post = await http.post(
          Uri.parse(
              'https://emmanuelosmanbangra.link/e-delivery/delivery_note.php'),
          body: jsonEncode(staffData.toJson()),
          headers: {
            'Content-Type': 'application/json', // Set content type to JSON
            'Accept': 'application/json', // Set accept type to JSON
          });
      if (post.statusCode == 200) {
        var res = post.body;
        var de = jsonDecode(res);
        if (de['response'] == 'Successfully') {
          var data = de['data'] as List;
          List<DeliveryData> deliveryData =
              data.map((e) => DeliveryData.fromJson(e)).toList();
          if (deliveryData.isNotEmpty) {
            return deliveryData
                .where((element) => element.status == 'Completed')
                .toList();
          }

          // return deliveryData;
        } else {
          return "No Order Found";
        }
      } else {
        return post.statusCode;
      }
    } catch (e) {
      print(e.toString());
    }
  }

//  Send code for alternate receiver
  Future sendOTPcode(String phone, String receiverName, String staffId,
      String noteId, String clientId) async {
    // Create a map for the data to be sent in the request
    Map<String, dynamic> data = {
      'id': noteId,
      'receiversPhone': phone,
      'receiversName': receiverName,
      'staffId': staffId,
      'clintId': clientId,
    };

    try {
      final response = await http.put(
        Uri.parse('https://emmanuelosmanbangra.link/e-delivery/send_otp.php'),
        body: jsonEncode(data), // Convert data to JSON
        headers: {
          'Content-Type': 'application/json', // Set content type to JSON
          'Accept': 'application/json', // Set accept type to JSON
        },
      );
      if (response.statusCode == 200) {
        // Successful response
        final responseBody = jsonDecode(response.body);
        if (responseBody.isNotEmpty && responseBody['data'][0]['id'] != null) {
          return "OTP Sent";
        } else {
          return "Note Sent";
        }
      } else {
        // Request failed with an error status code
        print('Request failed with status code: ${response.statusCode}');
        return null; // You might want to handle this error case differently
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error sending OTP: $e');
      return null; // You might want to handle this error case differently
    }
  }

  // Send code for client
  Future sendOTPcode2(String phone, String clientName, String staffId,
      String noteId, String clientId) async {
    // Create a map for the data to be sent in the request
    Map<String, dynamic> data = {
      'id': noteId,
      'receiversPhone': phone,
      'receiversName': clientName,
      'staffId': staffId,
      'clintId': clientId,
    };

    try {
      final response = await http.put(
        Uri.parse('https://emmanuelosmanbangra.link/e-delivery/send_otp.php'),
        body: jsonEncode(data), // Convert data to JSON
        headers: {
          'Content-Type': 'application/json', // Set content type to JSON
          'Accept': 'application/json', // Set accept type to JSON
        },
      );
      if (response.statusCode == 200) {
        // Successful response
        final responseBody = jsonDecode(response.body);
        if (responseBody.isNotEmpty && responseBody['data'][0]['id'] != null) {
          return "OTP Sent";
        } else {
          return "Note Sent";
        }
      } else {
        // Request failed with an error status code
        print('Request failed with status code: ${response.statusCode}');
        return null; // You might want to handle this error case differently
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error sending OTP: $e');
      return null; // You might want to handle this error case differently
    }
  }

  Future confirmOTP(noteId, otp) async {
    Map<String, dynamic> data = {
      'id': noteId,
      'otp': otp,
    };

    try {
      final response = await http.post(
        Uri.parse('https://emmanuelosmanbangra.link/e-delivery/send_otp.php'),
        body: jsonEncode(data), // Convert data to JSON
        headers: {
          'Content-Type': 'application/json', // Set content type to JSON
          'Accept': 'application/json', // Set accept type to JSON
        },
      );
      if (response.statusCode == 200) {
        // Successful response
        final responseBody = jsonDecode(response.body);
        if (responseBody['response'] == 'valid') {
          return 'Valid';
        } else {
          return 'Invalid OTP';
        }
      } else {
        // Request failed with an error status code
        print('Request failed with status code: ${response.statusCode}');
        return null; // You might want to handle this error case differently
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error sending OTP: $e');
      return null; // You might want to handle this error case differently
    }
  }

  Future updateNote12(File photo, ValueNotifier<String?> signature,
      String staffId, String noteId, String clientId) async {
    // Create a map for the data to be sent in the request
    Map<String, dynamic> data = {
      'id': noteId,
      'phote': photo,
      'signature': signature.value,
      'staff_id': staffId,
      'clint_id': clientId,
    };

    try {
      final response = await http.put(
        Uri.parse(
            'https://emmanuelosmanbangra.link/e-delivery/delivery_note.php'),
        body: jsonEncode(data), // Convert data to JSON
        headers: {
          'Content-Type': 'application/json', // Set content type to JSON
          'Accept': 'application/json', // Set accept type to JSON
        },
      );
      if (response.statusCode == 200) {
        // Successful response
        final responseBody = jsonDecode(response.body);
        if (responseBody.isNotEmpty &&
            responseBody['data'][0]['status'] == 'Completed') {
          return "Confirmed";
        } else {
          return "Not Confirmed";
        }
      } else {
        // Request failed with an error status code
        print('Request failed with status code: ${response.statusCode}');
        return null; // You might want to handle this error case differently
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error updating: $e');
      return null; // You might want to handle this error case differently
    }
  }

  Future updateNote(File photo, ValueNotifier<String?> signature,
      String staffId, String noteId, String clientId) async {
    try {
      // Read the file as bytes
      // var filename = photo.path.split('/').last;

      var photoBytes = await photo.readAsBytes();

      // Convert the bytes to base64
      String photoBase64 = base64Encode(photoBytes);

      // Create a map for the data to be sent in the request
      // Map<String, dynamic> data = ;

      final response = await http.post(
        Uri.parse(
            'https://emmanuelosmanbangra.link/e-delivery/update_note.php'),
        body: {
          'id': noteId,
          'phote': photoBase64, // Include the base64-encoded photo
          'signature': signature.value, // Assuming signature is a String
          'staff_id': staffId,
          'clint_id': clientId, // Correct the typo in client_id
        }, // Convert data to JSON
        // headers: {
        //   'Content-Type': 'application/json', // Set content type to JSON
        //   'Accept': 'application/json', // Set accept type to JSON
        // },
      );

      if (response.statusCode == 200) {
        // Successful response
        print(response.body);

        // Parse the response data based on your API's response structure
        // Example: if the response is a JSON object with a 'status' field
        final responseBody = jsonDecode(response.body);
        if (responseBody['data']['status'] == 'Completed') {
          return "Confirmed";
        } else {
          return "Not Confirmed";
        }
      } else {
        // Request failed with an error status code
        print('Request failed with status code: ${response.statusCode}');
        return null; // You might want to handle this error case differently
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error updating: $e');
      return null; // You might want to handle this error case differently
    }
  }

  Future updateNote4(photo, ValueNotifier<String?> signature, String staffId,
      String noteId, String clientId) async {
    // Create a multipart request
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(
          'https://emmanuelosmanbangra.link/e-delivery/delivery_note.php'),
    );

    // Add form fields
    request.fields['id'] = noteId;
    request.fields['signature'] =
        signature.value!; // Assuming signature is a String
    request.fields['staff_id'] = staffId;
    request.fields['clint_id'] = clientId;

    // Add the photo file
    var photoStream = http.ByteStream(photo.openRead());
    var photoLength = await photo.length();

    var photoMultipartFile = http.MultipartFile(
      'phote',
      photoStream,
      photoLength,
      filename: 'phote.jpg', // Change the filename as needed
      // contentType: MediaType('image', 'jpeg'), // Set the content type correctly
      // contentType: request.headers['Content-Type'],
      contentType: MediaType('image', 'jpg'),
    );

    request.files.add(photoMultipartFile);

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print(response.stream.toString());
        // Successful response
        var responseBody = await response.stream.bytesToString();
        print(responseBody);

        // var parsedResponse = jsonDecode(responseBody);
        // if (parsedResponse.isNotEmpty &&
        //     parsedResponse['data'][0]['status'] == 'Completed') {
        //   return "Confirmed";
        // } else {
        //   return "Not Confirmed";
        // }
      } else {
        // Request failed with an error status code
        print('Request failed with status code: ${response.statusCode}');
        return null; // You might want to handle this error case differently
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error updating: $e');
      return null; // You might want to handle this error case differently
    }
  }
}
