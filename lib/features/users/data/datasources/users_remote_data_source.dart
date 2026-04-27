import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hw3_app/features/users/data/models/user_dto.dart';

/// Data layer API client. Works only with DTO objects.
class UsersRemoteDataSource {
  static const _url = 'https://dummyjson.com/users?limit=20';

  Future<List<UserDto>> fetchUsers() async {
    final response = await http.get(
      Uri.parse(_url),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Request failed: ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final users = decoded['users'] as List<dynamic>;
    return users
        .map((item) => UserDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
