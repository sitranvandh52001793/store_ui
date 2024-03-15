import 'package:flutter/material.dart';

class ProductDetailAppbarBottom extends StatelessWidget {
  const ProductDetailAppbarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: const Icon(
                Icons.chat_bubble_outline,
                color: Color.fromRGBO(208, 1, 27, 1),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: const Icon(
                // Icon cart
                Icons.shopping_cart_outlined,
                color: Color.fromRGBO(208, 1, 27, 1),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(208, 1, 27, 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: const Text(
                  'Mua ngay',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
