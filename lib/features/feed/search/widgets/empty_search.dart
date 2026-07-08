import 'package:flutter/material.dart';

class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            Icons.search,
            size: 60,
          ),

          SizedBox(height: 16),

          Text(
            "Search users by username",
          ),
        ],
      ),
    );
  }
}