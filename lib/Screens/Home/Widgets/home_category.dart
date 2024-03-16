import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Providers/ProductProviders/product_provider.dart';

import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/Widgets/button.dart';

class HomeCategory extends StatefulWidget {
  final void Function(String)? onTap; // Định nghĩa thuộc tính hàm onSubmitted
  const HomeCategory({super.key, this.onTap});

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                return GestureDetector(
                  onTap: () => widget.onTap!('desc'),
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      // Border bottom
                      border: Border(
                        bottom: BorderSide(
                          width: 2.5,
                          color: productProvider.active == 'active_order'
                              ? primaryColor
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.fiber_new,
                          color: Color.fromARGB(255, 226, 74, 74),
                          size: 30,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Mới nhất',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(66, 66, 66, 1)),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                );
              }),
              Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                return GestureDetector(
                  onTap: () => widget.onTap!('sold'),
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      // Border bottom
                      border: Border(
                        bottom: BorderSide(
                          width: 2.5,
                          color: productProvider.active == 'active_sort_by'
                              ? primaryColor
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.sell_rounded,
                          color: Colors.blue,
                          size: 30,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Bán chạy',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(66, 66, 66, 1)),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    height: 500,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Row(
                                  children: [
                                    Icon(Icons.window_sharp,
                                        color:
                                            Colors.grey), // Icon nằm bên trái
                                    SizedBox(
                                        width:
                                            8), // Khoảng cách giữa icon và chữ
                                    Text(
                                      'Danh mục',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Wrap(
                                  children: [
                                    Chip(
                                      label: Text('Giày thể thao'),
                                    ),
                                    SizedBox(width: 10),
                                    Chip(
                                      label: Text('Giày sneaker'),
                                    ),
                                    SizedBox(width: 10),
                                    Chip(
                                      label: Text('Dép nam'),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Row(
                                  children: [
                                    Icon(Icons.branding_watermark,
                                        color:
                                            Colors.grey), // Icon nằm bên trái
                                    SizedBox(
                                        width:
                                            8), // Khoảng cách giữa icon và chữ
                                    Text(
                                      'Thương hiệu',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Wrap(
                                  children: [
                                    Chip(
                                      label: Text('Nike'),
                                    ),
                                    SizedBox(width: 10),
                                    Chip(
                                      label: Text('Adidas'),
                                    ),
                                    SizedBox(width: 10),
                                    Chip(
                                      label: Text('Puma'),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          customButton(text: 'Áp dụng', context: context)
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                // Border bottom
                border: Border(
                  bottom: BorderSide(
                    width: 2.5,
                    color: Colors.transparent,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.filter_alt_sharp,
                    color: grey,
                    size: 30,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Bộ lọc',
                    style: TextStyle(
                        fontSize: 13, color: Color.fromRGBO(66, 66, 66, 1)),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
