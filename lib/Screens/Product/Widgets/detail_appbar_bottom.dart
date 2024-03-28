import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Providers/CartProviders/cart_provider.dart';
import 'package:store_ui/Providers/Databases/user_data_provider.dart';
import 'package:store_ui/Screens/Auth/login_page.dart';
import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/Utils/routers.dart';

class ProductDetailAppbarBottom extends StatefulWidget {
  final String productId;
  const ProductDetailAppbarBottom({super.key, required this.productId});

  @override
  State<ProductDetailAppbarBottom> createState() =>
      _ProductDetailAppbarBottomState();
}

class _ProductDetailAppbarBottomState extends State<ProductDetailAppbarBottom> {
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
              child: Icon(
                Icons.chat_bubble_outline,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child:
                Consumer<CartProvider>(builder: (context, cartProvider, child) {
              return GestureDetector(
                onTap: () {
                  UserDataProvider().isLogin().then((value) => {
                        if (value)
                          {
                            cartProvider.addProductToCart(
                                productId: widget.productId,
                                quantity: '1',
                                context: context)
                          }
                        else
                          {
                            PageNavigator(ctx: context)
                                .nextPage(page: const LoginPage())
                          }
                      });
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Icon(
                    // Icon cart
                    Icons.shopping_cart_outlined,
                    color: primaryColor,
                  ),
                ),
              );
            }),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // print(widget.productId);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
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
