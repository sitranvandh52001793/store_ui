import 'package:flutter/material.dart';
import 'package:store_ui/Styles/colors.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final String photo;
  final dynamic price;
  final dynamic promotionPrice;
  final int sold;
  final int totalStar;
  final Function()? onTap;

  const ProductItem({
    super.key,
    required this.name,
    required this.photo,
    required this.price,
    required this.promotionPrice,
    required this.sold,
    required this.totalStar,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.123),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  photo,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'đ$promotionPrice',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'đ$price',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Row(
                          children: [
                            for (var i = 0; i < 5; i++)
                              Icon(
                                Icons.star,
                                color: Colors.amber[600],
                                size: 13,
                              )
                          ],
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '$sold (lượt)',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(
                          Icons.delivery_dining,
                          color: Colors.green,
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Đã bán $sold+',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
