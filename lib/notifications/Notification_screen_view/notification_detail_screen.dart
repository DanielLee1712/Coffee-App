import 'package:flutter/material.dart';
import 'package:first_ui/database/database_helper.dart';
import 'package:style_packet/app_text_styles.dart';

class NotificationDetailScreen extends StatelessWidget {
  final int billId;
  const NotificationDetailScreen({Key? key, required this.billId})
      : super(key: key);

  Future<Map<String, dynamic>> _loadBill() async {
    final db = await DatabaseHelper.database();
    final billRows =
        await db.query("bills", where: "id = ?", whereArgs: [billId]);
    final bill = billRows.first;
    final detailRows = await db
        .query("bill_details", where: "billId = ?", whereArgs: [billId]);
    return {
      "bill": billRows.first,
      "details": detailRows,
      "username": bill["username"],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chi tiết hoá đơn #$billId")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _loadBill(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final bill = snapshot.data!["bill"];
          final details =
              snapshot.data!["details"] as List<Map<String, dynamic>>;
          final user = snapshot.data!["username"];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ngày tạo: ${bill["createdAt"]}"),
                Text("Tổng tiền: \$${bill["total"]}"),
                Text("Người mua: $user"),
                const SizedBox(height: 20),
                const Text("Chi tiết:", style: AppTextStyles.bodyStrong),
                Expanded(
                  child: ListView.builder(
                    itemCount: details.length,
                    itemBuilder: (context, index) {
                      final item = details[index];
                      return ListTile(
                        title: Text("SP #${item["productId"]}"),
                        subtitle: Text("SL: ${item["quantity"]}"),
                        trailing: Text(
                          "\$${item["price"]}",
                          style: AppTextStyles.price.s(16),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
