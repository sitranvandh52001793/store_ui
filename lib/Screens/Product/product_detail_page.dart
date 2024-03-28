import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Models/product_model.dart';
import 'package:store_ui/Providers/CartProviders/cart_provider.dart';
import 'package:store_ui/Providers/ProductProviders/product_provider.dart';
import 'package:store_ui/Screens/Product/Widgets/detail_appbar_bottom.dart';
import 'package:store_ui/Styles/colors.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sản phẩm'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -8),
              showBadge: true,
              ignorePointer: false,
              badgeContent: Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                return Text(
                  cartProvider.totalCart.toString(),
                  style: TextStyle(color: white, fontSize: 10),
                );
              }),
              badgeAnimation: const badges.BadgeAnimation.slide(
                animationDuration: Duration(seconds: 1),
                colorChangeAnimationDuration: Duration(seconds: 1),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<Product>(
          future: ProductProvider().getProductById(id: widget.productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                var discountPercentageFinal = '';
                final product = snapshot.data;

                final promotionPrice = product!.promotionPrice;
                final price = product.price;
                if (promotionPrice != null && price != null) {
                  final discountPercentage =
                      ((price - promotionPrice) / price) * 100;
                  discountPercentageFinal =
                      discountPercentage.toStringAsFixed(2);
                }

                return Container(
                  color: Colors.grey[200],
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                CarouselSlider(
                                  items: [
                                    //1st Image of Slider
                                    Image.network(
                                      '${product.photo}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ],

                                  //Slider Container properties
                                  //carousel Slider flutter
                                  options: CarouselOptions(
                                    height: 280.0,
                                    autoPlay: false,
                                    aspectRatio: 16 / 9,
                                    enableInfiniteScroll: true,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        'đ${product.promotionPrice}',
                                        style: const TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'đ${product.price}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, bottom: 20),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          '-${discountPercentageFinal.toString()}%',
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    '${product.name}',
                                    style: const TextStyle(fontSize: 17),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      (product.totalStar!.isEmpty)
                                          ? const Text(
                                              'Chưa có lượt đánh giá',
                                              style: TextStyle(fontSize: 15),
                                            )
                                          : Row(
                                              children: [
                                                for (int i = 1; i <= 5; i++)
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: 20,
                                                  ),
                                                const SizedBox(width: 3),
                                                const Text('5.0',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                    )),
                                              ],
                                            ),

                                      const SizedBox(width: 10),
                                      // Line
                                      Container(
                                        height: 20,
                                        width: 1,
                                        color: Colors.grey[300],
                                      ),
                                      const SizedBox(width: 10),

                                      Text(
                                        'Đã bán ${product.sold}+',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // Line
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  height: 1,
                                  color: Colors.grey[300],
                                ),
                                Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    208, 1, 27, 1),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: const Icon(
                                                Icons.replay_outlined,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 3),
                                            const Text(
                                              'Miễn phí trả hàng',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    208, 1, 27, 1),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: const Icon(
                                                Icons.verified,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              'Chính hãng 100%',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    208, 1, 27, 1),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: const Icon(
                                                Icons.replay_outlined,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 3),
                                            const Text(
                                              'Giao miễn phí',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          // Chi tiết sản phẩm
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            color: Colors.white,
                            padding: const EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 5),
                                  child: const Text(
                                    'Chi tiết sản phẩm',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                // line
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  height: 0.5,
                                  color: Colors.grey[300],
                                ),

                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 0, bottom: 100),
                                  child: HtmlWidget(
                                    product.description!,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('Error'));
              }
            }
          }),
      bottomNavigationBar:
          ProductDetailAppbarBottom(productId: widget.productId),
    );
  }
}
