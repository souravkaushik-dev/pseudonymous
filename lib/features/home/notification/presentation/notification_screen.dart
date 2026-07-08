import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../model/notification_model.dart';
import '../model/notification_repository.dart';
import '../widgets/empty_notification.dart';
import '../widgets/notification_car.dart';
import '../widgets/notification_header.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

bool selectionMode = false;

final Set<String> selectedIds = {};

class _NotificationScreenState
    extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();

    NotificationRepository.markAllRead();
  }

  Future<void> deleteSelected() async {
    await NotificationRepository.deleteMany(selectedIds);

    setState(() {
      selectedIds.clear();
      selectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            NotificationHeader(
              selectionMode: selectionMode,
              selectedCount: selectedIds.length,
              onSelect: () {
                setState(() {
                  selectionMode = true;
                });
              },
              onDelete: deleteSelected,
              onCancel: () {
                setState(() {
                  selectionMode = false;
                  selectedIds.clear();
                });
              },
            ),

            SizedBox(height: 18.h),

            Expanded(
              child: StreamBuilder<List<AppNotification>>(
                stream:
                NotificationRepository.notifications(),

                builder: (context, snapshot) {

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    );
                  }

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child:
                      CircularProgressIndicator(),
                    );
                  }

                  final notifications =
                      snapshot.data ?? [];

                  if (notifications.isEmpty) {
                    return const NotificationEmpty();
                  }

                  return ListView.separated(
                    padding: EdgeInsets.fromLTRB(
                      20.w,
                      0,
                      20.w,
                      24.h,
                    ),

                    itemCount:
                    notifications.length,

                    separatorBuilder:
                        (_, __) => SizedBox(
                      height: 14.h,
                    ),

                    itemBuilder: (_, index) {
                      final notification = notifications[index];

                      return GestureDetector(
                        onLongPress: () {
                          setState(() {
                            selectionMode = true;
                            selectedIds.add(notification.id);
                          });
                        },
                        onTap: () {
                          if (!selectionMode) return;

                          setState(() {
                            if (selectedIds.contains(notification.id)) {
                              selectedIds.remove(notification.id);
                            } else {
                              selectedIds.add(notification.id);
                            }

                            if (selectedIds.isEmpty) {
                              selectionMode = false;
                            }
                          });
                        },
                        child: NotificationCard(
                          notification: notification,
                          selectionMode: selectionMode,
                          selected: selectedIds.contains(notification.id),

                          onLongPress: () {
                            setState(() {
                              selectionMode = true;
                              selectedIds.add(notification.id);
                            });
                          },

                          onTap: () async {
                            if (selectionMode) {
                              setState(() {
                                if (selectedIds.contains(notification.id)) {
                                  selectedIds.remove(notification.id);
                                } else {
                                  selectedIds.add(notification.id);
                                }

                                if (selectedIds.isEmpty) {
                                  selectionMode = false;
                                }
                              });
                              return;
                            }

                            await NotificationRepository.markRead(notification.id);

                            // Navigate if needed
                          },
                        ),
                      );
                    },
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