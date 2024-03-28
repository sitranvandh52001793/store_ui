import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Layouts/main_layout.dart';
import 'package:store_ui/Providers/CartProviders/cart_provider.dart';
import 'package:store_ui/Screens/Cart/Widget/cart_bottom_appbar.dart';
import 'package:store_ui/Utils/routers.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
// Tính toán tổng số tiền trong giỏ hàng
  double totalAmount = 0;
  calculateTotalAmount() {
    CartProvider().addListener(() {
      // Gọi phương thức getCart() để lấy danh sách sản phẩm trong giỏ hàng
      CartProvider().getCart().then((data) {
        // Nếu có dữ liệu trả về
        if (data != null) {
          // Tính tổng số tiền trong giỏ hàng
          totalAmount = 0;
          for (var item in data) {
            totalAmount += item['total'];
          }
          // Thông báo cho listeners về sự thay đổi
          setState(() {});
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // clear cart
    calculateTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cartProvider, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Giỏ hàng'),
        ),
        body: FutureBuilder<dynamic>(
          future: CartProvider().getCart(),
          builder: (context, snapshot) {
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
              final carts = snapshot.data;

              if (carts.isEmpty) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart_outlined,
                        size: 100,
                        color: Color.fromRGBO(224, 224, 224, 1),
                      ),
                      const SizedBox(height: 10),
                      // outline button
                      SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            PageNavigator(ctx: context)
                                .nextPageOnly(page: const MainLayout());
                          },
                          child: const Text('Tiếp tục mua sắm'),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: carts.length, // +1 for the coupon widget
                  itemBuilder: (context, index) {
                    final data = carts[index];
                    // final product = data['products'];r
                    final product = data['products'];

                    return Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 8),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              '${product['photo']}',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '${product['name']}',
                                    style: const TextStyle(fontSize: 14),
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
                                        'đ${data['total']}',
                                        style: const TextStyle(
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
                                          InkWell(
                                            onTap: () {
                                              // In ra kiểu dữ liệu productId
                                              cartProvider.incrementQuantity(
                                                  // CHuyển productId từ chuỗi sang int
                                                  productId: product['id'],
                                                  quantity:
                                                      data['quantity'] - 1,
                                                  context: context);
                                              calculateTotalAmount();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey[200],
                                              ),
                                              child: const Icon(Icons.remove,
                                                  size: 20),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text('${data['quantity']}',
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                          const SizedBox(width: 10),
                                          InkWell(
                                            onTap: () {
                                              // In ra kiểu dữ liệu productId
                                              cartProvider.incrementQuantity(
                                                  // CHuyển productId từ chuỗi sang int
                                                  productId: product['id'],
                                                  quantity:
                                                      data['quantity'] + 1,
                                                  context: context);
                                              calculateTotalAmount();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey[200],
                                              ),
                                              child: const Icon(Icons.add,
                                                  size: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Xác nhận'),
                                                content: const Text(
                                                  'Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng không?',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Hủy',
                                                        style: TextStyle(
                                                            fontSize: 14)),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text(
                                                      'Xóa',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    onPressed: () {
                                                      cartProvider
                                                          .deleteProductToCart(
                                                        productId:
                                                            product['id'],
                                                        context: context,
                                                      );
                                                      calculateTotalAmount();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(
                                          Icons.delete_forever_rounded,
                                          size: 30,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          },
        ),
        bottomNavigationBar:
            CartBottomAppBar(totalAmount: totalAmount.toString()),
      );
    });
  }
}
