class UserProfile {
  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.companyName,
  });

  final int id;
  final String name;
  final String email;
  final String companyName;

  // Model class for JSON parsing.
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final String firstName = json['firstName'] as String? ?? '';
    final String lastName = json['lastName'] as String? ?? '';
    final Map<String, dynamic>? company = json['company'] as Map<String, dynamic>?;

    return UserProfile(
      id: json['id'] as int,
      name: '$firstName $lastName'.trim(),
      email: json['email'] as String? ?? '',
      companyName: company?['name'] as String? ?? 'No company',
    );
  }
}
