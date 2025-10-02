import 'package:flutter/material.dart';
import 'package:first_ui/database/database_helper.dart';

class NotificationDetailScreen extends StatelessWidget {
  final int billId;
  const NotificationDetailScreen({Key? key, required this.billId})
      : super(key: key);

  Future<Map<String, dynamic>> _loadBill() async {
    final db = await DatabaseHelper.database();
    final billRows =
        await db.query("bills", where: "id = ?", whereArgs: [billId]);
    final detailRows = await db
        .query("bill_details", where: "billId = ?", whereArgs: [billId]);
    return {"bill": billRows.first, "details": detailRows};
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

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ngày tạo: ${bill["createdAt"]}"),
                Text("Tổng tiền: \$${bill["total"]}"),
                const SizedBox(height: 20),
                const Text("Chi tiết:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
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
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
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
