import 'package:flutter/material.dart';
import '../post/models/post_models.dart';
import '../post/repository/post_repostory.dart';
import '../widgets/feed_header.dart';
import '../widgets/post_card.dart' show PostCard;


class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<PostModel>>(
          stream: PostRepository.feed(),
          builder: (context, snapshot) {

            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final posts = snapshot.data ?? [];

            if (posts.isEmpty) {
              return const Center(
                child: Text("No posts yet"),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {},
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: posts.length + 1,
                itemBuilder: (context, index) {

                  if (index == 0) {
                    return const FeedHeader();
                  }

                  return PostCard(
                    post: posts[index - 1],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}