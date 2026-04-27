import 'package:hw3_app/features/users/domain/entities/user.dart';

/// DTO from API. Converts raw JSON into domain entity.
class UserDto {
  const UserDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.companyName,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String companyName;

  factory UserDto.fromJson(Map<String, dynamic> json) {
    final company = json['company'] as Map<String, dynamic>?;
    return UserDto(
      id: json['id'] as int,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      companyName: company?['name'] as String? ?? 'No company',
    );
  }

  User toEntity() {
    return User(
      id: id,
      name: '$firstName $lastName'.trim(),
      email: email,
      companyName: companyName,
    );
  }
}
