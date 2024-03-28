import 'package:flutter/material.dart';
import 'package:store_ui/Providers/CartProviders/cart_provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: CartProvider().getCart(),
        builder: (context, snapshot) {
          final carts = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            if (carts.isEmpty) {
              return const Center(
                child: Text('No item in cart'),
              );
            } else {
              return Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 8),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        fillColor: MaterialStateProperty.all(Colors.red),
                        value: true, // Giá trị ban đầu của checkbox
                        onChanged: (newValue) {
                          // Xử lý khi trạng thái của checkbox thay đổi
                        },
                      ),
                      Image.network(
                          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2hvZXN8ZW58MHx8MHx8fDA%3D',
                          width: 80),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text(
                              'Nubia Neo 5G 256GB 12GB RAM 64MP hahahhaha hahha ahahhah aha',
                              style: TextStyle(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[200],
                              ),
                              child: const Text(
                                'Phân loại',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'đ2.00.000',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey[500],
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const Text(
                                  'đ1.00.000',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 5),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey[200],
                                      ),
                                      child: const Icon(Icons.remove, size: 20),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text('1',
                                        style: TextStyle(fontSize: 16)),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey[200],
                                      ),
                                      child: const Icon(Icons.add, size: 20),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Icon(Icons.delete_forever_rounded,
                                    size: 30, color: Colors.grey[500]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        });
  }
}
