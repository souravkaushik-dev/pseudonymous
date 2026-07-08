import 'dart:async';
import 'package:flutter/material.dart';
import '../../../home/profile/features/models/app_user.dart';
import '../repository/search_repository.dart';
import '../widgets/search_user_tile.dart';
import '../widgets/empty_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState
    extends State<SearchScreen> {

  final controller = TextEditingController();

  Timer? _debounce;

  List<AppUser> users = [];

  bool loading = false;

  Future<void> search(String value) async {

    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 300),
          () async {

        setState(() {
          loading = true;
        });

        users =
        await SearchRepository.searchUsers(
          value,
        );

        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Search"),
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: controller,
              onChanged: search,
              decoration: const InputDecoration(
                hintText:
                "Search username...",
                prefixIcon:
                Icon(Icons.search),
              ),
            ),
          ),

          Expanded(
            child: loading
                ? const Center(
              child:
              CircularProgressIndicator(),
            )
                : users.isEmpty
                ? const EmptySearch()
                : ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, index) {

                return SearchUserTile(
                  user: users[index],
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}