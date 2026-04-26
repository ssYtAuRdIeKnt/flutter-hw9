import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hw3_app/models/user_profile.dart';

class UserApiService {
  // Open API endpoint with real public data
  static const String _url = 'https://dummyjson.com/users?limit=20';

  // Networking logic uses Future + async/await
  Future<List<UserProfile>> fetchUsers() async {
    final response = await http.get(
      Uri.parse(_url),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Request failed: ${response.statusCode}');
    }

    final Map<String, dynamic> decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic> users = decoded['users'] as List<dynamic>;
    return users
        .map((item) => UserProfile.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
