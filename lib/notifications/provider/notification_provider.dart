import 'package:first_ui/notifications/model/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:first_ui/database/database_helper.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationItem> _notifications = [];
  List<NotificationItem> get notifications => _notifications;

  Future<void> loadNotificationsForUser(String username) async {
    final rows = await DatabaseHelper.queryWhere(
      "notifications",
      "username = ?",
      [username],
    );
    _notifications = rows
        .map((row) => NotificationItem.fromMap(row))
        .toList()
        .reversed
        .toList();
    notifyListeners();
  }

  Future<void> addNotification(NotificationItem notification) async {
    await DatabaseHelper.insert("notifications", notification.toMap());
    await loadNotificationsForUser(notification.username);
  }

  Future<void> clearAllForUser(String username) async {
    final db = await DatabaseHelper.database();
    await db
        .delete("notifications", where: 'username = ?', whereArgs: [username]);
    await loadNotificationsForUser(username);
  }

  Future<void> removeNotification(int index) async {
    if (index >= 0 && index < _notifications.length) {
      final notif = _notifications[index];
      final db = await DatabaseHelper.database();

      await db.delete(
        'notifications',
        where: 'id = ?',
        whereArgs: [notif.id],
      );

      _notifications.removeAt(index);
      notifyListeners();
    }
  }
}
