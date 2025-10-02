class NotificationItem {
  final int? id;
  final String username;
  final String message;
  final int billId;
  final String createdAt;

  NotificationItem({
    this.id,
    required this.username,
    required this.message,
    required this.billId,
    required this.createdAt,
  });

  factory NotificationItem.fromMap(Map<String, dynamic> map) {
    return NotificationItem(
      id: map['id'] as int?,
      username: map['username'] as String,
      message: map['message'] as String,
      billId: map['billId'] as int,
      createdAt: map['createdAt'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'message': message,
      'billId': billId,
      'createdAt': createdAt,
    };
  }
}
