import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static const String baseUrl = '143.198.118.203:8000';
  static const String user = 'test';
  static const String pass = 'test2023';
  static String basicAuth = 'Basic ${base64Encode(utf8.encode('$user:$pass'))}';

  static Future<dynamic> sendRequestPost(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.http(baseUrl, endpoint);

    final response = await http.post(url, body: jsonEncode(body), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
  static Future<dynamic> sendRequestGet(String endpoint) async {
    final url = Uri.http(baseUrl, endpoint);
    final response = await http.get(url, headers: {'authorization': basicAuth});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
  static Future<dynamic> sendRequestPut(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.http(baseUrl, endpoint);
    final response = await http.put(url, body: jsonEncode(body), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to put data');
    }
  }
  static Future<dynamic> sendRequestDel(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.http(baseUrl, endpoint);
    final response = await http.delete(url, body: jsonEncode(body), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete data');
    }
  }


}