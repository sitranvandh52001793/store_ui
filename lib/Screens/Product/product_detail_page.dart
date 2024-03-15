import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:store_ui/Screens/Product/Widgets/detail_appbar_bottom.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sản phẩm'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: Container(
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
                          Image.asset(
                            'assets/images/pro.png',
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Text(
                              'đ2.000.000',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'đ2.500.000',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 10, bottom: 20),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                '-20%',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Điện thoại Samsung Galaxy A52 8GB/256GB - Hàng Chính Hãng Điện thoại AL cam kết hàng chính hãng, nguyên seal, bảo hành 12 tháng. Đổi trả trong 7 ngày nếu có lỗi từ nhà sản xuất.',
                          style: TextStyle(fontSize: 17),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                for (int i = 1; i <= 5; i++)
                                  const Icon(
                                    Icons.star,
                                    color: Color.fromRGBO(208, 1, 27, 1),
                                    size: 20,
                                  ),
                                const SizedBox(width: 5),
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

                            const Text(
                              'Đã bán 1000+',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      // Line
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(208, 1, 27, 1),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Icon(
                                      Icons.replay_outlined,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    'Miễn phí trả hàng',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(208, 1, 27, 1),
                                      borderRadius: BorderRadius.circular(100),
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
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(208, 1, 27, 1),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Icon(
                                      Icons.replay_outlined,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    'Giao miễn phí',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
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
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
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
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 0.5,
                        color: Colors.grey[300],
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Column(
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Màn hình: Super AMOLED, 6.5", Full HD+\nHệ điều hành: Android 11\nCamera sau: Chính 64 MP & Phụ 12 MP, 5 MP, 5 MP\nCamera trước: 32 MP\nCPU: Snapdragon 720G 8 nhân\nRAM: 8 GB\nBộ nhớ trong: 256 GB\nDung lượng pin: 4500 mAh, sạc nhanh 25W',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Image.asset(
                              'assets/images/phone.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: const ProductDetailAppbarBottom(),
    );
  }
}
