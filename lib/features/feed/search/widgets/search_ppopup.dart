import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hi_pseudonymous/features/home/profile/features/models/app_user.dart';

import '../repository/search_repository.dart';
import '../widgets/search_user_tile.dart';

class SearchPopup {
  SearchPopup._();

  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Search",
      barrierColor: Colors.transparent,
      transitionDuration: Duration.zero,
      pageBuilder: (_, __, ___) {
        return const _SearchDialog();
      },
    );
  }
}

class _SearchDialog extends StatefulWidget {
  const _SearchDialog();

  @override
  State<_SearchDialog> createState() =>
      _SearchDialogState();
}

class _SearchDialogState
    extends State<_SearchDialog> {
  final controller = TextEditingController();

  final focusNode = FocusNode();

  Timer? debounce;

  bool loading = false;

  List<AppUser> users = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 250),
          () {
        focusNode.requestFocus();
      },
    );
  }

  Future<void> search(String value) async {
    debounce?.cancel();

    debounce = Timer(
      const Duration(milliseconds: 300),
          () async {
        if (value.trim().isEmpty) {
          if (mounted) {
            setState(() {
              users = [];
              loading = false;
            });
          }
          return;
        }

        setState(() {
          loading = true;
        });

        final result =
        await SearchRepository.searchUsers(
          value,
        );

        if (!mounted) return;

        setState(() {
          users = result;
          loading = false;
        });
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [

          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 24,
                sigmaY: 24,
              ),
              child: Container(
                color: Colors.black.withOpacity(.18),
              ),
            ),
          ),

          Center(
            child: Container(
              width: 430,
              constraints: const BoxConstraints(
                maxHeight: 620,
              ),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surface,
                borderRadius:
                BorderRadius.circular(40),
                border: Border.all(
                  color: Colors.white.withOpacity(.08),
                ),
              ),
              child: Column(
                children: [

                  const SizedBox(height: 26),

                  Text(
                    "Search",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 22,
                    ),
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onChanged: search,
                      decoration: InputDecoration(
                        hintText:
                        "Search username...",
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                        ),
                        suffixIcon:
                        controller.text.isEmpty
                            ? null
                            : IconButton(
                          onPressed: () {
                            controller.clear();

                            setState(() {
                              users = [];
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                          ),
                        ),
                        filled: true,
                        fillColor:
                        Colors.grey.shade100,
                        border:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(
                              24),
                          borderSide:
                          BorderSide.none,
                        ),
                        enabledBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(
                              24),
                          borderSide:
                          BorderSide.none,
                        ),
                        focusedBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(
                              24),
                          borderSide:
                          BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  Expanded(
                    child: AnimatedSwitcher(
                      duration:
                      const Duration(
                        milliseconds: 250,
                      ),
                      child: loading
                          ? const Center(
                        child:
                        CircularProgressIndicator(),
                      )
                          : users.isEmpty
                          ? Column(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [

                          Icon(
                            Icons
                                .manage_search_rounded,
                            size: 80,
                            color: Colors
                                .grey.shade400,
                          ),

                          const SizedBox(
                              height: 18),

                          Text(
                            "Search people",
                            style: Theme.of(
                                context)
                                .textTheme
                                .titleMedium,
                          ),

                          const SizedBox(
                              height: 8),

                          Text(
                            "Find anyone by username",
                            style: Theme.of(
                                context)
                                .textTheme
                                .bodyMedium,
                          ),
                        ],
                      )
                          : ListView.builder(
                        padding:
                        const EdgeInsets
                            .fromLTRB(
                          18,
                          0,
                          18,
                          20,
                        ),
                        itemCount:
                        users.length,
                        itemBuilder:
                            (_, index) {
                          return SearchUserTile(
                            user:
                            users[index],
                          )
                              .animate(
                            delay:
                            Duration(
                              milliseconds:
                              index *
                                  45,
                            ),
                          )
                              .fade()
                              .moveY(
                            begin: 12,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fade(
              duration:
              180.ms,
            )
                .scale(
              begin: const Offset(
                .92,
                .92,
              ),
              curve:
              Curves.easeOutCubic,
            )
                .moveY(
              begin: 20,
              end: 0,
            ),
          ),
        ],
      ),
    );
  }
}