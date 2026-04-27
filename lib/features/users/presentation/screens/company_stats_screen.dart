import 'package:flutter/material.dart';
import 'package:hw3_app/features/users/domain/entities/company_stat.dart';

/// New screen required by Project 10.
class CompanyStatsScreen extends StatelessWidget {
  const CompanyStatsScreen({required this.stats, super.key});

  final List<CompanyStat> stats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Company Stats')),
      body: stats.isEmpty
          ? const Center(child: Text('No stats to show'))
          : ListView.builder(
              itemCount: stats.length,
              itemBuilder: (context, index) {
                final item = stats[index];
                return ListTile(
                  leading: Text('#${index + 1}'),
                  title: Text(item.companyName),
                  trailing: Text('${item.userCount} users'),
                );
              },
            ),
    );
  }
}
