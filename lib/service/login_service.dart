import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginService {
  Future loginStaff() async {
    try {
      var post = await http.post(
          Uri.parse('https://emmanuelosmanbangra.link/e-delivery/login.php'),
          body: jsonEncode({'phone': '75730450', 'password': '123'}),
          headers: {
            'Content-Type': 'application/json', // Set content type to JSON
            'Accept': 'application/json', // Set accept type to JSON
          });
      var res = post.body;
      var de = jsonDecode(res);
      // var jsn = Staff.fromJson(de);
      // print(jsn.data![0].phone);
      return de;
    } catch (e) {
      // print(e.toString());
    }
    // return res;
  }
}
