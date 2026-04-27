/// Domain entity used by presentation and business logic.
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.companyName,
  });

  final int id;
  final String name;
  final String email;
  final String companyName;
}
