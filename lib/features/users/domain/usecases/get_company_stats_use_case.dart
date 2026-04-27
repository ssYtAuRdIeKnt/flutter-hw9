import 'package:hw3_app/features/users/domain/entities/company_stat.dart';
import 'package:hw3_app/features/users/domain/entities/user.dart';

/// New business logic: group users by company and sort by count.
class GetCompanyStatsUseCase {
  const GetCompanyStatsUseCase();

  List<CompanyStat> call(List<User> users) {
    final counts = <String, int>{};

    for (final user in users) {
      final company = user.companyName.isEmpty ? 'No company' : user.companyName;
      counts.update(company, (value) => value + 1, ifAbsent: () => 1);
    }

    final result = counts.entries
        .map(
          (entry) =>
              CompanyStat(companyName: entry.key, userCount: entry.value),
        )
        .toList();

    result.sort((a, b) {
      final byCount = b.userCount.compareTo(a.userCount);
      if (byCount != 0) {
        return byCount;
      }
      return a.companyName.compareTo(b.companyName);
    });

    return result;
  }
}
