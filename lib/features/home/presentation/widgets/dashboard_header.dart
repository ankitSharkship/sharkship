import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: const [
          Text(
            "Dashboard",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Spacer(),
          Icon(Icons.calendar_today_outlined),
        ],
      ),
    );
  }
}