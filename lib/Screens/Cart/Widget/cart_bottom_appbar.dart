import 'package:flutter/material.dart';
import 'package:store_ui/Screens/Order/Screens/confirm_order_page.dart';
import 'package:store_ui/Utils/routers.dart';
import 'package:store_ui/Widgets/button.dart';

class CartBottomAppBar extends StatelessWidget {
  final String totalAmount;
  const CartBottomAppBar({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      height: 140,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Text(
                  'Tổng tiền',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4C53A5),
                  ),
                ),
                const Spacer(),
                Text(
                  'đ$totalAmount',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            child: Center(
              child: customButton(
                text: 'Đặt hàng',
                context: context,
                tap: () => PageNavigator(ctx: context)
                    .nextPage(page: const ConfirmOrderPage()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
