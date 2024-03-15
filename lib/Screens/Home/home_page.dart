import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Models/product_model.dart';
import 'package:store_ui/Providers/ProductProviders/product_provider.dart';
import 'package:store_ui/Screens/Home/Widgets/home_category.dart';
import 'package:store_ui/Screens/Home/Widgets/home_navbar.dart';
import 'package:store_ui/Screens/Home/Widgets/home_slider.dart';
import 'package:store_ui/Screens/Product/Widgets/product_item.dart';
import 'package:store_ui/Screens/Product/product_detail_page.dart';
import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/Utils/routers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController.addListener(_scrollListener);
    if (Provider.of<ProductProvider>(context, listen: false).products.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<ProductProvider>(context, listen: false).getAllProduct();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      if (Provider.of<ProductProvider>(context, listen: false).endPage) {
        return;
      }
      Provider.of<ProductProvider>(context, listen: false).getAllProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey200,
      appBar: AppBar(
        backgroundColor: white,
        toolbarHeight: 130,
        flexibleSpace: const HomeNavbar(),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // SliverList để chứa các widget bạn muốn bổ sung trước GridView
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Trả về widget mà bạn muốn bổ sung trước GridView
                return const Column(
                  children: [
                    SizedBox(height: 5),
                    HomeSlider(),
                    HomeCategory(),
                  ],
                );
              },
              childCount: 1, // Số lượng widget bạn muốn bổ sung
            ),
          ),
          // SliverGrid để hiển thị GridView
          Consumer<ProductProvider>(
            builder: (context, productProvider, _) {
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio:
                      0.7, // Tỷ lệ giữa chiều rộng và chiều cao của mỗi item
                  // Đặt chiều cao cố định cho mỗi item
                  mainAxisExtent: 360.0, maxCrossAxisExtent: 300.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index < productProvider.products.length) {
                      final json = productProvider.products[index];
                      final product =
                          Product.fromJson(json as Map<String, dynamic>);

                      final id = product.id ?? 0;
                      final name = product.name ?? '';
                      final photo = product.photo ?? '';
                      final price = product.price;
                      final promotionPrice = product.promotionPrice;
                      final sold = product.sold ?? 0;
                      // final totalStar = product['totalStar'];
                      const totalStar = 5;
                      return ProductItem(
                        name: name,
                        photo: photo,
                        price: price,
                        promotionPrice: promotionPrice,
                        sold: sold,
                        totalStar: totalStar,
                        onTap: () {
                          PageNavigator(ctx: context).nextPage(
                            page: ProductDetailPage(productId: '$id'),
                          );
                        },
                      );
                    } else {
                      if (productProvider.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                  },
                  childCount: productProvider.isLoading
                      ? productProvider.products.length + 1
                      : productProvider.products.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
