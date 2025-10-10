import 'package:first_ui/login/provider/login_provider.dart';
import 'package:first_ui/notifications/Notification_screen_view/notification_detail_screen.dart';
import 'package:first_ui/notifications/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final username = context.read<LoginProvider>().currentUsername ?? 'guest';
      context.read<NotificationProvider>().loadNotificationsForUser(username);
    });
  }

  @override
  Widget build(BuildContext context) {
    final username = context.watch<LoginProvider>().currentUsername ?? 'guest';

    return RefreshIndicator(
      onRefresh: () => context
          .read<NotificationProvider>()
          .loadNotificationsForUser(username),
      child: Consumer<NotificationProvider>(
        builder: (context, provider, _) {
          if (provider.notifications.isEmpty) {
            return ListView(
              children: const [
                SizedBox(height: 200),
                Center(child: Text("Chưa có thông báo nào")),
              ],
            );
          }
          return ListView.builder(
            itemCount: provider.notifications.length,
            itemBuilder: (context, index) {
              final notif = provider.notifications[index];
              return Slidable(
                key: ValueKey(notif.id),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        provider.removeNotification(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đã xóa thông báo!'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Xóa',
                    ),
                  ],
                ),
                child: ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: Text(notif.message),
                  subtitle: Text(notif.createdAt),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            NotificationDetailScreen(billId: notif.billId),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
