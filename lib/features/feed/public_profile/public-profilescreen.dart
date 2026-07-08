import 'package:flutter/material.dart';
import 'package:hi_pseudonymous/features/feed/public_profile/repository/public_profile_repo.dart';
import 'package:hi_pseudonymous/features/feed/public_profile/widgets/public_profile.dart';
import '../../feed/widgets/post_card.dart';
import '../post/models/post_models.dart';

class PublicProfileScreen extends StatelessWidget {
  const PublicProfileScreen({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: StreamBuilder(
        stream: PublicProfileRepository.user(uid),
        builder: (context, userSnapshot) {
          if (!userSnapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final user = userSnapshot.data!;

          return Column(
            children: [

              PublicProfileHeader(
                user: user,
              ),

              Expanded(
                child: StreamBuilder<List<PostModel>>(
                  stream: PublicProfileRepository.posts(uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
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

                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (_, index) {
                        return PostCard(post: posts[index]);
                      },
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}