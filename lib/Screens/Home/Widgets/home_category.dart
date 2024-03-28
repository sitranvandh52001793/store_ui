import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_ui/Providers/BrandProviders/brand_provider.dart';
import 'package:store_ui/Providers/ProductProviders/product_provider.dart';
import 'package:store_ui/Styles/colors.dart';
import 'package:store_ui/Widgets/button.dart';

class HomeCategory extends StatefulWidget {
  final void Function(String)? onTap;
  final void Function(String)? selectedBrandCallback; // Thêm thuộc tính mới
  const HomeCategory({Key? key, this.onTap, this.selectedBrandCallback})
      : super(key: key);

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  int? selectedBrandId;

  Widget buildCategoryChips(dynamic brands) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: brands.map<Widget>((brand) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedBrandId = brand['id'];
                Navigator.pop(context);
              });
              if (widget.selectedBrandCallback != null) {
                widget.selectedBrandCallback!(selectedBrandId
                    .toString()); // Chuyển đổi thành chuỗi trước khi truyền vào callback
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Chip(
                label: Text(
                  brand['name'],
                  style: TextStyle(
                    color: brand['id'] == selectedBrandId ? Colors.white : null,
                  ),
                ),
                backgroundColor:
                    brand['id'] == selectedBrandId ? Colors.blue : null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

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
                },
              ),
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
                },
              ),
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
                    height: 300,
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
                                        color: Colors.grey),
                                    SizedBox(width: 8),
                                    Text(
                                      'Thương hiệu',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              FutureBuilder<dynamic>(
                                future: BrandProvider().getAllBrand(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return buildCategoryChips(snapshot.data);
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Spacer(),
                          customButton(
                            text: 'Xóa bộ lọc',
                            context: context,
                            tap: () => {
                              setState(() {
                                selectedBrandId = null;
                                Navigator.pop(context);
                              }),
                              if (widget.selectedBrandCallback != null)
                                {
                                  widget.selectedBrandCallback!('null'),
                                }
                            },
                          )
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
