import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hi_pseudonymous/features/feed/folloe/repository/follow_repository.dart';
import 'package:hi_pseudonymous/features/feed/folloe/repository/follow_type.dart';
import 'package:hi_pseudonymous/features/feed/folloe/widgets/follow_user_tile.dart';

class FollowListScreen extends StatelessWidget {
  const FollowListScreen({
    super.key,
    required this.uid,
    required this.title,
    required this.type,
  });

  final String uid;
  final String title;
  final FollowType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(
                18,
                18,
                18,
                16,
              ),
              child: Row(
                children: [

                  InkWell(
                    borderRadius:
                    BorderRadius.circular(100),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall,
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fade()
                .moveY(begin: -15),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon:
                  const Icon(Icons.search),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            )
                .animate()
                .fade(delay: 120.ms),

            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<List<String>>(
                stream: FollowRepository.ids(
                  uid: uid,
                  type: type,
                ),
                builder: (context, snapshot) {

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child:
                      CircularProgressIndicator(),
                    );
                  }

                  final ids = snapshot.data!;

                  if (ids.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [

                          const Icon(
                            Icons.people_outline,
                            size: 80,
                          ),

                          const SizedBox(height: 20),

                          Text(
                            "No $title yet",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge,
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {},
                    child: ListView.builder(
                      padding:
                      const EdgeInsets.only(
                        bottom: 30,
                      ),
                      itemCount: ids.length,
                      itemBuilder: (_, index) {

                        return StreamBuilder(
                          stream:
                          FollowRepository.user(
                            ids[index],
                          ),
                          builder:
                              (context, userSnap) {

                            if (!userSnap.hasData) {
                              return const SizedBox();
                            }

                            return FollowUserTile(
                              user:
                              userSnap.data!,
                              index: index,
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}