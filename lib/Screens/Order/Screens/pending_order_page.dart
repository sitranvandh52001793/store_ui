import 'package:flutter/material.dart';
import 'package:store_ui/Providers/OrderProviders/order_provider.dart';
import 'package:store_ui/Screens/Order/Screens/product_order_page.dart';
import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/Utils/helpers.dart';
import 'package:store_ui/Utils/routers.dart';

class PendingOrderPage extends StatefulWidget {
  const PendingOrderPage({super.key});

  @override
  State<PendingOrderPage> createState() => _PendingOrderPageState();
}

class _PendingOrderPageState extends State<PendingOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chờ xác nhận'),
        ),
        body: FutureBuilder<dynamic>(
            future: OrderProvider().getAllOrder(context: context),
            builder: (context, snapshot) {
              // Lọc ra các order có status là pending
              if (snapshot.hasData) {
                final List<Map<String, dynamic>> orders =
                    List<Map<String, dynamic>>.from(snapshot.data);

                // Lọc ra các đơn hàng có status là 'pending'
                final pendingOrders = orders
                    .where((order) => order['status'] == 'pending')
                    .toList();

                return ListView.builder(
                  itemCount: pendingOrders.length,
                  itemBuilder: (context, index) {
                    final order = pendingOrders[index];
                    return GestureDetector(
                      onTap: () => PageNavigator(ctx: context).nextPage(
                          page: ProductOrderPage(orderId: order['id'])),
                      child: Card(
                        child: ListTile(
                          title: Text('Mã đơn hàng #${order['id']}'),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Ngày đặt ${convertDateString(order['createdAt'])}'),
                              const SizedBox(height: 4),
                              Text(
                                'Tổng tiền: ${order['finalTotal']}',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          trailing: const Text(
                            'Hủy đơn',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Center(
                    child: Text('Chưa có đơn nào chờ xác nhận'),
                  ),
                );
              }
            }));
  }
}
